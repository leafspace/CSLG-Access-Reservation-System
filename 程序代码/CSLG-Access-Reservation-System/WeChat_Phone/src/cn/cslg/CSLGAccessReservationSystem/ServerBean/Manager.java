package cn.cslg.CSLGAccessReservationSystem.ServerBean;

import cn.cslg.CSLGAccessReservationSystem.DatabaseConnector.DBMySQLConnection;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Created by 18852 on 2017/3/17.
 */
public class Manager {
    private String user_id = null;
    private String username = null;
    private String password = null;

	public Manager(String user_id) {
        this.user_id = user_id;
        this.getDataFromDatabase(user_id);
    }
	
	public Manager(String username, String password) {
        this.username = username;
        this.password = password;
    }
	
    public Manager(String user_id, String username, String password) {
        this.user_id = user_id;
        this.username = username;
        this.password = password;
    }

    public String getUser_id() {
        return this.user_id;
    }

    public String getUsername() {
        return this.username;
    }

    public String getPassword() {
        return this.password;
    }

	 public void getDataFromDatabase(String user_id) {
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "SELECT * FROM Users WHERE user_id = '" + user_id + "';";
        DBMySQLConnection.getPstmt(sql);
        ResultSet resultSet = DBMySQLConnection.query();
        try{
            while(resultSet != null & resultSet.next()){
                this.user_id = resultSet.getString(1);
                this.username = resultSet.getString(2);
                this.password = resultSet.getString(3);
                break;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBMySQLConnection.allClose();
        }
    }

    public ArrayList<User> queryAllUsers() {
        ArrayList<User> users = new ArrayList<User>();
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "SELECT user_id FROM Users;";
        DBMySQLConnection.getPstmt(sql);
        ResultSet resultSet = DBMySQLConnection.query();
        try{
            while(resultSet != null & resultSet.next()){
                User user = new User(resultSet.getString(1));
                if(user.getUserName() != null){
                   users.add(user); 
                }
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBMySQLConnection.allClose();
        }
        return users;
    }

      public boolean addUser(User user) {
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "INSERT INTO Users(userName, password, wechat_id, phone_number, identity_number, is_temporary, is_manager, information) VALUES('" +
                user.getUserName() + "', '" + user.getPassWord() + "', '" + user.getWeChatID() + "', '" + user.getPhoneNumber() + "', '" + user.getIdentityID()
                +"'," +(user.getIsTemporary() ? 1: 0) + ", 0,'" + user.information + "');";
        DBMySQLConnection.getPstmt(sql);
        DBMySQLConnection.update();
        DBMySQLConnection.allClose();
        return true;
    }

    public boolean deleteUser(String user_id) {
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "DELETE FROM Users WHERE user_id = " + user_id + ";";
        DBMySQLConnection.getPstmt(sql);
        DBMySQLConnection.update();
        DBMySQLConnection.allClose();
        return true;
    }

    public boolean updateUser(User user) {
        if(user.getUserID() == null){
            return false;
        }

        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "UPDATE Users SET userName = '" + user.getUserName() + "', password = '" + user.getPassWord() + "', wechat_id = '" + user.getWeChatID() +
                "', phone_number = '" + user.getPhoneNumber() + "', identity_number = '" + user.getIdentityID() + "', information = '" + user.information +
                "' WHERE user_id = " + user.getUserID() +";";
        DBMySQLConnection.getPstmt(sql);
        DBMySQLConnection.update();
        DBMySQLConnection.allClose();
        return true;
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

    public boolean addRoom(ActivityRoom activity_room) {
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "INSERT INTO ActivityRooms(room_name, information) VALUES('" + activity_room.room_name + "', '" + activity_room.information + "');";
        DBMySQLConnection.getPstmt(sql);
        DBMySQLConnection.update();
        DBMySQLConnection.allClose();
        return true;
    }

    public boolean deleteRoom(String room_id) {
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "DELETE FROM ActivityRooms WHERE room_id = " + room_id + ";";
        DBMySQLConnection.getPstmt(sql);
        DBMySQLConnection.update();
        DBMySQLConnection.allClose();
        return true;
    }

    public boolean updateRoom(ActivityRoom activity_room) {
        if(activity_room.room_id == null){
            return false;
        }

        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "UPDATE ActivityRooms SET room_name = '" + activity_room.room_name + "', information = '" + activity_room.information + "' WHERE room_Id = "
                + activity_room.room_id + ";";
        DBMySQLConnection.getPstmt(sql);
        DBMySQLConnection.update();
        DBMySQLConnection.allClose();
        return true;
    }

    public ArrayList<ReservationMessage> queryLockReservation() {
        ArrayList<ReservationMessage> reservationMessages = new ArrayList<ReservationMessage>();
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "SELECT reservation_Id FROM Reservations WHERE `lock` = true ORDER BY reservation_Id DESC;";
        DBMySQLConnection.getPstmt(sql);
        ResultSet resultSet = DBMySQLConnection.query();
        try{
            while(resultSet != null & resultSet.next()){
                ReservationMessage reservationMeeage = new ReservationMessage(resultSet.getString(1));
                reservationMessages.add(reservationMeeage);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBMySQLConnection.allClose();
        }
        return reservationMessages;
    }

    public ArrayList<ReservationMessage> queryAllReservation() {
        ArrayList<ReservationMessage> reservationMessages = new ArrayList<ReservationMessage>();
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "SELECT reservation_Id FROM Reservations WHERE valid = 1;";
        DBMySQLConnection.getPstmt(sql);
        ResultSet resultSet = DBMySQLConnection.query();
        try{
            while(resultSet != null & resultSet.next()){
                ReservationMessage reservationMeeage = new ReservationMessage(resultSet.getString(1));
                reservationMessages.add(reservationMeeage);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBMySQLConnection.allClose();
        }
        return reservationMessages;
    }

    public ArrayList<ReservationMessage> queryRoomUsage(Time time, ActivityRoom activity_room) {   //查询某个活动室的预约情况
        ArrayList<ReservationMessage> reservationMessages = new ArrayList<ReservationMessage>();
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "SELECT reservation_Id FROM Reservations WHERE room_id = '" + activity_room.room_id + "' and valid = 1 and year = " + time.year +";";
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

    public boolean addReservation(ReservationMessage reservation_message) {
        if(reservation_message.user.getUserID() == null){
            return false;
        }

        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "INSERT INTO Reservations(user_id, room_id, valid, `lock`, year, month, day, start, finish, qr_location, information) values(" + reservation_message.user.getUserID() +
                ", " + reservation_message.room.room_id + ", 1, " + reservation_message.isLock + ", " + reservation_message.time.year + ", " + reservation_message.time.month +
                ", " + reservation_message.time.day + ", " + reservation_message.time.start + ", " + reservation_message.time.finish + ", '" + reservation_message.qr_location +
                "', '" + reservation_message.information + "');";
        DBMySQLConnection.getPstmt(sql);
        DBMySQLConnection.update();
        DBMySQLConnection.allClose();
        return true;
    }

    //删除预约
    public boolean deleteReservation(String reservation_id) {
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "DELETE FROM Reservations WHERE reservation_Id = " + reservation_id + ";";
        DBMySQLConnection.getPstmt(sql);
        DBMySQLConnection.update();
        DBMySQLConnection.allClose();
        return true;
    }

    //更新预约信息
    public boolean updateReservation(ReservationMessage reservation_message) {
        if(reservation_message.reservation_id == null){
            return false;
        }

        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "UPDATE Reservations SET year = " + reservation_message.time.year + ", month = " + reservation_message.time.month + ", day = "
                + reservation_message.time.day + ", start = " + reservation_message.time.start + ", finish = " + reservation_message.time.finish + " WHERE reservation_Id = "
                + reservation_message.reservation_id + ";";
        DBMySQLConnection.getPstmt(sql);
        DBMySQLConnection.update();
        DBMySQLConnection.allClose();
        return true;
    }

    //查询消息
    public ArrayList<ReservationMessage> queryMessages() {
        ArrayList<ReservationMessage> reservationMessages = new ArrayList<ReservationMessage>();
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "SELECT reservation_Id FROM Reservations WHERE valid = 0;";
        DBMySQLConnection.getPstmt(sql);
        ResultSet resultSet = DBMySQLConnection.query();
        try{
            while(resultSet != null & resultSet.next()){
                ReservationMessage reservationMeeage = new ReservationMessage(resultSet.getString(1));
                reservationMessages.add(reservationMeeage);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBMySQLConnection.allClose();
        }
        return reservationMessages;
    }

    //管理消息
    public void manageMessage(String message_id, boolean valid) {
        if(valid == true){
            DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
            String sql = "UPDATE Reservations SET valid = 1 WHERE reservation_Id = " + message_id + ";";
            DBMySQLConnection.getPstmt(sql);
            DBMySQLConnection.update();
            DBMySQLConnection.allClose();
        }else{
            this.deleteReservation(message_id);
        }
    }
}
