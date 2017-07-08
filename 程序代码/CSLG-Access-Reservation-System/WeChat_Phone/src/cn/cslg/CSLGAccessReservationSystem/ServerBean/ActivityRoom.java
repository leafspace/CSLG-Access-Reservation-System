package cn.cslg.CSLGAccessReservationSystem.ServerBean;

import cn.cslg.CSLGAccessReservationSystem.DatabaseConnector.DBMySQLConnection;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by 18852 on 2017/3/17.
 */
public class ActivityRoom {
    public String room_id = null;                                              //活动室标识编号
    public String room_name = null;                                            //活动室名称
    public String information = null;                                          //活动室备注信息

    public ActivityRoom(String room_id) {
       
        this.room_id = room_id;
        this.getDataFromDatabase(this.room_id);
    }
    
     public ActivityRoom(String room_name, String information) {
        this.room_name = room_name;
        this.information = information;
    }

    public ActivityRoom(String room_id, String room_name, String information) {
        this.room_id = room_id;
        this.room_name = room_name;
        this.information = information;
    }

    public void getDataFromDatabase(String room_id) {
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "SELECT * FROM ActivityRooms WHERE room_Id = '" + room_id + "';";
        DBMySQLConnection.getPstmt(sql);
        ResultSet resultSet = DBMySQLConnection.query();
        try{
            while(resultSet != null & resultSet.next()){
                this.room_id = resultSet.getString(1);
                this.room_name = resultSet.getString(2);     
                this.information = resultSet.getString(3);
                break;
            }
            
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBMySQLConnection.allClose();
        }
    }
}
