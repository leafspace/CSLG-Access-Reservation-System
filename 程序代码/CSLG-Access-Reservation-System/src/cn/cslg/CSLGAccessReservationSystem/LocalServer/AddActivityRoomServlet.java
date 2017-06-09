package cn.cslg.CSLGAccessReservationSystem.LocalServer;

import cn.cslg.CSLGAccessReservationSystem.ServerBean.ActivityRoom;
import cn.cslg.CSLGAccessReservationSystem.ServerBean.Manager;

import java.util.Iterator;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Created by Administrator on 2017/3/22.
 */
public class AddActivityRoomServlet extends HttpServlet {
    Manager manager;
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException,ServletException {
        response.setCharacterEncoding("utf-8");                                //设置 编码格式
        
        manager = (Manager) request.getSession().getAttribute("manager");      //获取session中的manager对象
        String room_name = request.getParameter("room_name");
        String information = request.getParameter("information");
        ActivityRoom activityRoom = new ActivityRoom(room_name, information);
        
        boolean isSuccessed;
        isSuccessed = queryActivityName(room_name, information);
        if(isSuccessed){
           manager.addRoom(activityRoom);
        }
        
        PrintWriter pw = response.getWriter();
        pw.print(isSuccessed);
        pw.close();
    }



    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException,ServletException {
        doGet(request,response);
    }
    
    
    /**
     * 判断数据库中是否已存在当前活动室
     * @param room_name
     * @return 
     */
    public boolean queryActivityName(String room_name,String room_location) {
        ArrayList<ActivityRoom> activityRooms = new ArrayList<ActivityRoom>();
        
        System.out.println(manager.getUsername());
        activityRooms=manager.queryAllRooms();
        
        Iterator<ActivityRoom> i = activityRooms.iterator();
        ActivityRoom activityRoom;
        while(i.hasNext()){
            activityRoom=(ActivityRoom)i.next();
            System.out.println(activityRoom.room_name);
            if(activityRoom.room_name.equals(room_name)){
               return false;
            }else if(activityRoom.information.equals(room_location)){
               return false; 
            }
        }
        return true;
    }
}
