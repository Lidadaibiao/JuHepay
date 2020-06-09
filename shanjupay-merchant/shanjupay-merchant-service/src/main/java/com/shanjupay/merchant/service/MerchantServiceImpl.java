package com.shanjupay.merchant.service;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.shanjupay.common.domain.BusinessException;
import com.shanjupay.common.domain.CommonErrorCode;
import com.shanjupay.common.util.PhoneUtil;
import com.shanjupay.merchant.api.MerchantService;
import com.shanjupay.merchant.api.dto.MerchantDTO;
import com.shanjupay.merchant.api.dto.StaffDTO;
import com.shanjupay.merchant.api.dto.StoreDTO;
import com.shanjupay.merchant.convert.MerchantCovert;
import com.shanjupay.merchant.convert.StaffConvert;
import com.shanjupay.merchant.convert.StoreConvert;
import com.shanjupay.merchant.entity.Merchant;
import com.shanjupay.merchant.entity.Staff;
import com.shanjupay.merchant.entity.Store;
import com.shanjupay.merchant.entity.StoreStaff;
import com.shanjupay.merchant.mapper.MerchantMapper;
import com.shanjupay.merchant.mapper.StaffMapper;
import com.shanjupay.merchant.mapper.StoreMapper;
import com.shanjupay.merchant.mapper.StoreStaffMapper;
import com.shanjupay.user.api.TenantService;
import com.shanjupay.user.api.dto.tenant.CreateTenantRequestDTO;
import com.shanjupay.user.api.dto.tenant.TenantDTO;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.dubbo.config.annotation.Reference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author Lidadaibiao
 * @date 2020/6/2 - 21:17
 */
@org.apache.dubbo.config.annotation.Service
@Slf4j //添加日志记录
public class MerchantServiceImpl implements MerchantService {

    @Autowired
    MerchantMapper merchantMapper;

    @Autowired
    StoreMapper storeMapper;

    @Autowired
    StaffMapper staffMapper;


    @Reference
    TenantService tenantService;
    @Override
    public MerchantDTO queryMerchantById(Long id) {
        Merchant merchant = merchantMapper.selectById(id);
       /* MerchantDTO merchantDTO = new MerchantDTO();
        merchantDTO.setId(merchant.getId());
        merchantDTO.setMerchantName(merchant.getMerchantName());*/
        //....
        return MerchantCovert.INSTANCE.etity2dto(merchant);
    }



    /**
     *
     * 注册商务服务接口，接收账号，密码，电话号码，为了扩展性所以采用DTO形式
     *
     * 商户注册
     * @param merchantDTO 商务注册的信息
     * @return 注册成功后的商户信息
     */
    @Override
    @Transactional
    public MerchantDTO createMerchant(MerchantDTO merchantDTO) {
        //校验参数的合法性
        if(merchantDTO == null){
            throw new BusinessException(CommonErrorCode.E_100108);
        }
        if(StringUtils.isBlank(merchantDTO.getMobile())){
            throw new BusinessException(CommonErrorCode.E_100112);
        }
        if(StringUtils.isBlank(merchantDTO.getPassword())){
            throw new BusinessException(CommonErrorCode.E_100111);
        }
        //手机号格式校验
        if(!PhoneUtil.isMatches(merchantDTO.getMobile())){
            throw new BusinessException(CommonErrorCode.E_100109);
        }
        //校验手机号的唯一性
        //根据手机号查询商户表，如果存在记录则说明手机号已存在
        Integer count = merchantMapper.selectCount(new LambdaQueryWrapper<Merchant>().eq(Merchant::getMobile, merchantDTO.getMobile()));
        if(count>0){
            throw new BusinessException(CommonErrorCode.E_100113);
        }

        //调用SaaS接口
        //构建调用参数
        /**
         1、手机号

         2、账号

         3、密码

         4、租户类型：shanju-merchant

         5、默认套餐：shanju-merchant

         6、租户名称，同账号名

         */
        CreateTenantRequestDTO createTenantRequestDTO = new CreateTenantRequestDTO();
        createTenantRequestDTO.setMobile(merchantDTO.getMobile());
        createTenantRequestDTO.setUsername(merchantDTO.getUsername());
        createTenantRequestDTO.setPassword(merchantDTO.getPassword());
        createTenantRequestDTO.setTenantTypeCode("shanju-merchant");//租户类型
        createTenantRequestDTO.setBundleCode("shanju-merchant");//套餐，根据套餐进行分配权限
        createTenantRequestDTO.setName(merchantDTO.getUsername());//租户名称，和账号名一样

        //如果租户在SaaS已经存在，SaaS直接 返回此租户的信息，否则进行添加
        TenantDTO tenantAndAccount = tenantService.createTenantAndAccount(createTenantRequestDTO);
        //获取租户的id
        if(tenantAndAccount == null || tenantAndAccount.getId() == null){
            throw new BusinessException(CommonErrorCode.E_200012);
        }
        //租户的id
        Long tenantId = tenantAndAccount.getId();

        //租户id在商户表唯一
        //根据租户id从商户表查询，如果存在记录则不允许添加商户
        Integer count1 = merchantMapper.selectCount(new LambdaQueryWrapper<Merchant>().eq(Merchant::getTenantId, tenantId));
        if(count1>0){
            throw new BusinessException(CommonErrorCode.E_200017);
        }


//        Merchant merchant = new Merchant();
//        merchant.setMobile(merchantDTO.getMobile());
        //..写入其它属性
        //使用MapStruct进行对象转换
        Merchant merchant = MerchantCovert.INSTANCE.dto2etity(merchantDTO);
        //设置所对应的租户的Id
        merchant.setTenantId(tenantId);
        //审核状态为0-未进行资质申请
        merchant.setAuditStatus("0");
        //调用mapper向数据库写入记录
        merchantMapper.insert(merchant);

        //新增门店
        StoreDTO storeDTO = new StoreDTO();
        storeDTO.setStoreName("根门店");
        storeDTO.setMerchantId(merchant.getId());//商户id
        StoreDTO store = createStore(storeDTO);

        //新增员工
        StaffDTO staffDTO = new StaffDTO();
        staffDTO.setMobile(merchantDTO.getMobile());//手机号
        staffDTO.setUsername(merchantDTO.getUsername());//账号
        staffDTO.setStoreId(store.getId());//员所属门店id
        staffDTO.setMerchantId(merchant.getId());//商户id

        StaffDTO staff = createStaff(staffDTO);

        //为门店设置管理员
        bindStaffToStore(store.getId(),staff.getId());

        //将dto中写入新增商户的id
//        merchantDTO.setId(merchant.getId());
        //将entity转成dto
        return MerchantCovert.INSTANCE.etity2dto(merchant);
    }


