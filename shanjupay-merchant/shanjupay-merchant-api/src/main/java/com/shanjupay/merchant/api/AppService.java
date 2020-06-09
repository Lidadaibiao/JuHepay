package com.shanjupay.merchant.api;

import com.shanjupay.common.domain.BusinessException;
import com.shanjupay.merchant.api.dto.AppDTO;

import java.util.List;

/**
 *
 * 应用接口
 * @author Lidadaibiao
 * @date 2020/6/5 - 1:22
 */
public interface AppService {


    /**
     * 商户下创建应用
     * @param merchantId  商户ID
     * @param app 应有信息
     * @return 创建应用的信息
     */
    AppDTO createApp(Long merchantId,AppDTO app)throws BusinessException;

    /**
     * 查询商户下的应用列表
     * @param merchantId
     * @return
     * @throws BusinessException
     */
    List<AppDTO>  queryAppByMerchant(Long merchantId)throws BusinessException;

    /**
     * 根据业务id查询应用
     * @param id
     * @return
     * @throws BusinessException
     */
    AppDTO getAppById(String id)throws BusinessException;

}
