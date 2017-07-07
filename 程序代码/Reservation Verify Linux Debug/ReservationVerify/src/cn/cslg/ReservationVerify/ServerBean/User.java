package cn.cslg.ReservationVerify.ServerBean;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.SQLException;

/**
 * Created by 18852 on 2017/3/17.
 */
public class User {
    private String user_id = null;
    private String username = null;
    private String password = null;
    private String wechat_id = null;
    private String phone_number = null;
    private String identity_number = null;                                     //学号或教工号
    public  String information = null;
    public  boolean is_temporary = false;

    public User(String user_id) {
        this.user_id = user_id;
        this.getDataFromDatabase(user_id);
    }

    public User(String username, String password, boolean is_temporary) {
        this.username = username;
        this.password = password;
        this.is_temporary = is_temporary;                                      //是否为临时注册
    }

    public User(String user_id, String username, String password, String wechat_id, boolean is_temporary) {
        this.user_id = user_id;
        this.username = username;
        this.password = password;
        this.wechat_id = wechat_id;
        this.is_temporary = is_temporary;                                      //是否为临时注册
    }
    
    public User(String username, String password, String wechat_id, String phone_number, String identity_number, String information, boolean is_temporary) {
        this.username = username;
        this.password = password;
        this.wechat_id = wechat_id;
        this.phone_number = phone_number;
        this.identity_number = identity_number;
        this.information = information;
        this.is_temporary = is_temporary;                                      //是否为临时注册
    }


    public User(String user_id, String username, String password, String wechat_id, String phone_number, String identity_number, String information, boolean is_temporary) {
        this.user_id = user_id;
        this.username = username;
        this.password = password;
        this.wechat_id = wechat_id;
        this.phone_number = phone_number;
        this.identity_number = identity_number;
        this.information = information;
        this.is_temporary = is_temporary;                                      //是否为临时注册
    }

    public String getUserID() {
        return user_id;
    }

    public String getUserName() {
        return username;
    }

    public String getPassWord() {
        return password;
    }

    public String getWeChatID() {		                                       //获取微信号
        return wechat_id;
    }

    public String getPhoneNumber() {
        return phone_number;
    }

    public String getIdentityID() {		                                       //获取学号|工号
        return identity_number;
    }

    public String getInformation() {
        return information;
    }

    public boolean getIsTemporary() {
        return this.is_temporary;
    }

    public void getDataFromDatabase(String user_id) {
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "SELECT * FROM Users WHERE user_id = '" + user_id + "'and is_manager=0;";
        DBMySQLConnection.getPstmt(sql);
        ResultSet resultSet = DBMySQLConnection.query();
        try{
            while(resultSet != null & resultSet.next()){
                
                this.user_id = resultSet.getString(1);
                this.username = resultSet.getString(2);
                this.password = resultSet.getString(3);
                this.wechat_id = resultSet.getString(4);
                this.phone_number = resultSet.getString(5);
                this.identity_number = resultSet.getString(6);                 //学号或教工号
                this.is_temporary = resultSet.getBoolean(7);
                this.information = resultSet.getString(9);
                break;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
           DBMySQLConnection.allClose();
        }
    }

    public boolean updateInformation(String password, String wechat_id, String phone_number, String identity_number, String information) { //用户修改个人信息
        //更新本对象中用户信息
        this.wechat_id = wechat_id;
        this.phone_number = phone_number;
        this.password = password;
        this.identity_number = identity_number;
        this.information = information;

        //数据库中更新用户信息
        if(this.user_id == null){
            return false;
        }

        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "UPDATE Users SET password = '" + this.password + "', wechat_id = '" + this.wechat_id + "', phone_number = '" + this.phone_number + "', " +
                "identity_number = '" + this.identity_number + "', information = '" + this.information +"' where user_id='"+this.user_id+ "';";
        DBMySQLConnection.getPstmt(sql);
        DBMySQLConnection.update();
        DBMySQLConnection.allClose();
        return true;
    }

    public ArrayList<ReservationMessage> queryRoomUsage(Time time, ActivityRoom activity_room) {   //查询某个活动室的预约情况
       
        ArrayList<ReservationMessage> reservationMessages = new ArrayList<ReservationMessage>();
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        
        String sql = "SELECT reservation_Id FROM Reservations WHERE room_id = '" + activity_room.room_id + "' and valid = 1 and year = " + time.year + " and month = "
                + time.month +";";
        DBMySQLConnection.getPstmt(sql);
        ResultSet resultSet = DBMySQLConnection.query();
        
         
        try{
            while(resultSet != null & resultSet.next()){
                ReservationMessage reservationMessage = new ReservationMessage(resultSet.getString(1));
                reservationMessages.add(reservationMessage);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBMySQLConnection.allClose();
        }
        return reservationMessages;
    }

    public ArrayList<ReservationMessage> queryReservation() {
        ArrayList<ReservationMessage> reservationMessages = new ArrayList<ReservationMessage>();
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "SELECT reservation_Id FROM Reservations WHERE user_id = " + this.user_id + ";";
        DBMySQLConnection.getPstmt(sql);
        ResultSet resultSet = DBMySQLConnection.query();
        try{
            while(resultSet != null & resultSet.next()){
                ReservationMessage reservationMessage = new ReservationMessage(resultSet.getString(1));
                reservationMessages.add(reservationMessage);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBMySQLConnection.allClose();
        }
        return reservationMessages;
    }

    public ArrayList<ActivityRoom> queryAllRooms() {
        ArrayList<ActivityRoom> activityRooms = new ArrayList<ActivityRoom>();
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "SELECT room_id FROM ActivityRooms;";
        DBMySQLConnection.getPstmt(sql);
        ResultSet resultSet = DBMySQLConnection.query();
        try{
            while(resultSet != null & resultSet.next()){
                ActivityRoom activityRoom = new ActivityRoom(resultSet.getString(1));
                activityRooms.add(activityRoom);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBMySQLConnection.allClose();
        }
        return activityRooms;
    }
    
    public boolean reservationActivityRoom(ReservationMessage reservation_message) {
        if(this.user_id == null){
            return false;
        }

        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "INSERT INTO Reservations(user_id, room_id, valid, lock, year, month, day, start, finish, qr_location, information) values(" + this.user_id +
                ", " + reservation_message.room.room_id + ", " + (this.is_temporary ? 0 : 1) + ", 0, " + reservation_message.time.year + ", " + reservation_message.time.month +
                ", " + reservation_message.time.day + ", " + reservation_message.time.start + ", " + reservation_message.time.finish + ", '" + reservation_message.qr_location +
                "', '" + reservation_message.information + "');";
        DBMySQLConnection.getPstmt(sql);
        DBMySQLConnection.update();
        DBMySQLConnection.allClose();
         return true;
    }
}