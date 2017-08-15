import java.net.Socket;
import java.io.IOException;
import java.net.ServerSocket;
import java.io.BufferedReader;
import java.io.InputStreamReader;

class SocketThread extends Thread {
    private int index = 0;
    private Socket socket = null;
    private ServerSocket serverSocket = null;

    public SocketThread() {
        try {
            this.serverSocket = new ServerSocket(5209);                        //指定绑定的端口，并监听此端口.
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void run() {
        try {
            while (true) {
                this.socket = serverSocket.accept();                           //使用accept()阻塞等待客户请求，有客户
                BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(this.socket.getInputStream()));//获取输入流，并读取客户端信息
                String infoLine = bufferedReader.readLine();                   //在标准输出上打印从客户端读入的字符串
                if (infoLine.equals("addIndex")) {
                    this.index++;
                }
                bufferedReader.close();                                        //关闭Socket输入流
                this.socket.close();                                           //关闭Socket
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void close() {
        try {
            this.serverSocket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public int getIndex() {
        return this.index;
    }

    public void freeIndex() {
        this.index--;
    }
}