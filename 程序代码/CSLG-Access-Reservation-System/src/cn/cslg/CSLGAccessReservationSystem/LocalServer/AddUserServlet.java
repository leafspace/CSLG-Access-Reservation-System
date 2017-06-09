package cn.cslg.CSLGAccessReservationSystem.LocalServer;

import cn.cslg.CSLGAccessReservationSystem.ServerBean.Manager;
import cn.cslg.CSLGAccessReservationSystem.ServerBean.User;

import java.util.Iterator;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Created by Administrator on 2017/3/21.
 */
public class AddUserServlet extends HttpServlet {
    private Manager manager;
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        
        manager = (Manager) request.getSession().getAttribute("manager");      //获取session中的manager对象
        System.out.println(manager.getUsername());
        String flag = request.getParameter("flag");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String wechat_id = request.getParameter("wechat_id");
        String phone_number = request.getParameter("phone_number");
        String identity_number = request.getParameter("identity_number");
        String information = request.getParameter("information");
        User user = new User(username, password, wechat_id, phone_number, identity_number, information, false);
        boolean isSuccessed;
        isSuccessed = queryUserName(username);
       if(isSuccessed){
          manager.addUser(user); 
       }
       PrintWriter pw = response.getWriter();
       pw.print(isSuccessed);
       pw.close();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doGet(request,response);
    }
    
    /**
     * 判断数据库中是否已存在当前用户
     * @param userName
     * @return 
     */
    public boolean queryUserName(String userName){
        
        System.out.println(userName);
        ArrayList<User> users = new ArrayList<User>();
        
        users=manager.queryAllUsers();
        Iterator<User> i = users.iterator();
        
        System.out.println( users.size());
        User user;
        while(i.hasNext()){
            user=(User)i.next();
           if(user.getUserName()!=null){
                if(user.getUserName().equals(userName)){
                  return false;  
                } 
            }
        }
        return true;
    }
}
