package com.shanjupay.transaction.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.shanjupay.common.cache.Cache;
import com.shanjupay.common.domain.BusinessException;
import com.shanjupay.common.domain.CommonErrorCode;
import com.shanjupay.common.util.JsonUtil;
import com.shanjupay.common.util.RedisUtil;
import com.shanjupay.transaction.api.PayChannelService;
import com.shanjupay.transaction.api.dto.PayChannelDTO;
import com.shanjupay.transaction.api.dto.PayChannelParamDTO;
import com.shanjupay.transaction.api.dto.PlatformChannelDTO;
import com.shanjupay.transaction.convert.PayChannelParamConvert;
import com.shanjupay.transaction.convert.PlatformChannelConvert;
import com.shanjupay.transaction.entity.AppPlatformChannel;
import com.shanjupay.transaction.entity.PayChannelParam;
import com.shanjupay.transaction.entity.PlatformChannel;
import com.shanjupay.transaction.mapper.AppPlatformChannelMapper;
import com.shanjupay.transaction.mapper.PayChannelParamMapper;
import com.shanjupay.transaction.mapper.PlatformChannelMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;


import java.util.List;

/**
 * @author Lidadaibiao
 * @date 2020/6/7 - 12:03
 */
@org.apache.dubbo.config.annotation.Service
public class PayChannelServiceImpl implements PayChannelService {
    @Autowired
    private PlatformChannelMapper platformChannelMapper;

    @Autowired
    private AppPlatformChannelMapper appPlatformChannelMapper;

    @Autowired
    private PayChannelParamMapper payChannelParamMapper;


    @Autowired
    Cache cache;
    /**
     * 获取平台服务类型具体实现
     * @return
     * @throws BusinessException
     */
    @Override
    public List<PlatformChannelDTO> queryPlatformChannel() throws BusinessException {
        List<PlatformChannel> platformChannels = platformChannelMapper.selectList(null);

        return PlatformChannelConvert.INSTANCE.listentity2listdto(platformChannels);
    }

    /**
     * 为app绑定平台服务类型
     * @param appId 应用id平台服务类型列表
     * @param platformChannelCodes
     */
    @Override
    public void bindPlatformChannelForApp(String appId, String platformChannelCodes) {
        //根据id和平台code查询 看是否存在 如果不存在则插入
        AppPlatformChannel appPlatformChannel = appPlatformChannelMapper.selectOne(new LambdaQueryWrapper<AppPlatformChannel>().eq(
                AppPlatformChannel::getAppId,appId
        ).eq(
                AppPlatformChannel::getPlatformChannel,platformChannelCodes
        ));
        if (appPlatformChannel==null)
        {
           AppPlatformChannel entity = new AppPlatformChannel();
           entity.setAppId(appId);
           entity.setPlatformChannel(platformChannelCodes);
            appPlatformChannelMapper.insert(entity);
        }

    }

    /**
     *  应用是否已经绑定了某个服务类型
     * @param appId
     * @param platformChannelCodes
     * @return已绑定返回1，否则 返回0
     * @throws BusinessException
     */
    @Override
    public int queryAppBindPlatformChannel(String appId, String platformChannelCodes) throws BusinessException {
        AppPlatformChannel appPlatformChannel = appPlatformChannelMapper.selectOne(new LambdaQueryWrapper<AppPlatformChannel>()
                .eq(AppPlatformChannel::getAppId,appId)
                .eq(AppPlatformChannel::getPlatformChannel,platformChannelCodes));
        if (appPlatformChannel!=null){
            return 1;
        }



        return 0;
    }





    @Override
    public List<PayChannelDTO> queryPayChannelByPlatformChannel(String platformChannelCode) throws BusinessException {
        List<PayChannelDTO> payChannelDTOS =  platformChannelMapper.selectPayChannelByPlatformChannel(platformChannelCode);

        return payChannelDTOS;
    }

    /**
     *  保存支付渠道参数
     * @param payChannelParamDTO 商户原始支付渠道参数
     * @throws BusinessException
     */
    @Override
    public void createPayChannelParam(PayChannelParamDTO payChannelParamDTO) throws BusinessException {
        //数据验证
        if (payChannelParamDTO==null|| StringUtils.isBlank(payChannelParamDTO.getAppId())||
                StringUtils.isBlank(payChannelParamDTO.getChannelName())||
                StringUtils.isBlank(payChannelParamDTO.getPayChannel())||
                StringUtils.isBlank(payChannelParamDTO.getPlatformChannelCode()))
        {
            throw  new BusinessException(CommonErrorCode.E_300009);
        }

        //根据appid和和服务类型查询应用与服务类型和绑定Id
        Long  appPlatformChannelId =  selectIdByAppPlatformChannel(payChannelParamDTO.getAppId(),payChannelParamDTO.getPlatformChannelCode());

        if (appPlatformChannelId==null)
        {
            //应用未绑定该服务类型不可进行支付渠道参数配置
            throw new BusinessException(CommonErrorCode.E_300010);
        }
        //根据应用与服务类型绑定id和支付渠道查询参数信息
        PayChannelParam  payChannelParam =payChannelParamMapper.selectOne(new LambdaQueryWrapper<PayChannelParam>()
                .eq(PayChannelParam::getAppPlatformChannelId,appPlatformChannelId)
                .eq(PayChannelParam::getPayChannel,payChannelParamDTO.getPayChannel()));

        if (payChannelParam!=null)
        {
            //如果查出来。则更新
            payChannelParam.setChannelName(payChannelParamDTO.getChannelName());
            payChannelParam.setParam(payChannelParamDTO.getParam());
            payChannelParamMapper.updateById(payChannelParam);
        }else{
            //添加新配置
            PayChannelParam entity = PayChannelParamConvert.INSTANCE.dto2entity(payChannelParamDTO);
            entity.setId(null);
            entity.setAppPlatformChannelId(appPlatformChannelId);
            payChannelParamMapper.insert(entity);
        }
        //顺便添加到缓存中
        updateCache(payChannelParamDTO.getAppId(),payChannelParamDTO.getPlatformChannelCode());

    }

