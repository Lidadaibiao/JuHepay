package com.shanjupay.merchant.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.shanjupay.common.domain.BusinessException;
import com.shanjupay.common.domain.CommonErrorCode;
import com.shanjupay.common.util.RandomUuidUtil;
import com.shanjupay.merchant.api.AppService;
import com.shanjupay.merchant.api.dto.AppDTO;
import com.shanjupay.merchant.convert.AppCovert;
import com.shanjupay.merchant.entity.App;
import com.shanjupay.merchant.entity.Merchant;
import com.shanjupay.merchant.mapper.AppMapper;
import com.shanjupay.merchant.mapper.MerchantMapper;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.UUID;

/**
 * 应用接口实现类
 * @author Lidadaibiao
 * @date 2020/6/5 - 1:24
 */
@org.apache.dubbo.config.annotation.Service
public class AppServiceImpl implements AppService {

    @Autowired
    private AppMapper appMapper;

    @Autowired
    private MerchantMapper merchantMapper;
    /**
     * 商户创建应用实现类
     * @param merchantId  商户ID
     * @param app 应有信息
     * @return 创建应用后的信息
     */
    @Override
    public AppDTO createApp(Long merchantId, AppDTO app) {
        //校验商户是否通过资质审核
        Merchant merchant =  merchantMapper.selectById(merchantId);
        if(merchant==null)
        {
            throw new BusinessException(CommonErrorCode.E_200002);
        }
        if(!"2".equals(merchant.getAuditStatus())){
            throw new BusinessException(CommonErrorCode.E_200003);
        }
        if (isExistAppName(app.getAppName())){
            throw new BusinessException(CommonErrorCode.E_200004);
        }

        //保存应用信息
        //appid需要随机生成 保证不重复
        app.setAppId(RandomUuidUtil.getUUID());
        app.setMerchantId(merchant.getId());
        //dto--->entity
        App entity = AppCovert.INSTANCE.dto2entity(app);
        //插入数据库
        appMapper.insert(entity);
        //再将Appdto返回
        return AppCovert.INSTANCE.entity2dto(entity);
    }

    /**
     * 根据商户ID 查询商户下面的应用服务
     * @param merchantId
     * @return
     * @throws BusinessException
     */
    @Override
    public List<AppDTO> queryAppByMerchant(Long merchantId) throws BusinessException {

        List<App> apps = appMapper.selectList(new QueryWrapper<App>().lambda().eq(App::getMerchantId,merchantId));
        return  AppCovert.INSTANCE.listentity2dto(apps);
    }

    /**
     * 根据应用ID 查询应用信息
     * @param id
     * @return
     * @throws BusinessException
     */
    @Override
    public AppDTO getAppById(String id) throws BusinessException {
        App app = appMapper.selectOne(new QueryWrapper<App>().lambda().eq(App::getAppId,id));
        return AppCovert.INSTANCE.entity2dto(app);
    }

    /**
     * 检验用户名是否已经使用
     * @param appname
     * @return
     */
    private Boolean isExistAppName(String appname)
    {
        return appMapper.selectCount(new QueryWrapper<App>().lambda().eq(App::getAppName,appname))>0;
    }
}
