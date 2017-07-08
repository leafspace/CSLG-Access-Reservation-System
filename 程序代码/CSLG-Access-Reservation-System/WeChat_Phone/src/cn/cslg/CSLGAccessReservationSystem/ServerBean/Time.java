package cn.cslg.CSLGAccessReservationSystem.ServerBean;

/**
 * Created by 18852 on 2017/3/17.
 */
public class Time {
    public int year;
    public int month;
    public int day;
    public int start;                                                          //预约开始时间
    public int finish;                                                         //预约结束时间
    public boolean interval = true;                                            //表示上下午，true表示上午，false表示下午

    public Time(int year, int month, int day) {
        this.year = year;
        this.month = month;
        this.day = day;
    }

    public Time(int year, int month, int day, boolean interval) {
        this.year = year;
        this.month = month;
        this.day = day;
        this.interval = interval;
    }

    public Time(int year, int month, int day, int start, int finish) {
        this.year = year;
        this.month = month;
        this.day = day;
        this.start = start;
        this.finish = finish;
        this.interval = (this.start / 100 < 13);
    }
}