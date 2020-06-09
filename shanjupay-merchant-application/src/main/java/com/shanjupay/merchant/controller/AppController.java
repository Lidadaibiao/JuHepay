package com.shanjupay.merchant.controller;

import com.shanjupay.merchant.api.AppService;
import com.shanjupay.merchant.api.dto.AppDTO;
import com.shanjupay.merchant.common.util.SecurityUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.apache.dubbo.config.annotation.Reference;
import org.springframework.web.bind.annotation.*;
import sun.awt.SunHints;

import java.util.List;

/**
 * 商户平台App应用
 * @author Lidadaibiao
 * @date 2020/6/5 - 1:37
 */
@Api(value = "商户平台-应用管理",tags = "商户平台-应用相关",description ="商户平台-应用相关" )
@RestController
public class AppController {

    @Reference
    private AppService appService;

    @ApiOperation("商户创建应用")
    @ApiImplicitParams(
            {
                    @ApiImplicitParam(value = "应用信息",name = "app",required = true,dataType = "AppDTO",paramType = "body")
            }
    )
    @PostMapping(value = "/my/apps")
    public AppDTO createApp(@RequestBody AppDTO app)
    {
        Long merchantId = SecurityUtil.getMerchantId();

        return   appService.createApp(merchantId,app);
    }

    /**
     * 查询商户下所有的应用
     * @return
     */
    @ApiOperation("查询商户下的用户列表")
    @GetMapping(value = "/my/apps")
    public List<AppDTO> queryMyApps(){
        //得到商户ID
        Long merchantId = SecurityUtil.getMerchantId();
        //查询
        return appService.queryAppByMerchant(merchantId);
    }

    @ApiOperation("根据Appid查询应用的详细信息")
    @ApiImplicitParams(
            {
                    @ApiImplicitParam(name = "appId",value = "商户应用id",required = true,dataType = "String",paramType = "path")
            }
    )
    @GetMapping(value = "/my/apps/{appId}")
    public AppDTO getApp(@PathVariable String appId)
    {
       return appService.getAppById(appId);
    }
}
