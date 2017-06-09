package cn.cslg.CSLGAccessReservationSystem.LocalServer;

import cn.cslg.CSLGAccessReservationSystem.ServerBean.ActivityRoom;
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
 * Created by Administrator on 2017/3/22.
 */
public class QueryAllActivityRoomServlet extends HttpServlet{
     Manager manager;
     User user;
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setCharacterEncoding("utf-8");                                //设置 编码格式
        user = (User) request.getSession().getAttribute("user");
        manager = (Manager) request.getSession().getAttribute("manager");
        
        ArrayList<ActivityRoom> activityRooms = null;
        String flag = request.getParameter("flag");
        
        if(manager != null){
            activityRooms = manager.queryAllRooms();
        }else{
            activityRooms = user.queryAllRooms();
        }
        
        boolean isSuccessed;
        if(activityRooms == null){
            isSuccessed = false;
            PrintWriter pw = response.getWriter();
            pw.print(isSuccessed);
            pw.close();
        }else{
            JSONArray jsonArray = arrayListToJSONArray(activityRooms);
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
     * ArrayList<ActivityRoom>转换为Json
     */
    public JSONArray arrayListToJSONArray( ArrayList<ActivityRoom> activityRooms){  
        
        ActivityRoom activityRoom;
        JSONArray jsonArray = new JSONArray();
        Iterator i=activityRooms.iterator();
        while(i.hasNext()){
            activityRoom=(ActivityRoom)i.next();
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("room_id",activityRoom.room_id);
            jsonObject.put("room_name",activityRoom.room_name);
            jsonObject.put("information",activityRoom.information);
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }
}
