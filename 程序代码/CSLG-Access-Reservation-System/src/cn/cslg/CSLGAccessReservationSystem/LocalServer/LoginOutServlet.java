package cn.cslg.CSLGAccessReservationSystem.LocalServer;

/**
 * Created by Administrator on 2017/5/2.
*/

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginOutServlet extends HttpServlet {
    /**
     * @category 退出登录的Servlet,注销
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);//防止创建Session
        if(session == null){
            response.sendRedirect("index.jsp");
            return;
        }
        session.removeAttribute("user");
        session.removeAttribute("manager");
        response.sendRedirect("index.jsp");
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}