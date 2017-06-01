package cn.cslg.CSLGAccessReservationSystem.LocalServer;

import cn.cslg.CSLGAccessReservationSystem.ServerBean.Manager;
import cn.cslg.CSLGAccessReservationSystem.ServerBean.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Created by Administrator on 2017/3/21.
 */
public class AddUserServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        Manager manager = (Manager) request.getSession().getAttribute("manager");        //获取session中的manager对象

        String username=request.getParameter("username");
        String password=request.getParameter("passward");
        String wechat_id=request.getParameter("wechat_id");
        String phone_number=request.getParameter("phone_number");
        String identity_number=request.getParameter("identity_number");
        String information=request.getParameter("information");

        User user=new User(username, password, wechat_id, phone_number, identity_number, information,false);
        manager.addUser(user);
        request.getRequestDispatcher("?").forward(request, response);          //跳转至相应网页

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doGet(request,response);
    }
}
