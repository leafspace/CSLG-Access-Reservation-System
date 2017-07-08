package cn.cslg.CSLGAccessReservationSystem.Action;

import cn.cslg.CSLGAccessReservationSystem.ActionForm.DelockActionForm;
import cn.cslg.CSLGAccessReservationSystem.DatabaseConnector.DBMySQLConnection;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2017/7/8.
 */
public class DelockAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
                                 HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        DelockActionForm delockActionForm = (DelockActionForm) form;
        String reservation_id = delockActionForm.getReservation_id();

        DBMySQLConnection dbMySQLConnection = new DBMySQLConnection();
        String sql = "UPDATE reservations SET `lock` = FALSE WHERE reservation_Id = " + reservation_id + ";";
        dbMySQLConnection.getPstmt(sql);
        dbMySQLConnection.update();
        dbMySQLConnection.allClose();
        return mapping.findForward("lock_main");
    }
}
