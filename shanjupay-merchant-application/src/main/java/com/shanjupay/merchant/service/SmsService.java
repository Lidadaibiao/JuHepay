package com.shanjupay.merchant.service;

import com.shanjupay.common.domain.BusinessException;

/**
 *
 * 为了方便程序复用
 * 创建SmsService 为控制层服务
 * @author Lidadaibiao
 * @date 2020/6/3 - 17:08
 */
public interface SmsService {

    /**
     * 获取短信验证码
     * @param phone  前端传进来的号码
     * @return
     */
    String sendMsg(String phone);

    /**
     * 校验验证码
     * @param verifiyKey  验证码对应的KEY
     * @param verifiyCode 验证码
     *
     * 校验自定义异常
     */
    void checkVerifiyCode(String verifiyKey,String verifiyCode)throws BusinessException;
}
