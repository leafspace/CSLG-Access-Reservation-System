package cn.cslg.WeChatLinkTest.Tools;

import java.util.Arrays;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by 18852 on 2016/12/22.
 */
public class SignatureUtil {
    private static String token = "123456";                                  //token密钥，与微信接口配置的相同

    public static boolean checkSignature(String signature, String timestamp, String nonce) {
        boolean isEqual = false;
        try {
            String[] arr = new String[]{SignatureUtil.token, timestamp, nonce};

            Arrays.sort(arr);                                                    //将token、timestamp、nonce三个参数进行字典序排序

            StringBuilder content = new StringBuilder();                         //三个参数组合成一个字符串
            for (int i = 0; i < arr.length; i++) {
                content.append(arr[i]);
            }

            String tmpStr = null;
            tmpStr = SignatureUtil.encryptSHA1(content.toString());              //进行SHA1加密，返回16进制字符串

            if (tmpStr != null && tmpStr.equals(signature)) {                      //将sha1加密后的字符串可与signature对比
                isEqual = true;
            } else {
                isEqual = false;
            }
            content = null;
            return isEqual;
        }catch (NullPointerException e){
            System.out.println("Null pointer exception !");
            return false;
        }
    }

    public static String encryptSHA1(String data){
        String str=null;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-1");           //获得SHA1摘要算法的 MessageDigest 对象
            md.update(data.getBytes());                                      //使用指定的字节更新摘要
            byte[] bytes = md.digest();                                      //获得密文
            str = SignatureUtil.bytesToHexString(bytes);                     //字节数组转化为16进制字符串
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return str;
    }

    public static String bytesToHexString(byte[] bytes){
        StringBuffer sb = new StringBuffer();
        if(bytes == null || bytes.length <= 0){
            return null;
        }
        for(int i=0; i < bytes.length; i++){
            int temp = bytes[i] & 0xFF;                                      //与运算，将byte转化为整型
            String hex = Integer.toHexString(temp);                          //int型转化为16进制字符串
            if(hex.length() < 2){
                sb.append(0);
            }
            sb.append(hex);
        }
        return sb.toString();
    }

}
