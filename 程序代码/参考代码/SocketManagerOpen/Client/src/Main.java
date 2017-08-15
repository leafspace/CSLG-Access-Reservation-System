import java.net.Socket;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.BufferedReader;
import java.io.InputStreamReader;

public class Main {
    public static void main(String[] args) throws IOException {
        try {
            Socket socket = new Socket("127.0.0.1", 5209);
            System.out.println("客户端启动成功");
            PrintWriter write = new PrintWriter(socket.getOutputStream());
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            write.println("addIndex");
            write.flush();
            write.close();
            in.close();
            socket.close();
        } catch (Exception e) {
            System.out.println("can not listen to:" + e);// 出错，打印出错信息
        }
    }

}