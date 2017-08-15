package cn.cslg.ReservationVerify.UseCase;

import cn.cslg.ReservationVerify.QR_CodeSupport.CreateParseCode;
import cn.cslg.ReservationVerify.ServerBean.ReservationMessage;
import cn.cslg.ReservationVerify.ServerBean.SocketThread;
import cn.cslg.ReservationVerify.ServerBean.Time;

import com.pi4j.io.gpio.GpioPinDigitalOutput;
import com.pi4j.io.gpio.GpioController;
import com.pi4j.io.gpio.GpioFactory;
import com.pi4j.io.gpio.PinState;
import com.pi4j.io.gpio.RaspiPin;

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
    private static String path = "/home/pi/qrCode/image.jpg";
    private static String[] cmdOrder = {"sh", "-c", "raspistill -w 500 -h 500 -o " + path};

    public static boolean TakePhoto() {
        try {
            Process process = Runtime.getRuntime().exec(cmdOrder);
            process.waitFor();
            InputStream inputStream = process.getInputStream();
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
            String line = null;
            while((line = bufferedReader.readLine()) != null) {
                System.out.println("Information : (Take photo) " + line);
            }
        } catch (InterruptedException exception) {
            return false;
        } catch (IOException exception) {
            return false;
        }
        return true;
    }

    public static String ExplainQrCodes() {
        File file = new File(path);
        String qrInfo = new CreateParseCode().parseCode(file);
        if (qrInfo == null) {
            System.out.println("Information : (" + qrInfo + ") 这个二维码无法识别!");
            return null;
        } else if (qrInfo.indexOf("二维码预约系统") != 0) {
            System.out.println("Information : (" + qrInfo + ") 这个二维码不属于本系统!");
            return null;
        }

        String reservationID = qrInfo.substring("二维码预约系统".length());
        try {
            Integer.parseInt(reservationID);
        } catch (NumberFormatException exception) {
            System.out.println("Information : (" + qrInfo + ") 错误的二维码!");
            return null;
        }

        return reservationID;
    }

    public static boolean CheckTime(String reservationID) {
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

    public static void OpenDoor(GpioPinDigitalOutput doorController) {
        doorController.setState(PinState.LOW);
        try {
            Thread.sleep(5000);
        } catch (InterruptedException exception) {
            exception.printStackTrace();
        } finally {
            doorController.setState(PinState.HIGH);
        }
    }

    public static void main(String[] args) {
        boolean isSuccess = true;
        final SocketThread socketThread = new SocketThread();
        final GpioController gpioController = GpioFactory.getInstance();
        final GpioPinDigitalOutput doorController = gpioController.provisionDigitalOutputPin(RaspiPin.GPIO_01, "MyControl", PinState.HIGH);
        doorController.setShutdownOptions(true, PinState.LOW);
        socketThread.run();

        while (true) {
            isSuccess = TakePhoto();
            if (!isSuccess) {
                System.out.println("Error : System hava a error in take photo !");
                continue;
            }

            String reservationID = ExplainQrCodes();
            if (reservationID != null) {
                isSuccess = CheckTime(reservationID);
                if (isSuccess) {
                    System.out.println("Information : (" + reservationID + ") Open the door !");
                    OpenDoor(doorController);
                }
            }

            if (socketThread.getIndex() > 0) {
                System.out.println("Information : Manager Open the door !");
                OpenDoor(doorController);
                socketThread.freeIndex();
            }
        }
        //gpioController.shutdown();
    }
}
