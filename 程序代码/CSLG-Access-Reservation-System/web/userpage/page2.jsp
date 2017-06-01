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
        <title>常熟理工学院二维码门禁预约系统 - 查询活动室预约</title>
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
    <body onload="getPORT_NAME(),getReservationMessage()">
    <!-- 外部容器 查询预约纪录 -->
    <div class="wrapper">
        <!-- 头部-->
        <header class="index_1">
            <!-- logo -->
            <div class="logo">
                <div id="orderID_2">
                    <img src="images/logo.png" alt="logo" title="常熟理工二维码门禁预约系统">
                    <a href="javascript:;" id="index_2"><%=user.getUserName()%></a>
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
        <div class="container_2">
            <!-- 内容标题 -->
            <div class="conTitle">
                <ul>
                    <li>活动室
                        <select name="room" id="query_room" onchange="getValue()"style="color:#000"disabled>

                        </select>
                    </li>
                    <li>查询方式
                        <select name="way" id="query_way" onchange="getValue()"style="color:#000">
                            <option value="0">查找本月预约</option>
                            <option value="1">查找上月预约</option>
                        </select>
                    </li>
                </ul>
            </div>
            <!-- 内容 -->
            <table >
                <thead>
                <tr>
                    <td>序号</td>
                    <td>日期</td>
                    <td>预约人</td>
                    <td>开始时间</td>
                    <td>结束时间</td>
                </tr>
                </thead>
                <tbody id="JS_info_list">

                </tbody>
            </table>
            <div class="scroll">
                <ul>
                    <li class="up">
                        <a href="javascript:;" id="JS_prev">上一页</a>
                    </li>
                    <li class="down">
                        <a href="javascript:;" id="JS_next">下一页</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    </body>

    <script type="text/javascript">
        var orderID_2 = document.getElementById('orderID_2');
        var pullDown = document.getElementsByClassName('pullDown')[0];

        orderID_2.onclick = function() {
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

        //测试的假数据数据格式最好按照此格式前端方便使用，字段当然就你们自定义了
        var list = new Array();
        var start;
        var end;
        var totalPageNum;
        var pagesize = 4;
        var pageNum;

        /*
         * 点击上一页按钮跳转响应事件
         */
        $('#JS_prev').click(function(){
            var h = '';
            if(end<=4){
                alert("此页为首页！");
            }else{
                for(var i=pagesize*(pageNum-2),ii=pagesize*(pageNum-1);i<ii;i++){
                    h += '<tr>';
                    h += '<td>'+ list[i]['num'] +'</td>';
                    h += '<td>'+ list[i]['date'] +'</td>';
                    h += '<td>'+ list[i]['name'] +'</td>';
                    h += '<td>'+ list[i]['starttime'] +'</td>';
                    h += '<td>'+ list[i]['endtime'] +'</td>';
                    h += '</tr>';
                }
                pageNum--;
                start=i;
                end=i;
                $('#JS_info_list').html(h);
            }


        })

        /*
         * 点击下一页按钮跳转响应事件
         */
        $('#JS_next').click(function(){
            var h = '';
            var i;
            var ii;
            if(totalPageNum>1){
                if(pageNum != totalPageNum){
                    pageNum++;
                    ii=(pagesize*pageNum)<list.length?pagesize*pageNum:list.length;
                    for(i=start;i<ii;i++){

                        h += '<tr>';
                        h += '<td>'+ list[i]['num'] +'</td>';
                        h += '<td>'+ list[i]['date'] +'</td>';
                        h += '<td>'+ list[i]['name'] +'</td>';
                        h += '<td>'+ list[i]['starttime'] +'</td>';
                        h += '<td>'+ list[i]['endtime'] +'</td>';
                        h += '</tr>';
                    }
                    $('#JS_info_list').html(h);
                    start=ii,end=ii;
                }else{
                    alert("此页为尾页！");
                }
            }else{
                alert("没有更多数据！");
            }
        })

        /*
         * 往table中动态添加<tr><td> 如序号 1 2 3  预约日期 2017/3/3 2017/4/5 等等
         */
        function input(){
            var h = '';
            var i;
            for(i=start;i<end;i++){
                h += '<tr>';
                h += '<td>'+ list[i]['num'] +'</td>';
                h += '<td>'+ list[i]['date'] +'</td>';
                h += '<td>'+ list[i]['name'] +'</td>';
                h += '<td>'+ list[i]['starttime'] +'</td>';
                h += '<td>'+ list[i]['endtime'] +'</td>';
                h += '</tr>';
            }
            pageNum++;
            start=i;
            $('#JS_info_list').html(h);
        }

        /*
         * 获取活动室预约记录，首次默认的查询记录为活动室A的本月预约记录
         * 可根据用户选择的活动室不同，和查询方式的不同，进行相应查询操作
         */
        function getReservationMessage(){
            var objSelect = document.getElementById("query_room");
            var query_roomValue;
            if(objSelect.selectedIndex!=-1){
                query_roomValue = objSelect.options[objSelect.selectedIndex].value;
            }else{
                query_roomValue = 1;
            }
            var myselect = document.getElementById("query_way");
            var index = myselect.selectedIndex ;                               //selectedIndex代表的是你所选中项的index
            var queryValue = myselect.options[index].value;
            var queryText = myselect.options[index].text;

            var tbody = document.getElementById("JS_info_list");

            var xmlhttp;
            if (window.XMLHttpRequest) {
                xmlhttp = new XMLHttpRequest();
            } else {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }

            //发送请求至后端 - 并传递参数数据
            xmlhttp.open("GET","QueryActivityRoomReservationMessageServlet?flag=query_reservationMessage&room_id="+query_roomValue+"&query_way="+queryText,true);
            xmlhttp.send();
            xmlhttp.onreadystatechange=function() {

                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    var x = xmlhttp.responseText;                             //josn从后台获得的reservationMessages Array消息
                    var array = eval(x);                                      //转化为数组处理
                    totalPageNum = parseInt(array.length / pagesize);         //计算总共显示的页数
                    if((array.length % pagesize) > 0){
                        totalPageNum += 1;
                    }
                    pageNum = 0;
                    var i=0;
                        for(i = 0; i < array.length; i++){
                            list[i]=new Array();
                            list[i]=['num','date','name','starttime','endtime'];
                            list[i]['num']=i+1;
                            list[i]['date']=array[i].date;
                            list[i]['name']=array[i].username;
                            list[i]['starttime']=array[i].start;
                            list[i]['endtime']=array[i].finish;

                        }
                    }
                   if(array.length<=pagesize){
                       start=0;
                       end=array.length;
                   }else{
                       start=0;
                       end=pagesize;
                   }
                    input();
            }
        }

        /*
         * 与servlet交互，获取数据库中所有的活动室，显示在select控件中
         */
        function getPORT_NAME()
        {
            query_room = document.getElementById('query_room');
            var xmlhttp;
            if (window.XMLHttpRequest) {
                xmlhttp = new XMLHttpRequest();
            } else {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            //发送请求至后端 - 并传递参数数据

            xmlhttp.open("GET","QueryAllActivityRoomServlet?flag=query_room",true);
            xmlhttp.send();
            xmlhttp.onreadystatechange = function() {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    query_room.disabled = false;
                    var msg = xmlhttp.responseText;
                    var array = eval(msg);
                    for(i = 0; i < msg.length; i++) {
                        option = document.createElement('option');
                        option.setAttribute('value', array[i].room_id);
                        option.innerHTML = array[i].room_name;
                        if(i == 0){
                            option.setAttribute("selected","selected");
                        }
                        query_room.appendChild(option);
                    }
                }
            }
        }

        /*
         * 根据用户选择的活动室和查询方式，进行相应的查询操作
         * 如选择活动室C，查询方式为：查询上月预约
         */
        function getValue(){
            getReservationMessage();
        }
    </script>
</html>