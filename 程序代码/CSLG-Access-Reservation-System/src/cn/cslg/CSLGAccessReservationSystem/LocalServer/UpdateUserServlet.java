package cn.cslg.CSLGAccessReservationSystem.LocalServer;

import cn.cslg.CSLGAccessReservationSystem.ServerBean.Manager;
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
    Manager manager;
    User user;
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String flag = request.getParameter("flag");

        String wechat_id= request.getParameter("wechat_id");                   //用户名
        String phone_number = request.getParameter("phone_number");            //手机号
        String identity_number =  request.getParameter("identity_number");     //教/工号
        String password = request.getParameter("password");                    //密码
        String information = request.getParameter("information");              //备注信息
        boolean isSuccessed;
        if(flag.equals("updateUser_user")){
            user = (User) request.getSession().getAttribute("user");        //获取session中的manager对象
            isSuccessed=user.updateInformation(password, wechat_id, phone_number, identity_number, information);
        }else{
             manager = (Manager) request.getSession().getAttribute("manager");        //获取session中的manager对象
            String user_id = request.getParameter("user_id");
            User user = new User(user_id);
            User user1 = new User(user.getUserID(),user.getUserName(),password,wechat_id,phone_number,identity_number,information,user.is_temporary);
            isSuccessed = manager.updateUser(user1);
        }
       PrintWriter pw = response.getWriter();
       pw.print(isSuccessed);
       pw.close();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doGet(request,response);
    }
}
