package cn.cslg.ReservationVerify.QR_CodeSupport;

import com.google.zxing.*;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeReader;
import com.google.zxing.common.HybridBinarizer;

import java.io.File;
import java.util.Map;
import java.util.HashMap;
import java.io.IOException;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;

public class CreateParseCode {
    public static int width = 500;
    public static int height = 500;

    public boolean createCode(String text, int width, int height, String path){
        String format = "png";
        HashMap hints = new HashMap();
        hints.put(EncodeHintType.CHARACTER_SET, "utf-8");                      //内容所使用编码
        hints.put(DecodeHintType.TRY_HARDER, Boolean.TRUE);
        hints.put(DecodeHintType.PURE_BARCODE, Boolean.TRUE);
        
        try {
            BitMatrix bitMatrix = new MultiFormatWriter().encode(text, BarcodeFormat.QR_CODE, width, height, hints);
            File outputFile = new File(path);
            MatrixToImageWriter.writeToFile(bitMatrix, format, outputFile);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public String parseCode(File file) {
        try {
            MultiFormatReader formatReader = new MultiFormatReader();
            if (!file.exists()) {
            	System.out.println("Create parse code : File not exists !");
                return null;
            }

            /*
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
            */
            
            BufferedImage image = ImageIO.read(file);
            LuminanceSource source = new BufferedImageLuminanceSource(image);
            BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));
            QRCodeReader reader = new QRCodeReader();
            Result result = null;
            try {
            	result = reader.decode(bitmap);
            	return result.getText();
            } catch (ReaderException e) {
            	e.printStackTrace();
            	return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}