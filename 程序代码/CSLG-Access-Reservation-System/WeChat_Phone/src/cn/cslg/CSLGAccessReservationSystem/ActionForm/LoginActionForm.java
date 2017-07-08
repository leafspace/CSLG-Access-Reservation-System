package cn.cslg.CSLGAccessReservationSystem.ActionForm;

import org.apache.struts.action.ActionForm;

/**
 * Created by Administrator on 2017/7/8.
 */
public class LoginActionForm extends ActionForm {
    private String username;
    private String password;

    public String getUsername() {
        return this.username;
    }

    public String getPassword() {
        return this.password;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}