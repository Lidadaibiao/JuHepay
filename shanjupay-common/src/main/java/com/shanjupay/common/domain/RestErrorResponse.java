package com.shanjupay.common.domain;

import io.swagger.annotations.ApiModel;
import lombok.Data;

/**
 *
 *
 * 错误响应包装类
 * @author Lidadaibiao
 * @date 2020/6/4 - 11:12
 */

@ApiModel(value = "RestErrorResponse",description = "错误响应参数包装")
@Data
public class RestErrorResponse {

    private String errCode;
    private String errMessage;

    public RestErrorResponse() {

    }
    public RestErrorResponse(String errCode, String errMessage) {
        this.errCode = errCode;
        this.errMessage = errMessage;
    }
}
