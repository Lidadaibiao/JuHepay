package com.shanjupay.merchant;


import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.http.client.OkHttp3ClientHttpRequestFactory;

import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.client.RestTemplate;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.nio.charset.StandardCharsets;
import java.util.List;


/**
 * @author Lidadaibiao
 * @date 2020/6/2 - 19:31
 */
@EnableSwagger2
@SpringBootApplication
public class MerchantApplicationBootstrap {

    public static void main(String[] args) {
        SpringApplication.run(MerchantApplicationBootstrap.class,args);
    }

    /**
     * 将RestTemplate交给spirngioc容器进行管理
     * @return
     */
    @Bean
    public RestTemplate restTemplate(){
        //会产生乱码
        //return new RestTemplate(new OkHttp3ClientHttpRequestFactory());

        //如何解决乱码

      RestTemplate restTemplate =   new RestTemplate(new OkHttp3ClientHttpRequestFactory());

      //获得消息转换器列表r
     List<HttpMessageConverter<?>> httpMessageConverterList =  restTemplate.getMessageConverters();
      //配置消息转换器StringHttpMessageConverter，并设置utf‐8
        httpMessageConverterList.set(1,new StringHttpMessageConverter(StandardCharsets.UTF_8));
        return  restTemplate;
    }
}
