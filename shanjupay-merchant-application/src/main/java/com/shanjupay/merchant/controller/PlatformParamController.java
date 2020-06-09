package com.shanjupay.merchant.controller;

import com.shanjupay.merchant.common.util.SecurityUtil;
import com.shanjupay.transaction.api.PayChannelService;
import com.shanjupay.transaction.api.dto.PayChannelDTO;
import com.shanjupay.transaction.api.dto.PayChannelParamDTO;
import com.shanjupay.transaction.api.dto.PlatformChannelDTO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.Value;
import lombok.extern.slf4j.Slf4j;
import org.apache.dubbo.config.annotation.Reference;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author Lidadaibiao
 * @date 2020/6/7 - 12:07
 */
@Api(value = "商户平台‐渠道和支付参数相关",description = "商户平台‐渠道和支付参数相关",tags = "商户平台‐渠道和支付参数")
@Slf4j
@RestController
public class PlatformParamController {


    @Reference
    private PayChannelService payChannelService;

    @ApiOperation("获取平台服务类型")
    @GetMapping(value = "/my/platform‐channels")
    public List<PlatformChannelDTO> queryPlatformChannel() {
        return payChannelService.queryPlatformChannel();
    }

    @ApiOperation("绑定服务类型")
    @ApiImplicitParams(
            {
                    @ApiImplicitParam(value = "应用ID", name = "appId", dataType = "string", required = true, paramType = "path"),
                    @ApiImplicitParam(value = "服务类型code", name = "platformChannelCodes", dataType = "string", required = true, paramType = "query")
            }

    )
    @PostMapping(value = "/my/apps/{appId}/platform-channels")
    public void bindPlatformForApp(@PathVariable("appId") String appId, @RequestParam("platformChannelCodes") String platformChannelCodes) {
        payChannelService.bindPlatformChannelForApp(appId, platformChannelCodes);
    }

    @ApiOperation("查询服务绑定状态")
    @ApiImplicitParams(
            {
                    @ApiImplicitParam(value = "应用ID", name = "appId", dataType = "string", paramType = "query", required = true),
                    @ApiImplicitParam(value = "服务类型code", name = "platformChannelCodes", dataType = "string", required = true, paramType = "query")
            }
    )
    @GetMapping("/my/merchants/apps/platformchannels")
    public int queryAppBindPlatformChannel(@RequestParam("appId") String appId, @RequestParam("platformChannelCodes") String platformChannelCodes) {
        return payChannelService.queryAppBindPlatformChannel(appId, platformChannelCodes);
    }

    @ApiOperation("根据平台服务类型获取支付渠道列表")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "服务类型编码",name = "platformChannelCode",dataType = "string",paramType = "path",required = true)
    })
    @PostMapping("/my/pay-channels/platform-channel/{platformChannelCode}")
    public List<PayChannelDTO> queryPayChannelByPlatformChannel(@PathVariable("platformChannelCode") String platformChannelCode)
    {
        return payChannelService.queryPayChannelByPlatformChannel(platformChannelCode);
    }

    @ApiOperation("商务配置支付轨道参数")
    @ApiImplicitParams(
            {
                    @ApiImplicitParam(value = "商户配置支付渠道参数",name = "payChannelParam",required = true,
                    dataType = "PayChannelParamDTO",paramType = "body")
            }
    )
    @RequestMapping(value = "/my/pay‐channel‐params",method = {RequestMethod.POST,RequestMethod.PUT})
    public void createPayChannelParam(@RequestBody PayChannelParamDTO payChannelParam)
    {
        //从token中获得用户id
        Long merchantid = SecurityUtil.getMerchantId();
        payChannelParam.setMerchantId(merchantid);
        payChannelService.createPayChannelParam(payChannelParam);

    }
    @ApiOperation("获取指定应用指定服务类型下所包含的原始支付渠道参数列表")
    @ApiImplicitParams(
            {
                    @ApiImplicitParam(value = "应用id",name ="appId",dataType = "string",paramType = "path",required = true),
                    @ApiImplicitParam(value = "服务类型",name = "platformChannel",dataType = "string",paramType = "path",required = true)
            }
    )
    @GetMapping(value = "/my/pay‐channel‐params/apps/{appId}/platformchannels/{platformChannel}")
    public List<PayChannelParamDTO> queryPayChannelParam(@PathVariable("appId")String appId,@PathVariable("platformChannel")String platformChannel){

        return payChannelService.queryPayChannelParamByAppAndPlatform(appId,platformChannel);

    }

    @ApiOperation("获取指定营业指定服务类型下所包含的某个原始支付参数")
    @ApiImplicitParams(
            {
                @ApiImplicitParam(value = "应用id",name = "appId",dataType = "string",paramType = "path",required = true),
                @ApiImplicitParam(value = "平台支付渠道代码",name = "platformChannel",dataType = "string",paramType = "path",required = true),
                @ApiImplicitParam(value = "实际支付渠道代码",name = "payChannel",dataType = "string",paramType = "path",required = true)
            }
    )
    @GetMapping(value = "/my/pay‐channel‐params/apps/{appId}/platformchannels/{platformChannel}/pay‐channels/{payChannel}")
    public PayChannelParamDTO queryPayChannelParam(@PathVariable("appId")String appId,
                                              @PathVariable("platformChannel")String platformChannel,
                                              @PathVariable("payChannel")String payChannel)
    {
        return payChannelService.queryParamByAppPlatformAndPayChannel(appId,platformChannel,payChannel);
    }
}
