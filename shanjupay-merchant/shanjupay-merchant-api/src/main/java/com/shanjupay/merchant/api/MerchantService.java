package com.shanjupay.merchant.api;

import com.shanjupay.common.domain.BusinessException;
import com.shanjupay.merchant.api.dto.MerchantDTO;
import com.shanjupay.merchant.api.dto.StaffDTO;
import com.shanjupay.merchant.api.dto.StoreDTO;

/**
 * 接口
 * @author Lidadaibiao
 * @date 2020/6/2 - 21:17
 */
public interface MerchantService {

    //根据 id查询商户
    public MerchantDTO queryMerchantById(Long id);

    /**
     *
     * 注册商务服务接口，接收账号，密码，电话号码，为了扩展性所以采用DTO形式
     *
     * 商户注册
     * @param merchantDTO 商务注册的信息
     * @return 注册成功后的商户信息
     */
    MerchantDTO createMerchant(MerchantDTO merchantDTO);

    /**
     * 资质申请
     * @param merchantId 商户ID
     * @param merchantDTO 资质申请信息
     * @throws BusinessException
     */
    void applyMerchant(Long merchantId,MerchantDTO merchantDTO)throws BusinessException;


    /**
     *  商户下新增门店
     * @param storeDTO 门店信息
     * @return
     * @throws BusinessException
     */
    StoreDTO createStore(StoreDTO storeDTO)throws BusinessException;

    /**
     * 新增员工
     * @param staffDTO
     * @return
     */
    StaffDTO createStaff(StaffDTO staffDTO);


    /**
     * 为门店设置管理员
     * @param storeId 商店ID
     * @param staffId 员工ID
     */
    void bindStaffToStore(Long storeId,Long staffId);

    /**
     * 查询租户下的商店
     * @param tenantId
     * @return
     */
    MerchantDTO queryMerchantByTenantId(Long tenantId)throws new BusinessException;
}
