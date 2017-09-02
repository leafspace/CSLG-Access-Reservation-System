package cn.cslg.ReservationVerify.Thread;

import cn.cslg.ReservationVerify.ServerBean.DBMySQLConnection;

import java.sql.ResultSet;
import java.sql.SQLException;

public class WechatListenThread extends Thread {
    public boolean open;
    public WechatListenThread(){
        this.open = false;
    }

    public int getIndexOpen() {                                              //获取还有多少次开门机会
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "SELECT * FROM Open;";
        DBMySQLConnection.getPstmt(sql);
        ResultSet resultSet = DBMySQLConnection.query();
        int index = -1;
        try{
            while(resultSet != null & resultSet.next()){
                index = resultSet.getInt(1);
                break;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBMySQLConnection.allClose();
        }
        return index;
    }

    public void freeIndexOpen() {                                            //开门一次
        int index = this.getIndexOpen();
        if (index <= 0) {
            return ;
        }
        index--;
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "UPDATE Open SET `index` = " + index + ";";
        DBMySQLConnection.getPstmt(sql);
        DBMySQLConnection.update();
        DBMySQLConnection.allClose();
    }

    @Override
    public void run() {
        while (true) {
            int index = this.getIndexOpen();
            if (index > 0) {
                this.open = true;
            }
        }
    }
}
