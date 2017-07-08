package cn.cslg.CSLGAccessReservationSystem.ActionForm;

import org.apache.struts.action.ActionForm;

/**
 * Created by Administrator on 2017/7/8.
 */
public class DelockActionForm extends ActionForm {
    private String reservation_id;

    public String getReservation_id() {
        return this.reservation_id;
    }

    public void setReservation_id(String reservation_id) {
        this.reservation_id = reservation_id;
    }
}
