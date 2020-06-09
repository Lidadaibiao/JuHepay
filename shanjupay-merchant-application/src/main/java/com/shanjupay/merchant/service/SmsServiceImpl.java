package com.shanjupay.merchant.service;

import com.alibaba.fastjson.JSON;
import com.shanjupay.common.domain.BusinessException;
import com.shanjupay.common.domain.CommonErrorCode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

/**
 * 编写接口实现方法
 * @author Lidadaibiao
 * @date 2020/6/3 - 17:10
 */
@org.springframework.stereotype.Service
@Slf4j //加入日志记录注解
public class SmsServiceImpl implements SmsService{

    @Value("${sms.url}")
    private String smsUrl;//通过value注解将配置文件中值付给smsUrl

    @Value("${sms.effectiveTime}")
    private String effectiveTime;//通过value注解将配置文件中值付给effectiveTime

    @Autowired
    private RestTemplate restTemplate;
    /**
     *
     * @param phone  前端传进来的号码
     * @return 验证码对应的Key
     */
    @Override
    public String sendMsg(String phone) {
        //定义url
        String url = smsUrl+"/generate?name=sms&effectiveTime="+effectiveTime;

        //日志记录一下
        log.info("使用RestTemplate获取验证码:--{}"+url);

        //设置请求头
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        //设置请求体
        Map<String,Object> body = new HashMap<>();
        body.put("mobile",phone);

        //封装请求头和请求体
        HttpEntity entity = new HttpEntity(body,headers);
        Map response = null;//定义一个map来接收传回来的数据
        try {
            //post请求获取网页内容
             ResponseEntity<Map> exchange =  restTemplate.exchange(url,HttpMethod.POST,entity,Map.class);
            //日志记录
             log.info("调用短信微服务发送验证码: 返回值:{}",JSON.toJSONString(exchange));
             //获取请求体
             response =  exchange.getBody();
        }catch (Exception e){
            //失败的时候记录日志，并抛出异常
             log.info(e.getMessage(),e);
             throw  new RuntimeException("发送验证码错误");
        }

        //取出body中result 因为result中包含验证码的key
         Map resultMap= (Map)response.get("result");
        //取出Key对应的value值
         String value =resultMap.get("key").toString();
         return value;
    }

    /**
     * 校验验证码
     * @param verifiyKey  验证码对应的KEY
     * @param verifiyCode 验证码
     */
    @Override
    public void checkVerifiyCode(String verifiyKey, String verifiyCode) {
        String url = "http://localhost:56085/sailing/verify?name=sms&verificationCode="+verifiyCode+"&verificationKey="+verifiyKey;

        //日志记录一下
        log.info("使用RestTemplate校验验证码:--{}"+url);

        //定义一个Map响应回来的数据
        Map mapResponse = null;

        try {
            ResponseEntity<Map> exchange =  restTemplate.exchange(url,HttpMethod.POST,HttpEntity.EMPTY,Map.class);
            //日志记录
            log.info("使用RestTemplate校验验证码: 返回值:{}",JSON.toJSONString(exchange));
            //得到响应体
            mapResponse =  exchange.getBody();
        }catch (Exception e){
            //失败的时候记录日志，并抛出异常
            log.info(e.getMessage(),e);
            //校验自定义异常
            throw  new BusinessException(CommonErrorCode.E_100102);
            //throw  new RuntimeException("校验验证码错误");
        }
        if(mapResponse.get("result")==null||mapResponse == null || !(Boolean) mapResponse.get("result"))
        {
            //校验自定义异常
            throw  new BusinessException(CommonErrorCode.E_100102);
            //throw  new RuntimeException("校验验证码错误");
        }


    }
}
