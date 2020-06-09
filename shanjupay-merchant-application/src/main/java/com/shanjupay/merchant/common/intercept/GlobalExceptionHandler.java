package com.shanjupay.merchant.common.intercept;

import com.shanjupay.common.domain.BusinessException;
import com.shanjupay.common.domain.CommonErrorCode;
import com.shanjupay.common.domain.ErrorCode;
import com.shanjupay.common.domain.RestErrorResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 *
 * 全局异常处理器
 * @author Lidadaibiao
 * @date 2020/6/4 - 11:15
 */


@ControllerAdvice //实现全局异常处理器
@Slf4j //日志记录
public class GlobalExceptionHandler {

    //铺货到异常之后处理方法
    @ResponseBody
    //ControllerAdvice和ExceptionHandler结合可以捕获Controller抛出的异常，
    //根据异常处理流程，Service和持久层 终都会抛给Controller，所以此方案可以实现全局异常捕获，
    @ExceptionHandler(value = Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public RestErrorResponse processExcetion(HttpServletRequest request, HttpServletResponse response,Exception e)
    {
        //如果是自定义异常 则直接取出异常信息
        if(e instanceof BusinessException){
            //日志记录
            log.info(e.getMessage(),e);

            BusinessException businessException = (BusinessException)e;

            ErrorCode errorCode =  businessException.getErrorCode();

           String code =  String.valueOf(errorCode.getCode());
           String desc =   errorCode.getDesc();
           RestErrorResponse restErrorResponse = new RestErrorResponse(code,desc);
           return restErrorResponse;
        }
        log.error("系统异常：",e);
        return new RestErrorResponse(String.valueOf(CommonErrorCode.UNKNOWN.getCode()),CommonErrorCode.UNKNOWN.getDesc());
    }

}
