package cn.cslg.ReservationVerify.Thread;

import java.io.IOException;
import java.io.InputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;

public class TakePhotoThread extends Thread {
    public static String path = "/tmp/image.jpg";
    public static String[] cmdOrder = {"sh", "-c", "raspistill -w 500 -h 500 -o " + path};

    public boolean threadRunning;

    public TakePhotoThread() {
        this.threadRunning = false;
    }

    private boolean TakePhoto() {
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

    @Override
    public void run() {
        this.threadRunning = true;
        while (true) {
            this.threadRunning = this.TakePhoto();
        }
    }
}
