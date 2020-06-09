package com.shanjupay.merchant.service;


import com.shanjupay.common.domain.BusinessException;
import com.shanjupay.common.domain.CommonErrorCode;
import com.shanjupay.common.util.QiniuUtils;
import org.springframework.beans.factory.annotation.Value;

/**
 * @author Lidadaibiao
 * @date 2020/6/4 - 16:01
 */
@org.springframework.stereotype.Service
public class FileServiceImpl implements FileService {
    //开始从nacos配置管理中取出需要的参数
    @Value("${oss.qiniu.url}")
    private String qiniu_url;
    @Value("${oss.qiniu.accessKey}")
    private String qiniu_accessKey;
    @Value("${oss.qiniu.secretKey}")
    private String qiniu_secretKey;
    @Value("${oss.qiniu.bucket}")
    private String qiniu_bucket;
    /**
     *
     * @param bytes  上传文件的字节数组
     * @param fileName 上传文件名称
     * @return 文件下载路径
     * @throws BusinessException
     */
    @Override
    public String upload(byte[] bytes, String fileName) throws BusinessException {
        try {
            QiniuUtils.upload2qiniu(qiniu_accessKey,qiniu_secretKey,qiniu_bucket,bytes,fileName);
        }catch (Exception e){
            e.printStackTrace();
            throw new BusinessException(CommonErrorCode.E_100106);
        }

        return qiniu_url+fileName;
    }
}
