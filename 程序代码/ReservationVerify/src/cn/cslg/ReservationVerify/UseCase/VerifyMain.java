package cn.cslg.ReservationVerify.UseCase;

import cn.cslg.ReservationVerify.QR_CodeSupport.CreateParseCode;
import cn.cslg.ReservationVerify.ServerBean.ReservationMessage;
import cn.cslg.ReservationVerify.ServerBean.Time;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by leafspace on 2017/6/20.
 * LastEdit: 2017-6-21
 * Contact me:
 *     Phone: 18852923073
 *     E-mail: 18852923073@163.com
 */
public class VerifyMain {
    private static String path = "home/pi/qrCode/image.jpg";
    private static String[] cmdOrder = {"raspistill -t -1000 -o " + path};

    public static void main(String[] args) {
        //Doing 拍照
        try {
            Process process = Runtime.getRuntime().exec(cmdOrder);
            process.waitFor();
            InputStream inputStream = process.getInputStream();
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
            String line = null;
            while((line = bufferedReader.readLine()) != null) {
                System.out.println(line);
            }
        } catch (InterruptedException exception) {
            exception.printStackTrace();
        } catch (IOException exception) {
            exception.printStackTrace();
        }

        //Doing 读取二维码数据
        File file = new File(path);
        String qrInfo = new CreateParseCode().parseCode(file);
        if (qrInfo == null) {
            System.out.println("Information : (" + qrInfo + ") 这个二维码无法识别!");
            return ;
        } else if (qrInfo.indexOf("CSLG-AccessReservationSystem&reservation_id=") != 0) {
            System.out.println("Information : (" + qrInfo + ") 这个二维码不属于本系统!");
            return ;
        }

        String reservationID = qrInfo.substring("CSLG-AccessReservationSystem&reservation_id=".length() - 1);
        try {
            Integer.parseInt(reservationID);
        } catch (NumberFormatException exception) {
            //exception.printStackTrace();
            System.out.println("Information : 错误的二维码!");
            return ;
        }

        //Doing 数据库验证时间
        ReservationMessage reservationMessage = new ReservationMessage(reservationID);
        Time reservationTime = reservationMessage.time;

        if(reservationTime == null) {
            System.out.println("Information : 数据库中没有此预约信息!");
        }

        Calendar calendar = Calendar.getInstance();//可以对每个时间域单独修改
        calendar.setTime(new Date());
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int date = calendar.get(Calendar.DATE);
        int hour = calendar.get(Calendar.HOUR_OF_DAY);
        int minute = calendar.get(Calendar.MINUTE);

        if (reservationTime.year == year & reservationTime.month == month & reservationTime.day == date) {
            int nowTime = hour * 100 + minute;
            if (nowTime >= reservationTime.start & nowTime <= reservationTime.finish) {
                System.out.println("开门");
            }
        }

        //Doing 开门与否

    }
}