    /**
     * 获取指定应用指定服务类型下所包含的原始支付渠道参数列表
     * @param appIp 应用id
     * @param platformChannel 服务类型代码 shanju_b2c
     * @return
     * @throws BusinessException
     */
    @Override
    public List<PayChannelParamDTO> queryPayChannelParamByAppAndPlatform(String appIp, String platformChannel) throws BusinessException {
        //设置rediskey
        String redisKey = RedisUtil.keyBuilder(appIp,platformChannel);
        //查找redisKey看是否有缓存
        Boolean exist = cache.exists(redisKey);
        if (exist) {
            //根据key查找出value值
            String value = cache.get(redisKey);
            //将value转换成list
            //List<PayChannelParamDTO> payChannelParamDTOS = JsonUtil.jsonToList(value);
            //将valueJson字符串转换成对xiang
            List<PayChannelParamDTO> paramDTOS = JSONObject.parseArray(value,PayChannelParamDTO.class);
            return paramDTOS;
        }

        //根据应用id和服务类型查询应用与服务类型和绑定Id
        Long  appPlatformChannelId = selectIdByAppPlatformChannel(appIp,platformChannel);
        //根据应用与服务类型和绑定Id查出原始祝福渠道参数列表
        List<PayChannelParam> payChannelParamList =  payChannelParamMapper.selectList(new LambdaQueryWrapper<PayChannelParam>()
                .eq(PayChannelParam::getAppPlatformChannelId,appPlatformChannelId));

        //存入缓存
        updateCache(appIp,platformChannel);
        return PayChannelParamConvert.INSTANCE.listentity2listdto(payChannelParamList);
    }

    /**
     *获取指定应用指定服务类型下所包含的某个原始支付参数
     * @param appIp 应用ip
     * @param platformChannel 服务类型代码  shanju_b2c
     * @param payChannel  实际渠道代码 WX_JSAPI
     * @return
     * @throws BusinessException
     */
    @Override
    public PayChannelParamDTO queryParamByAppPlatformAndPayChannel(String appIp, String platformChannel, String payChannel) throws BusinessException {
       //根据原始支付渠道参数列表查出包含实际渠道代码 的原始支付参数
        List<PayChannelParamDTO> payChannelParamDTOS =   queryPayChannelParamByAppAndPlatform(appIp,platformChannel);
        //遍历查找
        for (PayChannelParamDTO payChannelParamDTO : payChannelParamDTOS) {
            if (payChannelParamDTO.getPayChannel().equals(payChannel)){
                return payChannelParamDTO;
            }
        }
        return null;
    }


    /**
     * 根据应用id和服务类型查询应用与服务类型和绑定Id
     * @param appId 应用id
     * @param platformChannelCode 服务类型
     * @return
     */
    private Long selectIdByAppPlatformChannel(String appId,String platformChannelCode)
    {
        //根据appid和服务类型查询应用与服务类型绑定id
      AppPlatformChannel appPlatformChannel = appPlatformChannelMapper.selectOne(
        new LambdaQueryWrapper<AppPlatformChannel>().eq(AppPlatformChannel::getAppId,appId)
                .eq(AppPlatformChannel::getPlatformChannel,platformChannelCode));
        if (appPlatformChannel!=null){
            return appPlatformChannel.getId();
        }
        return null;
    }

    /**
     * 向redis中更新的操作
     * @param appId
     * @param platformChannel
     */
    private void updateCache(String appId,String platformChannel)
    {
        //处理redis缓存，
        //构建key 如：SJ_PAY_PARAM:b910da455bc84514b324656e1088320b:shanju_c2b 
        String redisKey = RedisUtil.keyBuilder(appId,platformChannel);
        //查询redis 看是否存在 存在即删除
        Boolean flag = cache.exists(redisKey);
        if (flag)
        {
            cache.del(redisKey);
        }
        //从数据库中查询应用的服务类型对应的实际参数，并重新存入缓存
       //会出现递归 List<PayChannelParamDTO> payChannelParamDTOS =  queryPayChannelParamByAppAndPlatform(appId,platformChannel);
        Long  appPlatformChannelId =  selectIdByAppPlatformChannel(appId,platformChannel);
        if (appPlatformChannelId != null){
            List<PayChannelParam> payChannelParamList =  payChannelParamMapper.selectList(new LambdaQueryWrapper<PayChannelParam>()
                    .eq(PayChannelParam::getAppPlatformChannelId,appPlatformChannelId));
            List<PayChannelParamDTO> payChannelParamDTOS = PayChannelParamConvert.INSTANCE.listentity2listdto(payChannelParamList);
            //将payChannelParamDTOS转成json串存入redis
            cache.set(redisKey, JsonUtil.listTojson(payChannelParamDTOS).toString());
        }

    }
}
