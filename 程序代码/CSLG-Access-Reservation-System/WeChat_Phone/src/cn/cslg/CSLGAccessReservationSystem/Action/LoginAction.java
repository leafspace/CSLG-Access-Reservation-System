package cn.cslg.CSLGAccessReservationSystem.Action;

import cn.cslg.CSLGAccessReservationSystem.DatabaseConnector.DBMySQLConnection;
import cn.cslg.CSLGAccessReservationSystem.ActionForm.LoginActionForm;
import cn.cslg.CSLGAccessReservationSystem.ServerBean.Manager;
import cn.cslg.CSLGAccessReservationSystem.ServerBean.User;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by Administrator on 2017/7/8.
 */
public class LoginAction extends Action {
    private int checkUser(String username, String password) {
        int user_id = -1;
        DBMySQLConnection dbMySQLConnection = new DBMySQLConnection();
        String sql = "SELECT user_id FROM Users WHERE userName = '" + username + "' AND `password` = '" + password + "';";
        dbMySQLConnection.getPstmt(sql);
        ResultSet resultSet = dbMySQLConnection.query();
        try{
            while(resultSet != null & resultSet.next()){
                user_id  = resultSet.getInt(1);
                break;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            dbMySQLConnection.allClose();
        }
        return user_id;
    }

    private boolean checkISManager(int user_id) {
        DBMySQLConnection dbMySQLConnection = new DBMySQLConnection();
        String sql = "SELECT is_manager FROM Users WHERE user_id = " + user_id + ";";
        dbMySQLConnection.getPstmt(sql);
        ResultSet resultSet = dbMySQLConnection.query();
        try{
            while(resultSet != null & resultSet.next()){
                return resultSet.getBoolean(1);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            dbMySQLConnection.allClose();
        }
        return false;
    }

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
                                 HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        LoginActionForm loginActionForm = (LoginActionForm) form;
        String username = loginActionForm.getUsername();
        String password = loginActionForm.getPassword();

        int user_id = this.checkUser(username, password);
        if (user_id > 0) {
            if (this.checkISManager(user_id)) {
                Manager manager = new Manager(user_id + "");
                request.getSession().setAttribute("Manager", manager);
                return mapping.findForward("managerPage");
            } else {
                User user = new User(user_id + "");
                request.getSession().setAttribute("User", user);
                return mapping.findForward("userPage");
            }
        }
        return mapping.findForward("error");
    }
}
