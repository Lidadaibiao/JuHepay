package com.shanjupay.merchant;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.*;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * 测试一波，，，
 * @author Lidadaibiao
 * @date 2020/6/3 - 15:54
 */


@SpringBootTest
@RunWith(SpringRunner.class)
@Slf4j  //添加日志 lombok 语法
public class RestTemplateTest {

    @Autowired
    RestTemplate restTemplate;//去springioc容器中查找这个类。已经初始化了


    //开始获取内容
    @Test
    public void getBaidu(){
        String uri ="http://www.baidu.com";
        ResponseEntity<String> result =  restTemplate.getForEntity(uri,String.class);
        String s = result.getBody();
        System.out.println(s);
    }


    /**
     * 使用RestTemplate获取验证码
     */
    @Test
    public void getSmsCode(){
        String url = "http://localhost:56085/sailing/generate?effectiveTime=300&name=sms";

        String phone = "15237227086";

        //日志记录一下
        log.info("使用RestTemplate获取验证码:--{}"+url);


        //设置请求头
        HttpHeaders httpHeaders = new HttpHeaders();
        //设置数据格式JSON
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);

        //设置请求体
        Map<String,Object> body = new HashMap<>();
        body.put("mobile",phone);

        //封装请求参数
        HttpEntity entity = new HttpEntity(body,httpHeaders);


        Map resposemap = null;
        try {
            //post请求  所以exchange
            ResponseEntity<Map> responseEntity =   restTemplate.exchange(url, HttpMethod.POST,entity,Map.class);
            //日志记录
            log.info("调用短信微服务发送验证码: 返回值:{}",JSON.toJSONString(responseEntity));
            //获取响应数据
            resposemap = responseEntity.getBody();
        }catch (Exception e){
            log.info(e.getMessage(),e);
        }
        //最后取出resposemap的数据(result数据。因为其中对应着验证码的key值)
        if(resposemap!=null||resposemap.get("result")!=null)
        {
            Map resultMap = (Map)resposemap.get("result");
            //"key": "sms:61651f5fe5a143e3aa99a003817cedd4",
            String value = resultMap.get("key").toString();
            System.out.println(value);
        }


    }
}