    /**
     * 资质申请接口实现
     * @param merchantId 商户ID
     * @param merchantDTO 资质申请信息
     * @throws BusinessException
     */
    @Override
    @Transactional
    public void applyMerchant(Long merchantId, MerchantDTO merchantDTO) throws BusinessException {
        //校验
        //传入参数是否为空
        if(merchantDTO==null||merchantId==null)
        {
            throw new BusinessException(CommonErrorCode.E_100108);
        }
        //校验merchantId合法性，查询商户表，如果查询不到记录，认为非法
        Merchant merchant = merchantMapper.selectById(merchantId);

        if(merchant==null)
        {
            throw new BusinessException(CommonErrorCode.E_110003);
        }

        //dto--->etity
        merchant = MerchantCovert.INSTANCE.dto2etity(merchantDTO);
        //将重要 必要的参数设置到entity中
        //entity.setId(merchantId);
        merchant.setId(merchantDTO.getId());
        merchant.setMobile(merchantDTO.getMobile());
        merchant.setAuditStatus("1");//审核状态需要改变 变为1
        merchant.setTenantId(merchantDTO.getTenantId());
        //更新数据库
        merchantMapper.updateById(merchant);

    }

    /**
     * 商户新增门店
     * @param storeDTO 门店信息
     * @return
     * @throws BusinessException
     */
    @Override
    public StoreDTO createStore(StoreDTO storeDTO) throws BusinessException {
        Store store =  StoreConvert.INSTANCE.dto2entity(storeDTO);
        log.info("商户下新增门店："+ JSON.toJSONString(store));
        //插入
        storeMapper.insert(store);
        return StoreConvert.INSTANCE.entity2dto(store);

    }

    /**
     * 新增员工
     * @param staffDTO
     * @return
     */
    @Override
    public StaffDTO createStaff(StaffDTO staffDTO) {
        //校验一波
        //检验一下手机号格式和手机号是否存在
        String mobile =  staffDTO.getMobile();
        if (StringUtils.isBlank(mobile))
        {
            throw new BusinessException(CommonErrorCode.E_100112);
        }
        //根据商户iD和手机验证唯一性
        if (isExistStaffByMobile(mobile,staffDTO.getMerchantId()))
        {
            throw  new BusinessException(CommonErrorCode.E_100113);
        }
        //检验用户名是否为空
        if (StringUtils.isBlank(staffDTO.getUsername()))
        {
            throw new BusinessException(CommonErrorCode.E_100110);
        }
        //根据商户id和用户名检验唯一性
        if (isExistStaffByUserName(staffDTO.getMerchantId(),staffDTO.getUsername()))
        {
            throw new BusinessException(CommonErrorCode.E_100114);
        }

        Staff staff = StaffConvert.INSTANCE.dto2entity(staffDTO);
        log.info("商户下新增员工"+JSON.toJSONString(staff));
        staffMapper.insert(staff);
        return StaffConvert.INSTANCE.entity2dto(staff);
    }

    @Autowired
    StoreStaffMapper storeStaffMapper;
    /**
     * 为门店设置管理员
     * @param storeId 商店ID
     * @param staffId 员工ID
     */
    @Override
    public void bindStaffToStore(Long storeId, Long staffId) {
        StoreStaff storeStaff = new StoreStaff();
        storeStaff.setStaffId(staffId);
        storeStaff.setStoreId(storeId);
        storeStaffMapper.insert(storeStaff);
    }

    /**
     * 查询租户下的商店
     * @param tenantId
     * @return
     */
    @Override
    public MerchantDTO queryMerchantByTenantId(Long tenantId) {

        Merchant merchant = merchantMapper.selectOne(new LambdaQueryWrapper<Merchant>()
                .eq(Merchant::getTenantId,tenantId));
        return MerchantCovert.INSTANCE.etity2dto(merchant);
    }

    /**
     * 根据用户名和id查找是否存在
     * @param merchantId
     * @param username
     * @return
     */
    private boolean isExistStaffByUserName(Long merchantId, String username) {

       int count =  staffMapper.selectCount(new LambdaQueryWrapper<Staff>()
                .eq(Staff::getMerchantId,merchantId)
                .eq(Staff::getUsername,username));
        return count>0;

    }

    /**
     * 根据商户Id和手机号码查找是否存在
     * @param mobile
     * @param merchantId
     * @return
     */
    private boolean isExistStaffByMobile(String mobile, Long merchantId) {
        return staffMapper.selectCount(new LambdaQueryWrapper<Staff>()
                .eq(Staff::getMobile,mobile)
                .eq(Staff::getMerchantId,merchantId))>0;
    }
}
