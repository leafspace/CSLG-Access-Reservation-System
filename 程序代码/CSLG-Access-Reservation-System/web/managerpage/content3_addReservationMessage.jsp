<%@page import="cn.cslg.CSLGAccessReservationSystem.ServerBean.Manager"%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>预约管理</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="shortcut icon" href="door-icons.ico" type="image/x-icon"/>
    <link media="screen and (max-width: 1024px)" rel="stylesheet" href="css/style_phone.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        .container-fluid{margin: 0;padding: 0;}
        @media screen and (min-width: 768px){
            html,body,.container-fluid{width: 100%;height: 100%;}
        }
        .top_left{background: #c3d6dd;height: 100%}
        .top_right{background: #91b3bf;height: 100%;}
        .top_left h1{line-height: 5.1;text-align: right;padding: 0 15%;margin: 0;}
        .top_left a{padding: 10px 30px;float: right;border-color: #fff;background: transparent;margin-right: 20%;}
        .top_right>p{padding-right: 10%;color: #fff;line-height: 2.3}
        .top_right>p a{color:#fff;margin-left: 10px;}
        .top_right h3{color: #fff;line-height: 2}
        .top_right span{position: relative;top: 2px;}
        .top_right input{color: #fff;background: transparent;border: 1px solid #000;outline: none;height: 100%;}
        .top_right > div > h3{line-height: 100px;}
        .top_right > div > h3:first-child input{width: 150px;}
        .header > div:not(:first-child){padding: 5% 0;margin-top: 1%;}
        @media screen and (max-width: 1200px){
            .san{left: 25%!important;}
        }
    </style>
</head>
<% 
       request.setCharacterEncoding("utf-8");
       
       Manager manager = (Manager) request.getSession().getAttribute("manager");
    %>
<body onload="getRoom_name()"style="background: #787981">
<div class="container-fluid">
    <div class="col-lg-4 col-md-3  top_left ">
        <h1>预约管理</h1>
        <a href="./content3.jsp" class="btn-default btn" style="background: #fff;z-index: 999">返回</a>
    </div>
    <div class="san" style="z-index: 9999;position: absolute;left: 33.3%;top: 5%;width: 0;height: 0;border-top: 25px solid transparent;border-left: 30px solid #c3d6dd;border-bottom: 25px solid transparent;"></div>
    <div class="col-lg-8 col-md-9  top_right clearfix">
        <p class="text-right"><span><%=manager.getUsername()%></span>  <a href="/loginOut.do" method="post"> [退出] </a></p>
        <div class="col-sm-12">
            <h3>
                预约日期
                <input type="text" value="年">年
                <input type="text" value="月">月
                <input type="text" value="日">日
            </h3>
            <h3>
                开始时间
                <input type="text" value="--:--">
            </h3>
            <h3>
                结束时间
                <input type="text" value="--:--">
            </h3>
            <h3>
                活动信息备注
                <input type="text" style='height:80px;vertical-align: top'>
            </h3>
        </div>
        <h3 style="line-height: 5;text-align: center">
            <a href="javascript:;" class="btn btn-default">提交预约</a>
        </h3>
    </div>
    </div>
</div>
</body>
<script src="http://image.meilele.com/js/mll/jq.js?0419"></script>
<script src="./js/common.js"></script>
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
            alert("000");
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
             

             xmlhttp.open("GET","ReservationActivityServlet?flag=reservation&room_id="+query_roomValue+"&year="+year.value+"&month="+month.value+"&day="+date.value+"&start="+starttime.value+"&finish="+endtime.value+"&information="+information.value,true);
             xmlhttp.send();
             xmlhttp.onreadystatechange=function() {
                 if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                     var x=xmlhttp.responseText;
                     if(x=="true"){
                         alert("预约成功，3秒后跳转到首页");
                         setInterval(go, 1000);
                     }else{
                         alert("预约失败！");
                         location.href='page3.jsp';
                     }
                 }
             }
        }


        function go(){
            time--;
            if(time>0){
                document.getElementById("JS_submite").innerHTML=time;
            }else{
                location.href='index.jsp';
            }
        }

        function getRoom_name(){
            query_room = document.getElementById('query_room');
             var xmlhttp;
             if (window.XMLHttpRequest) {
                 xmlhttp=new XMLHttpRequest();
             } else {
                 xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
             }
 
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