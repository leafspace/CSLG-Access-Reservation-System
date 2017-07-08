<%@ page import="java.util.ArrayList" %>
<%@ page import="cn.cslg.CSLGAccessReservationSystem.ServerBean.User" %>
<%@ page import="cn.cslg.CSLGAccessReservationSystem.ServerBean.ActivityRoom" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<!DOCTYPE html>
<html>
	<head>
		<title>常熟理工学院二维码预约系统</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="css/font-awesome.css" rel="stylesheet">
		<link href="css/r-style.css" rel="stylesheet" type="text/css" media="all" />
		<script src="js/jquery-2.2.3.min.js"></script>
        <script type="application/x-javascript">
            addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
            function hideURLbar(){ window.scrollTo(0,1); }
        </script>
	</head>
    <%
        User user = (User) request.getSession().getAttribute("User");
        if (user == null) {
            response.sendRedirect("error.jsp");
        }

        ArrayList<ActivityRoom> activityRooms = user.queryAllRooms();
    %>
	<body>
        <div class="video" data-vide-bg="video/ship">
        <div class="center-container">
            <div class="w3ls-agileinfo">
                <h1> 新预约 </h1>
            </div>
            <div class="bg-agile">
                <h3>预约日期</h3>
                <div class="login-form">
                    <form action="reservation.do" method="post">
                        <input type="text"  name="year" placeholder="年（形式如：2020）" required="" />
                        <input type="text"  name="month" placeholder="月（形式如：1）" required="" />
                        <input type="text"  name="day" placeholder="日（形式如：1）" required="" />
                        <div class="left-w3-agile">
                            <input type="text"  name="start" placeholder="开始时间（形式如：1430 表示14：30）" required="" />
                        </div>
                        <div class="right-agileits">
                            <input type="text"  name="finish" placeholder="结束时间（形式如：1430 表示14：30）" required="" />
                        </div>
                        <h3>选择活动室</h3>
                        <select name="room_id" class="form-control">
                            <%
                                for (ActivityRoom activityRoom : activityRooms) {
                            %>
                                    <option value="<%=activityRoom.room_id%>"><%=activityRoom.room_name%></option>
                            <%
                                }
                            %>
                        </select>
                        <textarea name="information" placeholder="预约备注信息" ></textarea>
                        <input type="submit" value="提交">
                    </form>
                </div>
            </div>
            <script src="js/jquery.vide.min.js"></script>
        </div>
        </div>
	</body>
</html>