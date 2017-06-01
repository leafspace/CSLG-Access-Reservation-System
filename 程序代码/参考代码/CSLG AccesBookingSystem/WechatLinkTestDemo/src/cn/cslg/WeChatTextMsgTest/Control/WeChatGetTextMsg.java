package cn.cslg.WeChatTextMsgTest.Control;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by 18852 on 2017/2/5.
 */
public class WeChatGetTextMsg extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ToUserName = request.getParameter("ToUserName");                //公众号
        String FromUserName = request.getParameter("FromUserName");            //粉丝煲
        String CreateTime = request.getParameter("CreateTime");                //
        String MsgType = request.getParameter("MsgType");
        String Content = request.getParameter("Content");
        String MsgId = request.getParameter("MsgId");
        System.out.println("info : This is a " + MsgType + " message , msg is " + Content + " , from " + FromUserName + " to " + ToUserName);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
