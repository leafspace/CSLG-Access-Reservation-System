<%--
    Created by IntelliJ IDEA.
    User: Administrator
    Date: 2017/4/14
    Time: 21:00
    To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cn.cslg.CSLGAccessReservationSystem.ServerBean.User" %>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <title>常熟理工学院二维码门禁预约系统 - 首页</title>
        <meta name="format-detection" content="telephone=no">
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="apple-mobile-web-app-status-bar-style" content="white" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=yes"/>
        <link rel="stylesheet" media="all" href="css/style.css" />
        <link rel="stylesheet" media="all" href="css/reset.css" />
        <link rel="shortcut icon" href="door-icons.ico" type="image/x-icon"/>
        <link media="screen and (max-width: 1024px)" rel="stylesheet" href="css/style_phone.css"/>
        <%
            User user = (User) request.getSession().getAttribute("user");
        %>
    </head>
    <body>
        <!-- 外部容器 首页 -->
        <div class="wrapper">
            <!-- 头部-->
            <header class="index">
                <!-- logo -->
                <div class="logo logo_1">
                    <!-- logo图片及其描述 -->
                    <div id="orderID">
                        <img src="images/logo.png" alt="logo" title="常熟理工二维码门禁预约系统">
                        <a href="javascript:" id="index"><%=user.getUserName()%></a>
                    </div>
                    <!-- 下拉框 -->
                    <ul class="pullDown">
                        <li>
                            <a href="index.jsp">首页</a>
                        </li>
                        <li>
                            <a href="page1.jsp">修改资料</a>
                        </li>
                        <li>
                            <a href="page4.jsp">查看预约</a>
                        </li>
                    </ul>
                </div>
                <!-- 标题 -->
                <div class="title box box-element">
                    <h1>常熟理工二维码门禁预约系统</h1>
                    <h3>Entrance guard reservation system</h3>
                </div>
            </header>
            <!-- 内容外部容器 -->
            <div class="container">
                <!-- 内容 -->
                <table style="width: 83%;height:100%;margin:auto">
                    <tr>
                        <td style="vertical-align: middle;text-align: center;"><a href="page2.jsp">
                            <img style="width: 45%" src="images/door.png" alt="图片加载失败" title="预约">
                        </a>
                        <p>
                            <a href="page2.jsp">查看活动室预约</a>
                        </p></td>
                        <td style="vertical-align: middle;text-align: center;"><a href="page3.jsp">
                            <img style="width: 45%" src="images/query.png" alt="图片加载失败" title="搜索">
                        </a>
                        <p>
                            <a href="page3.jsp">预约活动室</a>
                        </p></td>
                    </tr>
                </table>
            </div>
        </div>
    </body>
</html>

<script type="text/javascript">
    var orderID = document.getElementById('orderID');
    var pullDown = document.getElementsByClassName('pullDown')[0];

    orderID.onclick = function() {
        (pullDown.style.display == 'block') ? pullDown.style.display = 'none' : pullDown.style.display = 'block';
    }
    window.onresize = function(){
        document.body.innerHeight = window.innerHeight;
    }

    !(function(doc, win) {
        var docEle = doc.documentElement,
            evt = "onorientationchange" in window ? "orientationchange" : "resize",
            fn = function() {
                var width = docEle.clientWidth;
                if(width > 1024){
                    width && (docEle.style.fontSize = width / 120 + "px");
                }
            };
        win.addEventListener(evt, function(){
            fn();
            setTimeout(fn,50);
        }, false);
        doc.addEventListener("DOMContentLoaded", function(){
            fn();
            setTimeout(fn,50);
        }, false);
    }(document, window));
</script>