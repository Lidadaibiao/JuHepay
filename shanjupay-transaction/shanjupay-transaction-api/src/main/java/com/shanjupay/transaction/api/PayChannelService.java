package com.shanjupay.transaction.api;

import com.shanjupay.common.domain.BusinessException;
import com.shanjupay.transaction.api.dto.PayChannelDTO;
import com.shanjupay.transaction.api.dto.PayChannelParamDTO;
import com.shanjupay.transaction.api.dto.PlatformChannelDTO;

import java.util.List;

/**
 *  支付渠道服务 管理平台支付渠道，原始支付渠道，以及相关配置
 * @author Lidadaibiao
 * @date 2020/6/7 - 12:00
 */

public interface PayChannelService {

    /**
     * 获取平台服务类型
     * @return
     * @throws BusinessException
     */
    List<PlatformChannelDTO> queryPlatformChannel()throws BusinessException;


    /**
     * 为app绑定平台服务类型
     * @param appId 应用id平台服务类型列表
     * @param platformChannelCodes
     */
    void bindPlatformChannelForApp(String appId,String platformChannelCodes)throws BusinessException;


    /**
     *  应用是否已经绑定了某个服务类型
     * @param appId
     * @param platformChannelCodes
     * @return已绑定返回1，否则 返回0
     * @throws BusinessException
     */
    int queryAppBindPlatformChannel(String appId,String platformChannelCodes)throws BusinessException;

    /**
     * 根据平台服务类型获取支付渠道列表
     * @return
     * @throws BusinessException
     */

    List<PayChannelDTO> queryPayChannelByPlatformChannel(String platformChannelCode)throws BusinessException;

    /**
     * 保存支付渠道参数
     * @param payChannelParamDTO 商户原始支付渠道参数
     * @throws BusinessException
     */

    void createPayChannelParam(PayChannelParamDTO payChannelParamDTO)throws BusinessException;

    /**
     * 获取指定应用指定服务类型下所包含的原始支付渠道参数列表
     * @param appIp 应用id
     * @param platformChannel 服务类型代码 shanju_b2c
     * @return
     * @throws BusinessException
     */
    List<PayChannelParamDTO> queryPayChannelParamByAppAndPlatform(String appIp,String platformChannel)throws BusinessException;

    /**
     * 获取指定应用指定服务类型下所包含的某个原始支付参数
     * @param appIp 应用ip
     * @param platformChannel 服务类型代码  shanju_b2c
     * @param payChannel  实际渠道代码 WX_JSAPI
     * @return
     * @throws BusinessException
     */
    PayChannelParamDTO queryParamByAppPlatformAndPayChannel(String appIp,String platformChannel,String payChannel)throws BusinessException;


}
