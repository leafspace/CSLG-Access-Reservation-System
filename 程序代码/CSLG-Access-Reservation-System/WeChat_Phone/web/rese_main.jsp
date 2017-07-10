<%@ page import="java.util.ArrayList" %>
<%@ page import="cn.cslg.CSLGAccessReservationSystem.ServerBean.User" %>
<%@ page import="cn.cslg.CSLGAccessReservationSystem.ServerBean.Time" %>
<%@ page import="cn.cslg.CSLGAccessReservationSystem.ServerBean.ReservationMessage" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<!DOCTYPE html>
    <head>
        <title>常熟理工学院二维码预约系统</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link rel="shortcut icon" href="door-icons.ico" type="image/x-icon"/>
        <link href="css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="css/templatemo_style.css" rel="stylesheet" type="text/css">
    </head>
    <%
        User user = (User) request.getSession().getAttribute("User");
        String show = request.getParameter("show");
        if (user == null) {
            response.sendRedirect("error.jsp");
        }

        if (show == null) {
            show = "ten";
        }

        if (!show.equals("ten") && !show.equals("more")) {
            show = "ten";
        }
        ArrayList<ReservationMessage> reservationMessages = user.queryReservation();
        if (reservationMessages == null) {
            reservationMessages = new ArrayList<ReservationMessage>();
        }
        pageContext.setAttribute("reservationMessages", reservationMessages);
    %>
    <body class="templatemo-bg-gray">
        <h1>我的预约列表</h1>
        <h2><a href="rese_info.jsp"><span class="gray">+</span> 新<span class="green">预约</span></a></h2>
        <div class="container center-block templatemo-form-list-container templatemo-container">
            <div class="col-md-12">
                <input name="show" <%if(show.equals("ten"))%>checked="checked"<%%> type="radio" value="" onclick="window.location.href='rese_main.jsp?show=ten';"/> &nbsp; 显示十条信息&nbsp;&nbsp;
                <input name="show" <%if(show.equals("more"))%>checked="checked"<%%> type="radio" value="" onclick="window.location.href='rese_main.jsp?show=more';"/> &nbsp; 显示全部信息
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                      <th>#</th>
                      <th>预约时间</th>
                        <th>预约地点</th>
                        <th>预约备注</th>
                      <th class="text-right">二维码</th>
                    </tr>
                    </thead>
                <tbody>
                <%
                    int showNumber = show.equals("ten") ?
                            reservationMessages.size() > 10 ? 10 : reservationMessages.size()
                            : reservationMessages.size();
                    for (int i = 0; i < showNumber; ++i) {
                    ReservationMessage reservationMessage = reservationMessages.get(i);
                %>
                        <tr>
                            <td><%=reservationMessage.reservation_id%></td>
                            <td>
                                <%
                                    Time time = reservationMessage.time;
                                    String hourStr = time.start / 100 + "";
                                    String minuteStr = time.start % 100 + "";
                                    if (time.start / 100 < 10) {
                                        hourStr = "0" + hourStr;
                                    }
                                    if (time.start % 100 < 10) {
                                        minuteStr = "0" + minuteStr;
                                    }
                                    String timeStr = time.year + "-" + time.month + "-" + time.day + " " +
                                            hourStr + ":" + minuteStr;
                                %>
                                <%=timeStr%>
                            </td>
                            <td><%=reservationMessage.room.room_name%></td>
                            <td><%=reservationMessage.information%></td>
                            <td class="text-right">
                                <%
                                    String location = reservationMessage.qr_location;
                                    if (location != null) {
                                        location = location.substring(3);
                                    }
                                %>
                                <a href="<%=location%>" target="_blank" class="btn btn-info">
                                    <i class="fa fa-arrow-circle-right"></i>
                                </a>
                            </td>
                        </tr>
                <%
                    }
                %>
                </tbody>
            </table>
            </div>
        </div>
    </body>
</html>