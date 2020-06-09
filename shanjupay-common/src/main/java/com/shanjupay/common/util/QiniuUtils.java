package com.shanjupay.common.util;
import com.google.gson.Gson;
import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.Region;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.DefaultPutRet;
import com.qiniu.util.Auth;
import com.qiniu.util.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.URLEncoder;
import java.io.*;
import java.util.UUID;


/**
 *
 * 使用七牛云的工具类
 * @author Lidadaibiao
 * @date 2020/6/4 - 14:42
 */
public class QiniuUtils {

    private static final Logger LOGGER = LoggerFactory.getLogger(QiniuUtils.class);


    /**
     *  文件上传的工具方法
     * @param accessKey
     * @param secretKey
     * @param bucket
     * @param bytes
     * @param fileName 外部传进来，七牛云上的文件名称和此保持一致
     */
    public static void  upload2qiniu(String accessKey,String secretKey,String bucket, byte[] bytes,String fileName) throws RuntimeException{

        //构造一个带指定 Region 对象的配置类，指定存储区域，和存储空间选择的区域一致
        Configuration cfg = new Configuration(Region.huanan());
        //...其他参数参考类注释
        UploadManager uploadManager = new UploadManager(cfg);

        //默认不指定key的情况下，以文件内容的hash值作为文件名
        String key = fileName;
        try {

            //认证
            Auth auth = Auth.create(accessKey, secretKey);
            //认证通过后得到token（令牌）
            String upToken = auth.uploadToken(bucket);
            try {
                //上传文件,参数：字节数组，key，token令牌
                //key: 建议我们自已生成一个不重复的名称
                Response response = uploadManager.put(bytes, key, upToken);
                //解析上传成功的结果
                DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
                System.out.println(putRet.key);
                System.out.println(putRet.hash);
            } catch (QiniuException ex) {
                Response r = ex.response;
                System.err.println(r.toString());
                LOGGER.error("上传文件到七牛：{}",ex.getMessage());
                try {
                    LOGGER.error(r.bodyString());
                } catch (QiniuException ex2) {
                    //ignore
                }
                throw new RuntimeException(r.bodyString());
            }
        } catch (Exception ex) {
            LOGGER.error("上传文件到七牛：{}",ex.getMessage());
            throw new RuntimeException(ex.getMessage());
        }
    }

    public static void testUpload() throws IOException {
        //上传测试
        //构造一个带指定 Region 对象的配置类，指定存储区域，和存储空间选择的区域一致
        Configuration cfg = new Configuration(Region.huanan());
        //...其他参数参考类注释
        UploadManager uploadManager = new UploadManager(cfg);
        //...生成上传凭证，然后准备上传
        String accessKey = "zNjPIQPoycgBHzKNId9r7-UaAipz0OxrDAh1UQFb";
        String secretKey = "o0YTrc0hFqoTs7RshJokyZfgOTP23rdxrGQ86lNz";
        String bucket = "shanjupay-li";
        //默认不指定key的情况下，以文件内容的hash值作为文件名
        //这里为了防止key上传的时候重复 所以采用随机生成方法
        String key = UUID.randomUUID().toString()+".png";
        //文件输入
        FileInputStream fileInputStream =null;
        try {
            //指定文件地址
            String filePath = "C:\\Users\\ASUS\\Desktop\\1.jpg";
            fileInputStream = new FileInputStream(new File(filePath));
            //得到本地文件的字节数组
            byte[] uploadBytes= IOUtils.toByteArray(fileInputStream);

            //byte[] uploadBytes = "hello qiniu cloud".getBytes("utf-8");

            //创建认证
            Auth auth = Auth.create(accessKey, secretKey);
            //认证后得到的令牌，，token
            String upToken = auth.uploadToken(bucket);
            try {
                //上传文件：参数：字节数组：key : 令牌token
                //最好是一个不重复的KEY这也是为什么上面用到UUID的原因
                Response response = uploadManager.put(uploadBytes, key, upToken);
                //解析上传成功的结果
                DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
                System.out.println(putRet.key);
                System.out.println(putRet.hash);
            } catch (QiniuException ex) {
                Response r = ex.response;
                System.err.println(r.toString());
                try {
                    System.err.println(r.bodyString());
                } catch (QiniuException ex2) {
                    //ignore
                }
            }
        } catch (UnsupportedEncodingException ex) {
            //ignore
        }

    }
    //对私有空间下载
    public static void testGetFileUrl() throws UnsupportedEncodingException {
        String fileName = "10808426-36b3-4287-85ff-b66c031c6465.png";
        String domainOfBucket = "http://qbe0lennt.bkt.clouddn.com";
        String encodedFileName = URLEncoder.encode(fileName, "utf-8").replace("+", "%20");
        String publicUrl = String.format("%s/%s", domainOfBucket, encodedFileName);
        String accessKey = "zNjPIQPoycgBHzKNId9r7-UaAipz0OxrDAh1UQFb";
        String secretKey = "o0YTrc0hFqoTs7RshJokyZfgOTP23rdxrGQ86lNz";
        Auth auth = Auth.create(accessKey, secretKey);
        long expireInSeconds = 3600;//1小时，可以自定义链接过期时间
        String finalUrl = auth.privateDownloadUrl(publicUrl, expireInSeconds);
        System.out.println(finalUrl);
    }
    //测试一波
    public static void main(String[] args) throws IOException {
        //QiniuUtils.testUpload();
        QiniuUtils.testGetFileUrl();
    }
}
