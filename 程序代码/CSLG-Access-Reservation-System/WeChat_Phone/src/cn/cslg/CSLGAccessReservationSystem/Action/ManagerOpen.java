package cn.cslg.CSLGAccessReservationSystem.Action;

import java.net.Socket;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import cn.cslg.CSLGAccessReservationSystem.DatabaseConnector.DBMySQLConnection;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ManagerOpen extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
                                 HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int index = 0;
        try {
            DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
            String sql = "SELECT * FROM Open;";
            DBMySQLConnection.getPstmt(sql);
            ResultSet resultSet = DBMySQLConnection.query();
            try{
                while(resultSet != null & resultSet.next()){
                    index = resultSet.getInt(1);
                    break;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                DBMySQLConnection.allClose();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        index++;
        DBMySQLConnection DBMySQLConnection = new DBMySQLConnection();
        String sql = "UPDATE Open SET `index` = " + index + ";";
        DBMySQLConnection.getPstmt(sql);
        DBMySQLConnection.update();
        DBMySQLConnection.allClose();
        return mapping.findForward("lock_main");
    }
}
