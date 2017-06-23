package cn.cslg.CSLGAccessReservcationSystem.QR_CodeSupport;

import com.google.zxing.*;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeReader;
import com.google.zxing.common.HybridBinarizer;

import java.io.File;
import java.util.HashMap;
import java.io.IOException;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.util.Map;

public class CreateParseCode {
    public static int width = 500;
    public static int height = 500;
    public static String path = "D:/qrCode.jpg";

    public static void  main(String [] args) throws IOException, WriterException {
        String url = "滚！谁让你扫的！";                                               //二维码显示的内容
        CreateParseCode cpCode = new CreateParseCode();
        cpCode.createCode(url, CreateParseCode.width, CreateParseCode.height, CreateParseCode.path);
        cpCode.parseCode(new File(CreateParseCode.path));
    }

    public void createCode(String text, int width, int height, String path){
        String format = "jpg";
        HashMap hints = new HashMap();
        hints.put(EncodeHintType.CHARACTER_SET, "utf-8");                      //内容所使用编码
        hints.put(DecodeHintType.TRY_HARDER, Boolean.TRUE);
        hints.put(DecodeHintType.PURE_BARCODE, Boolean.TRUE);

        try {
            BitMatrix bitMatrix = new MultiFormatWriter().encode(text, BarcodeFormat.QR_CODE, width, height, hints);
            File outputFile = new File(path);
            MatrixToImageWriter.writeToFile(bitMatrix, format, outputFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void parseCode(File file) {
        try {
            if (!file.exists()) {
                return ;
            }

            String result_planA = this.parseCode_planA(file);
            String result_planB = this.parseCode_planB(file);

            if(result_planA == null & result_planB == null) {
                return ;
            } else {
                if(result_planA != null) {
                    System.out.println("Information : <" + result_planA + ">");
                }

                if(result_planB != null) {
                    System.out.println("Error : This qr code can't reader !");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String parseCode_planA(File file) {
        try {
            MultiFormatReader formatReader = new MultiFormatReader();
            BufferedImage image = ImageIO.read(file);
            LuminanceSource source = new BufferedImageLuminanceSource(image);
            Binarizer binarizer = new HybridBinarizer(source);
            BinaryBitmap binaryBitmap = new BinaryBitmap(binarizer);

            Map hints = new HashMap();
            hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
            hints.put(DecodeHintType.TRY_HARDER, Boolean.TRUE);
            hints.put(DecodeHintType.PURE_BARCODE, Boolean.TRUE);
            Result result = formatReader.decode(binaryBitmap, hints);
            return result.getText();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public String parseCode_planB(File file) {
        try {
            BufferedImage bufferedImage = ImageIO.read(file);
            LuminanceSource luminanceSource = new BufferedImageLuminanceSource(bufferedImage);
            BinaryBitmap binaryBitmap = new BinaryBitmap(new HybridBinarizer(luminanceSource));
            QRCodeReader qrCodeReader = new QRCodeReader();
            Result result = qrCodeReader.decode(binaryBitmap);
            return result.getText();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}