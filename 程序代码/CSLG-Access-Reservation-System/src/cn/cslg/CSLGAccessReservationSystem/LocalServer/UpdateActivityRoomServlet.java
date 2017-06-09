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
public class UpdateActivityRoomServlet extends HttpServlet{
    Manager manager;
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException{
        manager = (Manager) request.getSession().getAttribute("manager");
        
        
        String room_id = request.getParameter("room_id");
        String room_name = request.getParameter("activityRoomName");
        String information = request.getParameter("activityRoomLocation");
        
        ActivityRoom activityRoom = new ActivityRoom(room_id,room_name,information);
        
        boolean isSuccessed;
        isSuccessed = queryActivityName(room_id,room_name,information);
        if(isSuccessed){
           manager.updateRoom(activityRoom);
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
     * 判断数据库中是否已存在当前活动室
     * @param room_name
     * @return 
     */
    public boolean queryActivityName(String room_id,String room_name,String room_location) {
        ArrayList<ActivityRoom> activityRooms = new ArrayList<ActivityRoom>();
        activityRooms = manager.queryAllRooms();
        
       
        Iterator<ActivityRoom> i = activityRooms.iterator();
        ActivityRoom activityRoom;
        while(i.hasNext()){
            activityRoom = (ActivityRoom)i.next();
            if(activityRoom.room_name.equals(room_name) && !activityRoom.room_id.equals(room_id)) {
               return false;
            }else if(activityRoom.information.equals(room_location) && !activityRoom.room_id.equals(room_id)) {
               return false; 
            }
        }
        return true;
    }
}
