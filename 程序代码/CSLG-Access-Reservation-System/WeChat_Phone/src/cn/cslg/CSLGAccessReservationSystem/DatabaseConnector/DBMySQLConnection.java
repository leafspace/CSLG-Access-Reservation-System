package cn.cslg.CSLGAccessReservationSystem.DatabaseConnector;

/**
 * Created by 18852 on 2017/7/7.
 */

import java.sql.*;

/**
 *  Java连接DB，实现DB先关操作工具类
 * 	JDBC - Java Data Base Connectivity
 * 		1: 加入数据库驱动jar包   copy至WEB-INF下的lib中
 * 		2: 获取数据库链接
 * 		3: 获取语句处理
 * 		4: 实现数据ARUD操作
 * 		5: 关闭数据库相关操作
 */
public class DBMySQLConnection {
	private static String ip = "192.168.198.129";
    private static int port = 3306;                                            //端口号
    private static String databaseName = "cslg_access_reservation_system";     //数据库名
    private static String driverName = "com.mysql.jdbc.Driver";                //驱动名
    private static String userName = "root";                                   //用户名    注：要修改
    private static String password = "123456";                                 //密码      注：要修改

    private Connection connection = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;

    /**
     * 获取数据库链接
     */
    private void getConnection() {
        String dbURL = "jdbc:mysql://" + DBMySQLConnection.ip + ":" + DBMySQLConnection.port +
                "/" + DBMySQLConnection.databaseName + "?useUnicode=true&characterEncoding=utf8&user=" 
        		+ DBMySQLConnection.userName + "&password=" + DBMySQLConnection.password;

        try {
            Class.forName(driverName);
            this.connection = DriverManager.getConnection(dbURL);
            System.out.println("Info (Database) : Sql Server 驱动加载成功 !");
        } catch (Exception e) {
            System.out.println("Info (Database) : Sql Server 驱动加载失败 !");
            e.printStackTrace();
        }
    }

    private boolean isConnection() {
        if(this.connection == null){
            return false;
        }else{
            return true;
        }
    }

    public DBMySQLConnection() {
    }

    public DBMySQLConnection(String userName, String password) {
        DBMySQLConnection.userName = userName;
        DBMySQLConnection.password = password;
    }

    /**
     * 获取语句处理 PreparedStatement
     */
    public PreparedStatement getPstmt(String sql) {
        this.getConnection();
        try {
            this.preparedStatement = this.connection.prepareStatement(sql);
            System.out.println("Info (Database) : Sql - " + sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return this.preparedStatement;
    }

    /**
     * 实现数据库更新操作
     * 	insert、update、delete
     */
    public void update() {
        if(!this.isConnection()){
            System.out.println("Error (Database) : Sql Server 未连接 !");
            return ;
        }

        try {
            this.preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 实现数据库查询操作
     * 	select
     */
    public ResultSet query() {
        if(!this.isConnection()){
            System.out.println("Error (Database) : Sql Server 未连接 !");
            return null;
        }

        try {
            this.resultSet = this.preparedStatement.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return this.resultSet;
    }

    /**
     * 关闭数据库相关操作
     */
    public void allClose() {
        if(this.resultSet != null) {
            try {
                this.resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if(this.preparedStatement != null) {
            try {
                this.preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if(this.connection != null) {
            try {
                this.connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
