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
public class LoginServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        
        request.setCharacterEncoding("utf-8");                                 //设置 编码格式
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        DBSqlServerConnection dbSqlServerConnection = new DBSqlServerConnection();
        dbSqlServerConnection.getPstmt("SELECT user_id, is_manager FROM Users WHERE userName = '" + username + "' AND password = '" + password + "';");
        ResultSet resultSet = dbSqlServerConnection.query();
        try {
            if (resultSet.next()) {
                String user_id = resultSet.getString(1);
                String is_manager = resultSet.getString(2);
                if(is_manager.equals("1")){
                    Manager manager = new Manager(user_id);
                    request.getSession().setAttribute("manager", manager);
                    //Todo 跳转到管理员界面
                    System.out.println("Info (LoginServlet) : The No." + user_id + " manager login system .");
                    response.sendRedirect("managerpage/content1.jsp");         //此时还未跳转，表示当中存在一些问题，还跳转回index页面；注：此处如果采用服务器跳转，将导致目录内容混乱无法引入
                } else if(is_manager.equals("0")) {
                    User user = new User(user_id);
                    request.getSession().setAttribute("user", user);
                    //Todo 跳转到一般用户界面
                    System.out.println("Info (LoginServlet) : The No." + user_id + " user login system .");
                    response.sendRedirect("userpage/index.jsp");               //此时还未跳转，表示当中存在一些问题，还跳转回index页面；注：此处如果采用服务器跳转，将导致目录内容混乱无法引入
                }
            } else {
                System.out.println("User Error Info (LoginServlet) : Have no this user login to system !");
                response.sendRedirect("index.jsp?errorInfo=没有此用户");
            }
        } catch (SQLException e){
            e.printStackTrace();
        } finally {
            dbSqlServerConnection.allClose();
        }

        //如果添加了这部分的内容，系统会提示异常。（原因不明） 暂时保留
        //response.sendRedirect("index.jsp");                                   //此时还未跳转，表示当中存在一些问题，还跳转回index页面
        return;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doGet(request,response);
    }
}