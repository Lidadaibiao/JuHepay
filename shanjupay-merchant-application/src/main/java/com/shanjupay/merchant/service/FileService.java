package com.shanjupay.merchant.service;

import com.shanjupay.common.domain.BusinessException;

/**
 *
 * 七牛云文件服务
 * @author Lidadaibiao
 * @date 2020/6/4 - 15:59
 */
public interface FileService {

    /**
     *
     * 上传文件  到七牛云
     * @param bytes  上传文件的字节数组
     * @param fileName 上传文件名称
     * @return 文件下载的绝对路径
     * @throws BusinessException
     */
    public String upload(byte[] bytes,String fileName)throws BusinessException;
}
