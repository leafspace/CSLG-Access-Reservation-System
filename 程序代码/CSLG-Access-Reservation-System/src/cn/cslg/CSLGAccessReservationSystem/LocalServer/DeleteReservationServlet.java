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
 * Created by Administrator on 2017/3/22.
 */
public class DeleteReservationServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        Manager manager = (Manager) request.getSession().getAttribute("manager");        //获取session中的manager对象
        User user = (User) request.getSession().getAttribute("user");
        String reservation_id = request.getParameter("reservation_id");

        if(manager == null && user != null){
            manager=new Manager(user.getUserID());
        }
        
        boolean isSuccessed;
        isSuccessed = manager.deleteReservation(reservation_id);
        PrintWriter pw = response.getWriter();
        pw.print(isSuccessed);
        pw.close();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doGet(request,response);
    }
}
