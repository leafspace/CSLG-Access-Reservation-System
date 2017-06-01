package cn.cslg.CSLGAccessReservationSystem.LocalServer;

import cn.cslg.CSLGAccessReservationSystem.ServerBean.ActivityRoom;
import cn.cslg.CSLGAccessReservationSystem.ServerBean.Manager;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Created by Administrator on 2017/3/22.
 */
public class AddActivityRoomServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        Manager manager = (Manager) request.getSession().getAttribute("manager");        //获取session中的manager对象
        String room_name = request.getParameter("room_name");
        String information = request.getParameter("information");
        ActivityRoom activityRoom = new ActivityRoom(room_name, information);
        manager.addRoom(activityRoom);
        request.getRequestDispatcher("?").forward(request, response);          //跳转至相应网页

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doGet(request,response);
    }
}
