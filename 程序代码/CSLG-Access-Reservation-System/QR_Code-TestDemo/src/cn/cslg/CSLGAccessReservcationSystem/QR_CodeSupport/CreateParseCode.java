package cn.cslg.CSLGAccessReservcationSystem.QR_CodeSupport;

import com.google.zxing.Result;
import com.google.zxing.Binarizer;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.LuminanceSource;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.HybridBinarizer;

import java.io.File;
import java.util.Map;
import java.util.HashMap;
import java.io.IOException;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;

public class CreateParseCode {
    public static void  main(String [] args) throws IOException, WriterException {
        CreateParseCode cpCode = new CreateParseCode();

        String url = "做我女朋友吧！";                                                //二维码显示的内容
        int width = 500;
        int height = 500;
        String path="D:/123.png";

        cpCode.createCode(url,width,height,path);
        cpCode.parseCode(new File("D:/123.png"));
    }

    public static int width = 500;
    public static int height = 500;

    public void createCode(String text,int width,int height,String path){
        String format = "png";
        HashMap hints = new HashMap();
        hints.put(EncodeHintType.CHARACTER_SET, "utf-8");                      //内容所使用编码
        try {
            BitMatrix bitMatrix = new MultiFormatWriter().encode(text,BarcodeFormat.QR_CODE,width,height,hints);
            File outputFile = new File(path);
            MatrixToImageWriter.writeToFile(bitMatrix, format, outputFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void parseCode(File file) {
        try {
            MultiFormatReader formatReader = new MultiFormatReader();
            if (!file.exists()) {
                return ;
            }

            BufferedImage image = ImageIO.read(file);
            LuminanceSource source = new BufferedImageLuminanceSource(image);
            Binarizer binarizer = new HybridBinarizer(source);
            BinaryBitmap binaryBitmap = new BinaryBitmap(binarizer);

            Map hints = new HashMap();
            hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
            Result result = formatReader.decode(binaryBitmap, hints);
            System.out.println("解析结果 = " + result.toString());
            System.out.println("二维码格式类型 = " + result.getBarcodeFormat());
            System.out.println("二维码文本内容 = " + result.getText());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}