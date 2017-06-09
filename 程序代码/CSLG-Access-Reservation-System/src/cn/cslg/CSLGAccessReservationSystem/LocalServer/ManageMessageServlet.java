package cn.cslg.CSLGAccessReservationSystem.LocalServer;

import cn.cslg.CSLGAccessReservationSystem.ServerBean.Manager;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2017/3/22.
 */
public class ManageMessageServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        Manager manager = (Manager) request.getSession().getAttribute("manager");        //获取session中的manager对象

        String reservation_id = request.getParameter("reservation_id");
        boolean isValid;
        if(((String) request.getParameter("isValid")).equals("0")){
            isValid = false;
        }else{
            isValid = true;
        }
        
        manager.manageMessage(reservation_id, isValid);
        boolean isSuccessed;
        if(!isValid){
            isSuccessed = false;
        }else{
            isSuccessed = true;
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
