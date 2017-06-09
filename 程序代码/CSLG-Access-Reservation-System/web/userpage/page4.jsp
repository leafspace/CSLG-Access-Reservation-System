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
        <title>常熟理工学院二维码门禁预约系统 - 查询预约</title>
        <meta name="format-detection" content="telephone=no">
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="apple-mobile-web-app-status-bar-style" content="white" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=yes"/>
        <link rel="stylesheet" media="all" href="css/style.css" />
        <link rel="stylesheet" media="all" href="css/reset.css" />
        <link rel="shortcut icon" href="door-icons.ico" type="image/x-icon"/>
        <link media="screen and (max-width: 1024px)" rel="stylesheet" href="css/style_phone.css"/>
        <style>
            .btn-default {
                color: #333;
                background-color: #fff;
                border-color: #ccc;
            }
            .btn {
                display: inline-block;
                padding: 6px 12px;
                margin-bottom: 0;
                font-size: 14px;
                font-weight: 400;
                line-height: 1.42857143;
                text-align: center;
                white-space: nowrap;
                vertical-align: middle;
                -ms-touch-action: manipulation;
                touch-action: manipulation;
                cursor: pointer;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
                background-image: none;
                border: 1px solid transparent;
                border-radius: 4px;
            }

            a {
                color: #337ab7;
                text-decoration: none;
            }

        </style>
        <%
            User user = (User) request.getSession().getAttribute("user");
        %>
    </head>
    <body onload="getUserReservationMessages()">
        <!-- 外部容器 查询我的预约 -->
        <div class="wrapper">
            <!-- 头部-->
            <header class="index_1">
                <!-- logo -->
                <div class="logo">
                    <div id="orderID_3">
                        <img src="images/logo.png" alt="logo" title="常熟理工二维码门禁预约系统">
                        <a href="javascript:" id="index_3"><%=user.getUserName()%></a>
                    </div>
                    <ul class="pullDown">
                        <li>
                            <a href="index.jsp">首页</a>
                        </li>
                        <li>
                            <a href="page1.jsp">修改资料</a>
                        </li>
                        <li>
                            <a href="">查看预约</a>
                        </li>
                    </ul>
                </div>
                <!-- 标题 -->
                <div class="title title_1">
                    <h1>常熟理工二维码门禁预约系统</h1>
                    <h3>Entrance guard reservation system</h3>
                </div>
            </header>
            <!-- 内容外部容器 -->
            <div class="container_3">
                <!-- 内容标题 -->
                <div class="conTitle">
                    <img src="images/claw.png" alt="图片加载失败">
                    我的预约和二维码
                </div>
                <!-- 内容 -->
                <table id="JS_table">

                </table>
                <div class="scroll">
                    <ul id="JS_ul">
                        <li class="up" id="li_prev">
                            <a href="javascript:" id="JS_prev">上一页</a>
                        </li>
                        <li class="down">
                            <a href="javascript:" id="JS_next">下一页</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </body>

    <script src="http://image.meilele.com/js/mll/jq.js?0419"></script>
    <script type="text/javascript">
        var orderID_3 = document.getElementById('orderID_3');
        var pullDown = document.getElementsByClassName('pullDown')[0];
        var pullDown_1 = document.getElementsByClassName('pullDown')[1];
        var pullDown_2 = document.getElementsByClassName('pullDown')[2];
        var pullDown_3 = document.getElementsByClassName('pullDown')[3];
        var pullDown_4 = document.getElementsByClassName('pullDown')[4];

        orderID_3.onclick = function() {
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

        var list=new Array();
        var list1=['num','date','start','duration','qr_location','reservation_id']
        var start;
        var end;
        var totalPageNum;
        var pagesize=4;
        var pageNum;



        function cancelReservation(reservation_id){
            var xmlhttp;
            if (window.XMLHttpRequest) {
                xmlhttp=new XMLHttpRequest();
            } else {
                xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
            }

            //发送请求至后端 - 并传递参数数�?
            xmlhttp.open("GET","DeleteReservationServlet?reservation_id="+reservation_id,true);
            xmlhttp.send();
            xmlhttp.onreadystatechange=function() {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    var x=xmlhttp.responseText;
                    response=x;
                    if(response=="true"){
                        alert("已成功取消预约!");
                        location.href ='';

                    }
                }
            }

        }

        /*
         * 点击上一页按钮跳转响应事件
         */
        $('#JS_prev').click(function(){
            var h = '';
                if(end<=4){
                    alert("此页为首页！");
                }else{
                    start=pagesize*(pageNum-2);
                    end=pagesize*(pageNum-1);
                    $("#JS_table tr").remove();//将第一行之后的行全部移除（留表头）
                     $("#JS_ul ul").remove();
                    input();
                    pageNum-=2;
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
                    if(pageNum!=totalPageNum){
                        pageNum++;
                        ii=(pagesize*pageNum)<list.length?pagesize*pageNum:list.length;
                        end=ii;
                        pageNum--;
                        $("#JS_table tr").remove();
                        $("#JS_ul ul").remove();
                        input();

                        start=ii;
                    }else{
                        alert("此页为尾页！");
                    }
                }else{
                    alert("没有更多数据！");
                }
        })

        /*
         * 点击页数按钮跳转响应事件
         */
        function gotoPageNum(pagenum){
            if(totalPageNum>1){
                if(pagenum==1){
                    start=0;
                    end=pagesize*pagenum;
                }else{
                    start=pagesize*(pagenum-1);
                    end=(pagesize*pagenum)<list.length?pagesize*pagenum:list.length;
                }
            }else if(totalPageNum == 1 && pagenum == 1){
                start = 0;
                end = list.length;
            }
             $("#JS_table tr").remove();
             $("#JS_ul ul").remove();
           input();
           pageNum=pagenum;

        }

        /*
         * 往table中动态添加<tr><td> 如序号 1 2 3  预约日期 2017/3/3 2017/4/5 等等
         * 往ul中动态添加<li> 如 1，2，3页数按钮
         */
        function input(){
            var h = '';
            var li='';
            var i;
            var j;
            h+='<tr><td>序号</td>';
              for(i=start;i<end;i++){
                  h+='<td>'+ list[i]['num'] +'</td>';
              }
              h+='</tr><tr><td>预约日期</td>'
              for(i=start;i<end;i++){
                  h+='<td>'+ list[i]['date'] +'</td>';
              }
              h+='</tr><tr><td>开始时间</td>'
              for(i=start;i<end;i++){
                  h+='<td>'+ list[i]['start'] +'</td>';
              }
               h+='</tr><tr><td>持续时间</td>'
              for(i=start;i<end;i++){
                  h+='<td>'+ list[i]['duration'] +'</td>';
              }
               h+='</tr><tr><td>二维码</td>'
              for(i=start;i<end;i++){
                  h+='<td>'+ list[i]['qr_location'] +'</td>';
              }
               h+='</tr><tr><td>取消预约</td>'
              for(i=start;i<end;i++){
                  h+='<td><a href="javascript:cancelReservation('+list[i]['reservation_id']+');" class="btn btn-default">取消</a></td>';
              }
              h+='</tr>'

              li+='<ul>'
              for(j=1;j<=totalPageNum;j++){
                  li+='<li>'
                     li+='<a href="javascript:gotoPageNum('+j+');" id="'+j+'">'+j+'</a>';
                  li+='</li>';
              }
             li+='</ul>'
              pageNum++;
              start=i;
            $('#JS_table').append(h);
            $('#li_prev').after(li);

        }

        /*
         * 接收servlet传递的预约记录数据
         * 将Json类型转换成二维数组，以便存入table
         */
        function getUserReservationMessages(){
             var xmlhttp;
             if (window.XMLHttpRequest) {
                 xmlhttp=new XMLHttpRequest();
             } else {
                 xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
             }
             //发送请求至后端 - 并传递参数数据

             xmlhttp.open("GET","QueryUserReservationMessageServlet?flag=query_personnelReservation",true);

             xmlhttp.send();
             xmlhttp.onreadystatechange=function() {

                 if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                      var x=xmlhttp.responseText;

                      var array=eval(x);

                      totalPageNum=parseInt(array.length/pagesize);
                      if((array.length%pagesize)>0){
                          totalPageNum+=1;
                      }
                      pageNum=0;
                      var i=0;
                      var j=0;
                      for(var i=0;i<array.length;i++){
                          list[i]=[list1[i]];
                      }
                     for(var i=0;i < array.length; i++){
                           list[i]['num']=i+1;
                      }
                      for(var i=0;i < array.length; i++){
                           list[i]['date']=array[i].date;
                      }
                      for(var i=0;i < array.length; i++){
                           list[i]['start']=array[i].start;
                      }
                      for(var i=0;i < array.length; i++){
                           list[i]['duration']=array[i].duration;
                      }
                      for(var i=0;i < array.length; i++){
                           list[i]['qr_location']=array[i].qr_location;
                      }
                      for(var i=0;i < array.length; i++){
                           list[i]['reservation_id']=array[i].reservation_id;
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
        }
    </script>
</html>