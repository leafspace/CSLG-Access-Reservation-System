package cn.cslg.ReservationVerify.UseCase;

import cn.cslg.ReservationVerify.QR_CodeSupport.CreateParseCode;
import cn.cslg.ReservationVerify.ServerBean.ReservationMessage;
import cn.cslg.ReservationVerify.ServerBean.Time;

import cn.cslg.ReservationVerify.Thread.WechatListenThread;
import cn.cslg.ReservationVerify.Thread.ButtonListenThread;
import cn.cslg.ReservationVerify.Thread.TakePhotoThread;
import com.pi4j.io.gpio.*;

import java.io.*;
import java.util.Date;
import java.util.Calendar;

/**
 * Created by leafspace on 2017/6/20.
 * LastEdit: 2017-8-15
 * Contact me:
 *     Phone: 18852923073
 *     E-mail: 18852923073@163.com
 */
public class VerifyMain {
    public static String ExplainQrCodes() {                                                      //用于读取图片，解释二维码的信息
        File file = new File(TakePhotoThread.path);                                              //获取图片路径
        String qrInfo = new CreateParseCode().parseCode(file);                                   //提取二维码的信息
        if (qrInfo == null) {                                                                    //二维码信息为空
            System.out.println("Information : (" + qrInfo + ") 这个二维码无法识别!");
            return null;
        } else if (qrInfo.indexOf("二维码预约系统") != 0) {                                       //二维码不属于系统
            System.out.println("Information : (" + qrInfo + ") 这个二维码不属于本系统!");
            return null;
        }

        String reservationID = qrInfo.substring("二维码预约系统".length());                        //获取预约ID
        try {
            Integer.parseInt(reservationID);                                                     //转换成int型
        } catch (NumberFormatException exception) {
            System.out.println("Information : (" + qrInfo + ") 错误的二维码!");
            return null;
        }

        return reservationID;
    }

    public static boolean CheckTime(String reservationID) {                                      //检测预约ID的时间是否为当前事前内
        ReservationMessage reservationMessage = new ReservationMessage(reservationID);
        Time reservationTime = reservationMessage.time;

        if(reservationTime == null) {
            return false;
        }

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int date = calendar.get(Calendar.DATE);
        int hour = calendar.get(Calendar.HOUR_OF_DAY);
        int minute = calendar.get(Calendar.MINUTE);

        if (reservationTime.year == year & reservationTime.month == month & reservationTime.day == date) {
            int nowTime = hour * 100 + minute;
            if (nowTime >= reservationTime.start & nowTime <= reservationTime.finish) {
                return true;
            }
        }

        return false;
    }

    public static void OpenDoor(GpioPinDigitalOutput doorController) {                           //开门函数
        doorController.setState(PinState.LOW);                                                   //设置低电平断电
        try {
            Thread.sleep(5000);                                                                  //停留5秒
        } catch (InterruptedException exception) {
            exception.printStackTrace();
        } finally {
            doorController.setState(PinState.HIGH);
        }
    }
    
    public static void main(String[] args) {
        boolean isSuccess;
        TakePhotoThread takePhotoThread = new TakePhotoThread();                                 //创建拍照线程
        WechatListenThread wechatListenThread = new WechatListenThread();                        //创建微信开门线程
        ButtonListenThread buttonListenThread = new ButtonListenThread();                        //创建按钮开门监听器

        final GpioController gpioController = GpioFactory.getInstance();
        final GpioPinDigitalOutput doorController = gpioController.provisionDigitalOutputPin(RaspiPin.GPIO_01, "MyControl", PinState.HIGH);
        final GpioPinDigitalInput buttonController = gpioController.provisionDigitalInputPin(RaspiPin.GPIO_02, PinPullResistance.PULL_DOWN);

        doorController.setShutdownOptions(true, PinState.LOW);
        buttonController.setShutdownOptions(true);
        buttonController.addListener(buttonListenThread);

        takePhotoThread.start();
        wechatListenThread.start();
        while (true) {
            isSuccess = takePhotoThread.threadRunning;                                           //如果拍照线程正在运行
            if (!isSuccess) {
                System.out.println("Error : System hava a error in take photo !");
                continue;
            }

            String reservationID = ExplainQrCodes();
            if (reservationID != null) {
                isSuccess = CheckTime(reservationID);                                            //检测时间是否正确
                if (isSuccess) {
                    System.out.println("Information : (" + reservationID + ") Open the door !");
                    OpenDoor(doorController);
                    continue;
                }
            }

            if (wechatListenThread.open) {
                System.out.println("Information : Manager Open the door !");
                wechatListenThread.freeIndexOpen();
                OpenDoor(doorController);
                continue;
            }

            if (buttonListenThread.open) {
                System.out.println("Information : Button Open the door !");
                buttonListenThread.open = false;
                OpenDoor(doorController);
            }
        }
    }
}
