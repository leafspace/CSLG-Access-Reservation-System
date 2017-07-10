<%@ page import="java.util.ArrayList" %>
<%@ page import="cn.cslg.CSLGAccessReservationSystem.ServerBean.Time" %>
<%@ page import="cn.cslg.CSLGAccessReservationSystem.ServerBean.ReservationMessage" %>
<%@ page import="cn.cslg.CSLGAccessReservationSystem.ServerBean.Manager" %>
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
        Manager manager = (Manager) request.getSession().getAttribute("Manager");
        if (manager == null) {
            response.sendRedirect("error.jsp");
        }
        ArrayList<ReservationMessage> reservationMessages = manager.queryLockReservation();
        pageContext.setAttribute("reservationMessages", reservationMessages);
    %>
    <body class="templatemo-bg-gray">
        <h1>锁定列表</h1>
        <h2><a href="lock_info.jsp"><span class="gray">+</span> 新<span class="green">锁定</span></a></h2>
        <div class="container center-block templatemo-form-list-container templatemo-container">
            <div class="col-md-12">
            <table class="table table-striped table-hover">
              <thead>
                <tr>
                  <th>#</th>
                  <th>锁定时间</th>
                    <th>锁定地点</th>
                    <th>锁定备注</th>
                  <th class="text-right">解锁</th>
                </tr>
              </thead>
              <tbody>
              <%
                  for (ReservationMessage reservationMessage : reservationMessages) {
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
                      <a href="deLock.do?reservation_id=<%=reservationMessage.reservation_id%>" class="btn btn-info">
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