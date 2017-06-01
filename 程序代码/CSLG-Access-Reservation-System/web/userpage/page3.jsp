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
        <title>常熟理工学院二维码门禁预约系统 - 预约活动室</title>
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
    <body onload="getRoom_name()"style="background: #787981">
        <!-- 外部容器 预约活动室 -->
        <div class="wrapper" style="background: #787981">
            <header class="index_1">
                <!-- logo -->
                <div class="logo">
                    <div id="orderID_4">
                        <img src="images/logo.png" alt="logo" title="常熟理工二维码门禁预约系统">
                        <a href="javascript:" id="index_4"><%=user == null ? "" : user.getUserName()%></a>
                    </div>
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
                <div class="title title_1">
                    <h1>常熟理工二维码门禁预约系统</h1>
                    <h3>Entrance guard reservation system</h3>
                </div>
            </header>
            <div class="container_4" style="height: 120%">
                <!-- 内容 -->
                <div class="content">
                    <!-- 内容标题 -->
                    <h1>
                        <img src="images/order.png" alt="图片加载失败">
                        预约活动室
                    </h1>
                    <!-- 主要内容 -->
                    <ul>
                        <li>预约日期
                            <label for="year">
                                <input id="year" style="IME-MODE: disabled;" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="4" name="year" type="text" placeholder="年" />
                                年
                            </label>
                            <label for="month">
                                <input id="month" style="IME-MODE: disabled;" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="2" name="month" type="text" placeholder="月" />
                                月
                            </label>
                            <label for="date">
                                <input id="date" style="IME-MODE: disabled;" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="2" name="date" type="text" placeholder="日" />
                                日
                            </label>
                        </li>
                        <li>开始时间
                            <label for="time">
                                <input id="starttime" name="time" type="time" placeholder="开始时间" />
                            </label>
                        </li>
                        <li>结束时间
                            <label for="time">
                                <input id="endtime" name="time1" type="time" placeholder="结束时间" />
                            </label>
                        </li>
                        <li>活动室
                            <select name="room" id="query_room"  style="width: 13%; " disabled>
                            </select>
                        </li>
                        <li>活动信息备注
                            <textarea id="information"></textarea>
                        </li>
                        <li style="overflow: hidden">
                            <a href="javascript:" id="JS_submite">提交预约</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </body>
    <script type="text/javascript">
        var orderID_4 = document.getElementById('orderID_4');
        var pullDown = document.getElementsByClassName('pullDown')[0];

        orderID_4.onclick = function() {
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
                    width && (docEle.style.fontSize = width/120 + "px");
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

        var num = 0;
        var month = document.getElementById('month');
        month.onkeyup = function (){
            if (this.value < 1 || this.value > 12) {
                this.value = 12;
            }
        }
        var date = document.getElementById('date');
        date.onkeyup = function (){
            if (this.value < 1 || this.value > 31) {
                this.value = 1;
            }
        }

        var year = document.getElementById('year'),
            month = document.getElementById('month'),
            date = document.getElementById('date'),
            starttime = document.getElementById('starttime'),
            endtime = document.getElementById('endtime');
                information=document.getElementById("information");

        document.getElementById('JS_submite').onclick = function(){
            if( !/^[0-9]*[1-9][0-9]*$/.test( year.value ) ){
                alert('请输入正确的年份!');
                return false;
            }else if( !/^[0-9]*[1-9][0-9]*$/.test( month.value ) ){
                alert('请输入正确的月份!');
                return false;
            }else if( !/^[0-9]*[1-9][0-9]*$/.test( date.value ) ){
                alert('请输入正确的日期!');
                return false;
            }
            if( starttime.value == '' || endtime.value == '' ){
                alert('请输填写时间!');
                return false;
            }
                reservation();

        }
        var time=3;
        /*
         * 与servlet交互 提交预约信息
         * 接收servlet返回的boolean 判断是否提交成功
         * 根据返回的boolean 做出相应的跳转操作
         */
        function reservation(){
            
             var objSelect = document.getElementById("query_room");
             var query_roomValue;
              if(objSelect.selectedIndex!=-1){
                  query_roomValue=objSelect.options[objSelect.selectedIndex].value;
              }else{
                  query_roomValue=1;
              }
              alert(query_roomValue);
            var xmlhttp;
             if (window.XMLHttpRequest) {
                 xmlhttp=new XMLHttpRequest();
             } else {
                 xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
             }
             //发送请求至后端 - 并传递参数数据

             xmlhttp.open("GET","ReservationActivityServlet?flag=reservation&room_id="+query_roomValue+"&year="+year.value+"&month="+month.value+"&day="+date.value+"&start="+starttime.value+"&finish="+endtime.value+"&information="+information.value,true);
             xmlhttp.send();
             xmlhttp.onreadystatechange=function() {
                 if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                     var x=xmlhttp.responseText;
                     if(x=="true"){
                         alert("提交预约成功，等待管理员审核，3秒钟后跳转到首页");
                         setInterval(go, 1000);
                     }else{
                         alert("提交预约失败，请重新操作");
                         location.href='page3.jsp';
                     }
                 }
             }
        }

        /*
         * 3秒钟倒数读秒
         * 秒值显示在提交按钮上
         */
        function go(){
            time--;
            if(time>0){
                document.getElementById("JS_submite").innerHTML=time; //每次设置的x的值都不一样了。
            }else{
                location.href='index.jsp';
            }
        }

         /*
         * 与servlet交互，获取数据库中所有的活动室，显示在select控件中
         */
        function getRoom_name(){
            query_room = document.getElementById('query_room');
             var xmlhttp;
             if (window.XMLHttpRequest) {
                 xmlhttp=new XMLHttpRequest();
             } else {
                 xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
             }
             //发送请求至后端 - 并传递参数数据
             
            // alert("执行到这！");
             xmlhttp.open("GET","QueryAllActivityRoomServlet?flag=query_room",true);
             xmlhttp.send();
             xmlhttp.onreadystatechange=function() {
                 if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                   query_room.disabled = false;
                   var msg = xmlhttp.responseText;
                   var array=eval(msg);
                   for(i = 0; i < msg.length; i++){
                       option = document.createElement('option');
                       option.setAttribute('value', array[i].room_id);
                       option.innerHTML = array[i].room_name;
                       if(i==0){
                           option.setAttribute("selected","selected");
                       }
                       query_room.appendChild(option);
                   }
               }
           }
        }
    </script>
</html>