package cn.cslg.CSLGAccessReservationSystem.LocalServer;

import cn.cslg.CSLGAccessReservationSystem.ServerBean.ReservationMessage;
import cn.cslg.CSLGAccessReservationSystem.ServerBean.User;

import java.util.Date;
import java.util.Calendar;
import java.util.Iterator;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Created by Administrator on 2017/3/21.
 */
public class QueryUserReservationMessageServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setCharacterEncoding("utf-8");                                //设置 编码格式
		User user=(User)request.getSession().getAttribute("user");                                             //定义一个用户以供测试
        String flag = (String)request.getParameter("flag");

        ArrayList<ReservationMessage> reservationMessages = user.queryReservation();
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
            reservationMessage = (ReservationMessage)i.next();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("reservation_id", reservationMessage.reservation_id);
            jsonObject.put("date", reservationMessage.time.year + "/" + reservationMessage.time.month + "/" + reservationMessage.time.day);
            jsonObject.put("start", intTimeToString(reservationMessage.time.start));
            jsonObject.put("duration", duration(intTimeToString(reservationMessage.time.start), intTimeToString(reservationMessage.time.finish)));
            jsonObject.put("qr_location", reservationMessage.qr_location);
            jsonObject.put("isValid", reservationMessage.isValid);
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }
     
     /**
     * 将数据库中的int类型时间数据转换为String类型数据 如800—>08:00
     * 不足4位在首位补0，添加  ： 时间间隔符
     * 返回类型为String 如 08：00
     */
    public String intTimeToString(int time){
        NumberFormat formatter = NumberFormat.getNumberInstance();
        formatter.setMinimumIntegerDigits(4);   
        formatter.setGroupingUsed(false);   
        String Time = formatter.format(time);
        String newTime = "";
        for(int i = 0; i < Time.length(); i++){
            newTime += Time.charAt(i);
            if(newTime.length() == 2) {
                newTime+=":";
            }
        }
        return newTime;
    }

    /**
     * 计算时间差
     * 将数据库中的int类型时间数据转换成String类型时间数据后，在转换成Date日期类型进行减法计算
     * 返回类型为String 如 **小时**分钟
     */
    public String duration(String time1, String time2){
        String durationTime = null;
        SimpleDateFormat format = new SimpleDateFormat("HH:mm");
        Date date1 = null;
        Date date2 = null;
        try { 
            date1 = format.parse(time1);
            date2 = format.parse(time2);
        } catch (ParseException e) { 
            e.printStackTrace(); 
        }  
        Calendar ca1 = Calendar.getInstance(); 
        Calendar ca2 = Calendar.getInstance(); 
        ca1.setTime(date1); 
        ca2.setTime(date2); 
        long distanceMin = (( ca2.getTimeInMillis()- ca1.getTimeInMillis())/1000/60);
        durationTime = distanceMin / 60 + "小时";
        if(distanceMin%60 != 0){
            durationTime += distanceMin % 60 + "分钟";
        }
        return durationTime;
    }
}
