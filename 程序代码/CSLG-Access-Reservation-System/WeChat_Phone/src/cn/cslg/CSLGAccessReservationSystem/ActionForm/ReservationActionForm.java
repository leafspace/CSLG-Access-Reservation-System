package cn.cslg.CSLGAccessReservationSystem.ActionForm;

import org.apache.struts.action.ActionForm;

/**
 * Created by Administrator on 2017/7/8.
 */
public class ReservationActionForm extends ActionForm {
    private String year;
    private String month;
    private String day;
    private String start;
    private String finish;
    private String room_id;
    private String information;
    
    public String getYear() {
        return this.year;
    }
    
    public String getMonth() {
        return this.month;
    }
    
    public String getDay() {
        return this.day;
    }
    
    public String getStart() {
        return this.start;
    }
    
    public String getFinish() {
        return this.finish;
    }
    
    public String getRoom_id() {
        return this.room_id;
    }
    
    public String getInformation() {
        return this.information;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public void setFinish(String finish) {
        this.finish = finish;
    }

    public void setRoom_id(String room_id) {
        this.room_id = room_id;
    }

    public void setInformation(String information) {
        this.information = information;
    }
}
