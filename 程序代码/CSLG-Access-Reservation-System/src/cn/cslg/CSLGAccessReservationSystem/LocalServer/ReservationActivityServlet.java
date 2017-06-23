package cn.cslg.CSLGAccessReservationSystem.LocalServer;

import cn.cslg.CSLGAccessReservationSystem.ServerBean.*;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2017/3/21.
 */
public class ReservationActivityServlet extends HttpServlet {
    /**
    * Programmer:leafspace
    * Phone number:18852923073
    * Contact E-mail:18852923073@163.com
    * Create time:2017.4.16
    * Last edit:2017.4.16
    * Function:
    *   通过对预约信息的检阅来判断此消息是否能够被预约
    *   1）预约活动室开始时间必须小于结束事件
    *   2）预约活动室必须在指定时间内可行
    *       -预约期间内房间未被管理员锁定
    *       -预约期间内房间未被其余用户预约
    * */
    private boolean checkReservationMessage(ReservationMessage reservationMessage) {
        Time time = reservationMessage.time;
        ArrayList<Time> arrayListTime = new ArrayList<Time>();

        //Todo 检查预约活动开始事件必须小于结束事件
        if(time.start > time.finish) {
            return false;
        }

        //Todo 检查预约时间内房间未被管理员锁定 | 预约时间内是否跟其余用户有所交叉
        DBSqlServerConnection dbSqlServerConnection = new DBSqlServerConnection();
        dbSqlServerConnection.getPstmt("SELECT year,month,day,start,finish FROM Reservations;");
        ResultSet resultSet = dbSqlServerConnection.query();
        try {
            while (resultSet.next()) {
                int year = Integer.parseInt(resultSet.getString(1));
                int month = Integer.parseInt(resultSet.getString(2));
                int day = Integer.parseInt(resultSet.getString(3));
                int start = Integer.parseInt(resultSet.getString(4));
                int finish = Integer.parseInt(resultSet.getString(5));

                arrayListTime.add(new Time(year, month, day, start, finish));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbSqlServerConnection.allClose();
        }

        for (int i = 0; i < arrayListTime.size(); ++i) {
            Time tempListTime = arrayListTime.get(i);
            if(time.year != tempListTime.year | time.month != tempListTime.month | time.day != tempListTime.day) {
                continue;
            }

            //日期相同，Todo 看时间上是否存在交叉
            if(time.start <= tempListTime.start - 5){
                if(time.finish >= tempListTime.start - 5){
                    return false;
                }
            }else if(time.start <= tempListTime.finish + 5){
                return false;
            }
        }

        return true;
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        User user = null;
        Manager manager = null;
        if(request.getSession().getAttribute("user") == null) {                //从数据库中获取用户类
            manager = (Manager) request.getSession().getAttribute("manager");
            user = new User(manager.getUser_id());
        } else {
            user = (User) request.getSession().getAttribute("user");
        }

        String room_id = request.getParameter("room_id");                      //获取输入的room_id
        Time time = new Time(Integer.parseInt(request.getParameter("year")),
                Integer.parseInt(request.getParameter("month")),
                Integer.parseInt(request.getParameter("day")),
                getIntTime(request.getParameter("start")),
                getIntTime(request.getParameter("finish")));                   //获取输入的time，年，月，日,开始，结束格式
        
        String information = request.getParameter("information");              //获取输入的备注信息
        ActivityRoom activity_room = new ActivityRoom(room_id);

        //Todo 通过判定当前人员是否是管理员预约跟此人员是否为临时人员来确定这个预约消息是否有效isvalid跟这个预约是否为管理员锁定silock
        boolean isValid = false;
        boolean isLock = false;
        if(manager != null){
            isLock = true;
        } else {
            if(!user.getIsTemporary()) {
                isValid = true;
            }
        }

        ReservationMessage reservationMessage = new ReservationMessage(user, activity_room, time, isValid, isLock, information);
        boolean isSuccessed = checkReservationMessage(reservationMessage);
        if(isSuccessed){
            isSuccessed = user.reservationActivityRoom(reservationMessage);
            reservationMessage.CreateQrCodes();
        }
        if(isSuccessed) {
            System.out.println("Info (Reservation activity servlet) : The " + user.getUserName() + " reservation " + activity_room.room_name + " successfully !");
        } else {
            System.out.println("Error (Reservation activity servlet) : The " + user.getUserName() + " reservation " + activity_room.room_name + " failed !");
        }
        PrintWriter pw = response.getWriter();
        pw.print(isSuccessed);
        pw.close();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doGet(request, response);
    }
    
    /**
     * 将交互层输入的时间数据转换成int类型时间数据，如08：00—>800 ，10：00—>1000
     * 返回类型为int 如 800,1000
     */
    public int getIntTime(String time) {
        int newTime;
        String tmpStr = "";
        if(time.length() > 0) {
            for(int i = 0; i < time.length(); i++){
                String tmp = "" + time.charAt(i);
                if((tmp).matches("[0-9.]")) {
                    tmpStr += tmp;
                }
            }
        }
        newTime = Integer.parseInt(tmpStr);
        return newTime;
    }
}
