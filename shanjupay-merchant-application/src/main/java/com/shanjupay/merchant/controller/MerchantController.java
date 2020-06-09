package com.shanjupay.merchant.controller;

import com.shanjupay.common.domain.BusinessException;
import com.shanjupay.common.domain.CommonErrorCode;
import com.shanjupay.common.util.PhoneUtil;
import com.shanjupay.merchant.api.MerchantService;
import com.shanjupay.merchant.api.dto.MerchantDTO;
import com.shanjupay.merchant.common.util.SecurityUtil;
import com.shanjupay.merchant.convert.MerchantDetailConvert;
import com.shanjupay.merchant.convert.MerchantRegisterConvert;
import com.shanjupay.merchant.service.FileService;
import com.shanjupay.merchant.service.SmsServiceImpl;
import com.shanjupay.merchant.vo.MerchantDetailVO;
import com.shanjupay.merchant.vo.MerchantRegisterVO;
import io.swagger.annotations.*;
import org.apache.commons.lang3.StringUtils;
import org.apache.dubbo.config.annotation.Reference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.UUID;

/**
 * @author Lidadaibiao
 * @date 2020/6/2 - 21:38
 */
@Api(value = "商户平台。。。",tags = "商户平台。。。",description = "商户平台。。。")
@RestController
public class MerchantController {



    @Autowired //注入本地服务
    private SmsServiceImpl smsService;
    @Reference  //注入远程服务
    private MerchantService merchantService;
    @Autowired
    private FileService fileService;


    @GetMapping("/merchants/{id}")
    public MerchantDTO queryMerchantById(@PathVariable("id")Long id)
    {
        MerchantDTO merchantDTO =   merchantService.queryMerchantById(id);
        return merchantDTO;
    }

    @ApiOperation("获取登录用户信息")
    @GetMapping(value = "/my/merchants")
    public MerchantDTO getMyMerchantInfo()
    {
        Long merchantId = SecurityUtil.getMerchantId();
        MerchantDTO merchantDTO = merchantService.queryMerchantById(merchantId);
        return merchantDTO;
    }

    @ApiOperation("商户资质申请")
    @ApiImplicitParams(
            {
                    @ApiImplicitParam(value = "商户认证资料",name = "merchantInfo",required = true,dataType = "MerchantDetailVO",paramType = "body")
            }
    )
    @PostMapping("/my/merchants/save")
    //使用@RequestBody是因为传入数据要转换成JSON  后面的VO
    public void saveMerchant(@RequestBody MerchantDetailVO merchantInfo)
    {
    //Bearer eyJtZXJjaGFudElkIjoxMjY4NDAxOTQ5ODkwOTI0NTQ1fQ==
        //解析token获得商户ID
        Long merchantId = SecurityUtil.getMerchantId();
        //vo--->dto
        MerchantDTO merchantDTO =    MerchantDetailConvert.INSTANCE.vo2dto(merchantInfo);
        merchantDTO.setId(merchantId);
        merchantService.applyMerchant(merchantId,merchantDTO);
    }



    @ApiOperation(value = "文件上传")
    @PostMapping("/upload")
    public String upload(@ApiParam(value = "上传的文件",required = true)@RequestParam("file")MultipartFile file) throws IOException {
        //文件原始名字
        String original =   file.getOriginalFilename();
        //拿到扩展名
        String suffix  = original.substring(original.lastIndexOf(".")-1);

        String filename = UUID.randomUUID()+suffix;

        //
        return fileService.upload(file.getBytes(),filename);

    }





    /**
     * 定义一个获取验证码接口 供前端调用
     */
    @ApiOperation("获取手机验证码")
    @GetMapping("/sms")
    @ApiImplicitParam(name = "phone",value = "手机号",required = true,type = "string",paramType = "query")
    public String getSMSCode(@RequestParam String phone)
    {
        //...
        return smsService.sendMsg(phone);
    }


    /**
     *
     */
    @ApiOperation("注册商户")
    @ApiImplicitParam(name="merchantRegisterVO",value = "注册信息",required = true,dataType ="MerchantRegisterVO",paramType = "body")
    @PostMapping("/merchants/register")
    //
    public MerchantRegisterVO registerMerchant(@RequestBody MerchantRegisterVO merchantRegister){
       //校验
        //传过来的对象是否是空置
        if(merchantRegister==null){
            throw new BusinessException(CommonErrorCode.E_100108);
        }
        //校验手机号为空
        if(StringUtils.isBlank(merchantRegister.getMobile()))
        {
            throw new BusinessException(CommonErrorCode.E_100112);
        }
        //校验手机号格式
        if(!PhoneUtil.isMatches(merchantRegister.getMobile()))
        {
            throw new BusinessException(CommonErrorCode.E_100109);
        }
        //校验用户名
        if(StringUtils.isBlank(merchantRegister.getUsername()))
        {
            throw new BusinessException(CommonErrorCode.E_100110);
        }
        //校验密码
        if (StringUtils.isBlank(merchantRegister.getPassword())){
            throw new BusinessException(CommonErrorCode.E_100111);
        }
        //校验验证码为空
        if(StringUtils.isBlank(merchantRegister.getVerifiyCode()))
        {
            throw new BusinessException(CommonErrorCode.E_100103);
        }




        //校验
        smsService.checkVerifiyCode(merchantRegister.getVerifiykey(),merchantRegister.getVerifiyCode());

        //注册商户
    /*    MerchantDTO merchantDTO = new MerchantDTO();
        merchantDTO.setMobile(merchantRegister.getMobile());
        merchantDTO.setUsername(merchantDTO.getUsername());
        merchantDTO.setPassword(merchantDTO.getPassword());*/
        //mapstruct优化 vo-dto
        MerchantDTO merchantDTO = MerchantRegisterConvert.INSTANCE.vo2dto(merchantRegister);

        merchantService.createMerchant(merchantDTO);
        return merchantRegister;
    }
}
