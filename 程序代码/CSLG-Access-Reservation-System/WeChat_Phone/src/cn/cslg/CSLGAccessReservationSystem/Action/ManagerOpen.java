package cn.cslg.CSLGAccessReservationSystem.Action;

import java.net.Socket;
import java.io.PrintWriter;

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
        try {
            Socket socket = new Socket("127.0.0.1", 5209);
            System.out.println("客户端启动成功");
            PrintWriter printWriter = new PrintWriter(socket.getOutputStream());
            printWriter.println("addIndex");
            printWriter.flush();
            printWriter.close();
            socket.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mapping.findForward("lock_main");
    }
}
