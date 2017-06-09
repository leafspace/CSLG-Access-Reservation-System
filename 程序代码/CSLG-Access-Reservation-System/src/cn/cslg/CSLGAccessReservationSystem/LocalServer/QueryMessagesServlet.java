package cn.cslg.CSLGAccessReservationSystem.LocalServer;

import cn.cslg.CSLGAccessReservationSystem.ServerBean.Manager;
import cn.cslg.CSLGAccessReservationSystem.ServerBean.ReservationMessage;

import java.util.Iterator;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.text.NumberFormat;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Created by Administrator on 2017/3/22.
 */
public class QueryMessagesServlet extends HttpServlet{
    Manager manager;
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setCharacterEncoding("utf-8");                                //设置 编码格式
         manager= (Manager) request.getSession().getAttribute("manager");      //获取session中的manager对象
         
        ArrayList<ReservationMessage> reservationMessages = null;
        reservationMessages = manager.queryMessages();                         //查询所有临时用户的预约消息
        
        JSONArray jsonArray = arrayListToJSONArray(reservationMessages);
        PrintWriter pw = response.getWriter();
        pw.print(jsonArray.toString());
        pw.close();
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doGet(request,response);
    }
    
     /**
     * ArrayList<ReservationMessage>转换为Json
     */
    public JSONArray arrayListToJSONArray( ArrayList<ReservationMessage> reservationMessages){   
        
        ReservationMessage reservationMessage;
        JSONArray jsonArray = new JSONArray();
        Iterator i = reservationMessages.iterator();
        while(i.hasNext()){
            
            reservationMessage = (ReservationMessage) i.next();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("reservation_id", reservationMessage.reservation_id);
            if(manager != null){
               jsonObject.put("room_name", reservationMessage.room.room_name); 
               jsonObject.put("room_id", reservationMessage.room.room_id); 
               
            }
            jsonObject.put("date", reservationMessage.time.year+"/"+reservationMessage.time.month+"/"+reservationMessage.time.day);
            jsonObject.put("username", reservationMessage.user.getUserName());
            jsonObject.put("start", intTimeToString(reservationMessage.time.start));
            jsonObject.put("finish", intTimeToString(reservationMessage.time.finish));
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }
    
    /**
     * 将数据库中的int类型时间数据转换为String类型数据 如800—>08:00
     * 不足4位在首位补0，添加  ： 时间间隔符
     * 返回类型为String 如 08:00
     */
    public String intTimeToString(int time){
        NumberFormat   formatter   =   NumberFormat.getNumberInstance();   
        formatter.setMinimumIntegerDigits(4);   
        formatter.setGroupingUsed(false);   
        String Time = formatter.format(time);   
        String newTime = "";
        for(int i = 0; i < Time.length(); i++){
                newTime += Time.charAt(i);
                if(newTime.length() == 2){
                    newTime += ":";
                }
        }
        return newTime;
    }
}
