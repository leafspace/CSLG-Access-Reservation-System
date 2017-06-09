package cn.cslg.CSLGAccessReservationSystem.LocalServer;

import cn.cslg.CSLGAccessReservationSystem.ServerBean.DBSqlServerConnection;
import cn.cslg.CSLGAccessReservationSystem.ServerBean.Manager;
import cn.cslg.CSLGAccessReservationSystem.ServerBean.User;

import java.sql.ResultSet;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Created by Administrator on 2017/4/13.
 */
public class RegisterServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        
        response.setCharacterEncoding("utf-8");                                //设置 编码格式
        request.setCharacterEncoding("utf-8");                                 //设置 编码格式
        
        String username = request.getParameter("user");
        String password = request.getParameter("passwd");
        String identity_number = request.getParameter("identity_number");
        String wechat_id = request.getParameter("wechat_id");
        String information = request.getParameter("information");
        DBSqlServerConnection dbSqlServerConnection = new DBSqlServerConnection();
        dbSqlServerConnection.getPstmt("SELECT * FROM Users WHERE userName = '" + username + "' AND identity_number = '" + identity_number + "';");
        ResultSet resultSet = dbSqlServerConnection.query();
        try{
            if(resultSet.next()) {                                             //说明系统数据库当中已经存在此用户
                System.out.println("User Error Info (RegisterServlet) : System already have this user !");
                response.sendRedirect("index.jsp?errorInfo=当前用户已存在");
            } else {
                Manager manager = new Manager("1");
                manager.addUser(new User(username, password, wechat_id, "", identity_number, information, true));
                manager = null;
                System.out.println("Info (RegisterServlet) : User " + username + " register successfully !");
                response.sendRedirect("index.jsp");
                return;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbSqlServerConnection.allClose();
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doGet(request,response);
    }
}