package cn.cslg.CSLGAccessReservationSystem.LocalServer;

import cn.cslg.CSLGAccessReservationSystem.ServerBean.ActivityRoom;
import cn.cslg.CSLGAccessReservationSystem.ServerBean.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;



/**
 * Created by Administrator on 2017/3/22.
 */
public class QueryAllActivityRoomServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setCharacterEncoding("utf-8");//设置 编码格式
        User userSession=(User)request.getSession().getAttribute("user");
        System.out.println ("执行到这！");
        ArrayList<ActivityRoom> activityRooms = null;
        String flag = request.getParameter("flag");
        
        System.out.println (flag);
        activityRooms = userSession.queryAllRooms();
        
        request.setAttribute("activityRooms", activityRooms);
        request.setAttribute("user",userSession);
        
        if(flag.equals("query_room")){
            JSONArray jsonArray=arrayListToJSONArray(activityRooms);
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
