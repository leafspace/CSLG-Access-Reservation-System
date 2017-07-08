package cn.cslg.CSLGAccessReservationSystem.Action;

import cn.cslg.CSLGAccessReservationSystem.DatabaseConnector.DBMySQLConnection;
import cn.cslg.CSLGAccessReservationSystem.ActionForm.ReservationActionForm;
import cn.cslg.CSLGAccessReservationSystem.ServerBean.ReservationMessage;
import cn.cslg.CSLGAccessReservationSystem.ServerBean.ActivityRoom;
import cn.cslg.CSLGAccessReservationSystem.ServerBean.Time;
import cn.cslg.CSLGAccessReservationSystem.ServerBean.User;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.ResultSet;

/**
 * Created by Administrator on 2017/7/8.
 */
public class ReservationAction extends Action {
    private boolean checkTime(ReservationActionForm reservationActionForm) {
        int year = -1;
        int month = -1;
        int day = -1;
        int start = -1;
        int finish = -1;
        int room_id = -1;
        int[] monthDay = new int[]{31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        try {
            year = Integer.parseInt(reservationActionForm.getYear());
            month = Integer.parseInt(reservationActionForm.getMonth());
            day = Integer.parseInt(reservationActionForm.getDay());
            start = Integer.parseInt(reservationActionForm.getStart());
            finish = Integer.parseInt(reservationActionForm.getFinish());
            room_id = Integer.parseInt(reservationActionForm.getRoom_id());
        } catch (NumberFormatException exception) {
            return false;
        }
        
        if (month < 1 | month > 12) {
            return false;
        }
        
        if (day < 0 | day > monthDay[month-1]) {
            return false;
        }
        
        int startHour = start / 100;
        int startMinute = start % 100;
        int finishHour = finish / 100;
        int finishMinute = finish % 100;
        
        if (startHour < 0 | startHour >= 24
                | finishHour < 0 | finishHour >= 24) {
            return false;
        }

        if (startMinute < 0 | startMinute >= 60
                | finishMinute < 0 | finishMinute >= 60) {
            return false;
        }
        
        if (finishHour < startHour) {
            return false;
        }
        
        if (finishHour == startHour && finishMinute <= startMinute) {
            return false;
        }
        
        return true;
    }

    private boolean checkReservationMessage(ReservationMessage reservationMessage) {
        Time time = reservationMessage.time;
        ArrayList<Time> arrayListTime = new ArrayList<Time>();

        //Todo 检查预约活动开始事件必须小于结束事件
        if(time.start > time.finish) {
            return false;
        }

        //Todo 检查预约时间内房间未被管理员锁定 | 预约时间内是否跟其余用户有所交叉
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        DBMySQLConnection.getPstmt("SELECT year,month,day,start,finish FROM Reservations;");
        ResultSet resultSet = DBMySQLConnection.query();
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
            DBMySQLConnection.allClose();
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

    public void writeReservationMessageQrLoacation(ReservationMessage reservationMessage) {
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        DBMySQLConnection.getPstmt("SELECT reservation_id FROM Reservations WHERE user_id = " + reservationMessage.user.getUserID()
                + " AND room_id = " + reservationMessage.room.room_id + " AND year = " + reservationMessage.time.year + " AND month = "
                + reservationMessage.time.month + " AND day = " + reservationMessage.time.day + " AND start = " + reservationMessage.time.start
                + " AND finish = " + reservationMessage.time.finish + ";");
        ResultSet resultSet = DBMySQLConnection.query();
        try {
            if(resultSet.next()) {
                reservationMessage.reservation_id = resultSet.getString(1);
                DBMySQLConnection.getPstmt("UPDATE Reservations SET qr_location = '../qr_img/qr"
                        + reservationMessage.reservation_id + ".jpg' WHERE reservation_Id = " + reservationMessage.reservation_id + ";");
                DBMySQLConnection.update();
            } else {
                return ;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBMySQLConnection.allClose();
        }
    }
    
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
                                 HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        User user = (User) request.getSession().getAttribute("User");
        ReservationActionForm reservationActionForm = (ReservationActionForm) form;
        if (user == null) {
            return mapping.findForward("error");
        }

        if (!this.checkTime(reservationActionForm)) {
            return mapping.findForward("error");
        }

        boolean isValid = false;
        if(!user.getIsTemporary()) {
            isValid = true;
        }

        ActivityRoom activity_room = new ActivityRoom(reservationActionForm.getRoom_id());
        Time time = new Time(Integer.parseInt(reservationActionForm.getYear()), Integer.parseInt(reservationActionForm.getMonth()),
                Integer.parseInt(reservationActionForm.getDay()), Integer.parseInt(reservationActionForm.getStart()),
                        Integer.parseInt(reservationActionForm.getFinish()));
        
        ReservationMessage reservationMessage = new ReservationMessage(user, activity_room, time, isValid, false, reservationActionForm.getInformation());
        boolean isSuccessed = this.checkReservationMessage(reservationMessage);
        if(isSuccessed) {
            isSuccessed = user.reservationActivityRoom(reservationMessage);
        } else {
            return mapping.findForward("error");
        }
        if(isSuccessed) {
            this.writeReservationMessageQrLoacation(reservationMessage);
            System.out.println("Info (Reservation activity servlet) : The " + user.getUserName() + " reservation " + activity_room.room_name + " successfully !");
        } else {
            System.out.println("Error (Reservation activity servlet) : The " + user.getUserName() + " reservation " + activity_room.room_name + " failed !");
            return mapping.findForward("error");
        }

        return mapping.findForward("rese_main");
    }
}
