package cn.cslg.CSLGAccessReservationSystem.LocalServer;

import cn.cslg.CSLGAccessReservationSystem.ServerBean.Manager;
import cn.cslg.CSLGAccessReservationSystem.ServerBean.User;

import java.util.Iterator;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2017/3/21.
 */
public class QueryAllUsersServlet extends HttpServlet{
    private Manager manager;
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setCharacterEncoding("utf-8");                                //设置 编码格式
        manager = (Manager) request.getSession().getAttribute("manager");      //获取session中的manager对象
        
        ArrayList<User> users = null;
        users = manager.queryAllUsers();
        
        boolean isSuccessed;
        
        if(users == null){
            isSuccessed = false;
            PrintWriter pw = response.getWriter();
            pw.print(isSuccessed);
            pw.close();
        }else{
            JSONArray jsonArray = arrayListToJSONArray(users);
            PrintWriter pw = response.getWriter();
            pw.print(jsonArray.toString());
            pw.close();
        }
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doGet(request,response);
    }
    
     /**
     * ArrayList<ReservationMessage>转换为Json
     */
     public JSONArray arrayListToJSONArray( ArrayList<User> users){  
        
        User user;
        JSONArray jsonArray = new JSONArray();
        Iterator i = users.iterator();
        while(i.hasNext()){
            user = (User) i.next();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("user_id", user.getUserID());
            jsonObject.put("username", user.getUserName());
            jsonObject.put("identity_number", user.getIdentityID());
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }
}
