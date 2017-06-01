package cn.cslg.WeChatLinkTest.Control;

import cn.cslg.WeChatLinkTest.Tools.SignatureUtil;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Created by 18852 on 2016/12/22.
 */
public class WebChatCallBackServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String signature = request.getParameter("signature");                    //微信加密签名
        String timestamp = request.getParameter("timestamp");                    //时间戳
        String nonce = request.getParameter("nonce");                            //随机数
        String echostr = request.getParameter("echostr");                        //随机字符串

        PrintWriter out = response.getWriter();
        if (SignatureUtil.checkSignature(signature, timestamp, nonce)) {            //通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
            out.print(echostr);
        }else{
            System.out.println("接入不成功");
        }
        out.close();
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
