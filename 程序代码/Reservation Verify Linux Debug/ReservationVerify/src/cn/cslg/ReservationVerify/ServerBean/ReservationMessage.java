package cn.cslg.ReservationVerify.ServerBean;

import cn.cslg.ReservationVerify.QR_CodeSupport.CreateParseCode;

import java.io.File;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by 18852 on 2017/3/17.
 */
public class ReservationMessage {
    public String reservation_id = null;                                      //预约id
    public User user = null;                                                  //用户名
    public ActivityRoom room = null;                                          //活动室类
    public Time time = null;                                                  //时间类
    public boolean isValid = true;                                            //判定是否有效
    public boolean isLock = false;                                            //判断此预约消息是否为管理员的锁定操作
    public String qr_location = null;                                         //二维码路径
    public String information = null;                                         //预约信息

    public ReservationMessage(String reservation_id) {
        this.reservation_id = reservation_id;
        this.getDataFromDatabase(reservation_id);
    }

    public ReservationMessage(User user, ActivityRoom room, Time time, boolean isValid, boolean isLock) {
        this.user = user;
        this.room = room;
        this.time = time;
        this.isValid = isValid;
        this.isLock = isLock;
    }

    public ReservationMessage(User user, ActivityRoom room, Time time, boolean isValid, boolean isLock, String information) {
        this.user = user;
        this.room = room;
        this.time = time;
        this.isValid = isValid;
        this.isLock = isLock;
        this.information = information;
    }
    public ReservationMessage(String reservation_id, User user, ActivityRoom room, Time time, boolean isValid, boolean isLock, String qr_location, String information) {
        this.reservation_id = reservation_id;
        this.user = user;
        this.room = room;
        this.time = time;
        this.isValid = isValid;
        this.isLock = isLock;
        this.qr_location = qr_location;
        this.information = information;
    }

    public void getDataFromDatabase(String reservation_id) {
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "SELECT * FROM Reservations WHERE reservation_Id = '" + reservation_id + "';";
        DBMySQLConnection.getPstmt(sql);
        ResultSet resultSet = DBMySQLConnection.query();
        try{
            while(resultSet != null & resultSet.next()){
                this.reservation_id = resultSet.getString(1);
                this.user = new User(resultSet.getString(2));
                this.room = new ActivityRoom(resultSet.getString(3));
                this.isValid = resultSet.getBoolean(4);
                this.isLock = resultSet.getBoolean(5);
                this.time = new Time(resultSet.getInt(6), resultSet.getInt(7), resultSet.getInt(8), resultSet.getInt(9),
                        resultSet.getInt(10));
                this.qr_location = resultSet.getString(11);
                this.information = resultSet.getString(12);
                break;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBMySQLConnection.allClose();
        }
    }

    /*
    * Programmer:leafspace
    * Phone number:18852923073
    * Contact E-mail:18852923073@163.com
    * Create time:2017.4.16
    * Last edit:2017.4.16
    * Function:
    *   生成预约二维码
    *   1）确定reservation_id
    *   2）通过reservation_id确定qr_location
    *   3）存储二维码
    * */
    public String CreateQrCodes() {
        //Todo 确定预约消息对应数据库中唯一的id
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        DBMySQLConnection.getPstmt("SELECT reservation_id FROM Reservations WHERE user_id = " + user.getUserID() + " AND room_id = " + room.room_id + " AND year = " +
                time.year + " AND month = " + time.month + " AND day = " + time.day + " AND start = " + time.start + " AND finish = " + time.finish + ";");
        ResultSet resultSet = DBMySQLConnection.query();
        try {
            if(resultSet.next()) {
                this.reservation_id = resultSet.getString(1);
            } else {
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBMySQLConnection.allClose();
        }

        //Todo 通过id确定一个唯一的存放二维码的路径
        this.qr_location = "qr_img/qr" + this.reservation_id + ".png";

        CreateParseCode cpCode = new CreateParseCode();
        String qr_information = "CSLG-AccessReservationSystem&reservation_id=" + this.reservation_id;
        boolean isSuccess = cpCode.createCode(qr_information, CreateParseCode.width, CreateParseCode.height, this.qr_location);
        if(!isSuccess) {
            System.out.println("Error (Create qr code) : The No." + this.reservation_id + " reservation message create qr code ('" + this.qr_location + "') failed !");
            return null;
        }
        System.out.println("Info (Create qr code) : The No." + this.reservation_id + " reservation message create qr code ('" + this.qr_location + "') successfully !");
        return this.qr_location;
    }

    public String ExplainQrCodes() {
        if(this.qr_location == null) {
            return null;
        }
        CreateParseCode cpCode = new CreateParseCode();
        String qrcode = cpCode.parseCode(new File(this.qr_location));

        if(qrcode == null) {
            System.out.println("Error (Explain qr code) : Can not explain '" + this.qr_location + "' !");
            return null;
        } else {
            System.out.println("Error (Explain qr code) : The '" + this.qr_location + "' data is " + qrcode + " !");
            return qrcode;
        }

    }
}
