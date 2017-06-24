/**
 * Created by Administrator on 2017/6/24.
 */

import javax.swing.*;
import java.io.IOException;
import net.miginfocom.swing.MigLayout;
import org.bytedeco.javacv.CanvasFrame;
import org.bytedeco.javacv.OpenCVFrameGrabber;
import org.bytedeco.javacv.FrameGrabber.Exception;

public class JavavcCameraTest {
    private CanvasFrame canvasFrame;

    public JavavcCameraTest() throws IOException {
        this.canvasFrame = new CanvasFrame("Window");                          //新建一个窗口
        this.canvasFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.canvasFrame.setAlwaysOnTop(true);

        this.canvasFrame.setLayout(new MigLayout("insets 0, gap 10", "grow", "grow"));
        //this.canvasFrame.add(new JButton("Button"), "w 100:100:100, h 40:40:40");
    }

    public void showWindow(OpenCVFrameGrabber openCVFrameGrabber) throws Exception, InterruptedException {
        this.canvasFrame.pack();
        while(true) {
            if(!this.canvasFrame.isDisplayable()) {                            //窗口是否关闭
                openCVFrameGrabber.stop();                                     //停止抓取
                System.exit(2);                                                //退出
            }
            this.canvasFrame.showImage(openCVFrameGrabber.grab());             //获取摄像头图像并放到窗口上显示， 这里的Frame frame=grabber.grab(); frame是一帧视频图像
            Thread.sleep(50);                                                  //50毫秒刷新一次图像
        }
    }

    public static void main(String[] args) throws Exception, IOException, InterruptedException {
        JavavcCameraTest javavcCameraTest = new JavavcCameraTest();
        OpenCVFrameGrabber openCVFrameGrabber = new OpenCVFrameGrabber(0);
        openCVFrameGrabber.start();                                                       //开始获取摄像头数据
        javavcCameraTest.showWindow(openCVFrameGrabber);
    }
}