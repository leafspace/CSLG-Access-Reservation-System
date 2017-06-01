package cn.cslg.CSLGAccessReservationSystem.LocalServer;

import cn.cslg.CSLGAccessReservationSystem.ServerBean.User;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Created by Administrator on 2017/3/21.
 */
public class UpdateUserServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        User user=(User)request.getSession().getAttribute("user");

        String wechat_id= request.getParameter("wechat_id");                   //微信号
        String phone_number = request.getParameter("phoneNum");                //手机号
        String identity_number =  request.getParameter("amount");              //教/工号
        String password = request.getParameter("password");                    //密码
        String information = request.getParameter("information");              //备注信息

        boolean isSuccessed=user.updateInformation(password, wechat_id, phone_number, identity_number, information);
        PrintWriter pw = response.getWriter();
        pw.print(isSuccessed);
        pw.close();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doGet(request,response);
    }
}
