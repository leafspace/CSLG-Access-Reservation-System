<%@page import="cn.cslg.CSLGAccessReservationSystem.ServerBean.Manager"%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>预约情况</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="shortcut icon" href="door-icons.ico" type="image/x-icon"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        .container-fluid{margin: 0;padding: 0;}
        @media screen and (min-width: 768px){
            html,body,.container-fluid{width: 100%;height: 100%;}
        }
        .top_left{background: #5eeeef;height: 100%}
        .top_right{background: #2fa7a6;height: 100%;}
        .top_left h1{line-height: 5.1;text-align: right;padding: 0 15%;margin: 0;}
        .top_left a{padding: 10px 30px;float: right;border-color: #fff;background: transparent;margin-right: 20%;}
        .top_right>p{padding-right: 10%;color: #fff;line-height: 2.3}
        .top_right>p a{color:#fff;margin-left: 10px;}
        .top_right h3{color: #fff;line-height: 2}
        .top_right span{position: relative;top: 2px;}
        .header > div:not(:first-child){padding: 5% 0;margin-top: 1%;}
        @media screen and (max-width: 1200px){
            .san{left: 25%!important;}
        }
        table{color: #fff;border-color: #fff;}
        table td{height: 80px;}
        .page{height: 40px;cursor: pointer}
    </style>
</head>
<% 
       request.setCharacterEncoding("utf-8");
       
       String room_id=(String)request.getParameter("room_id");
       
       String room_name=(String)request.getParameter("room_name");
       
       Manager manager = (Manager) request.getSession().getAttribute("manager");
    %>
<body>
    <input type="hidden" name="room_name" id="room_name" value="<%=room_name%>"/>  <%--隐藏域保存room_name--%>
<div class="container-fluid">
    <div class="col-lg-4 col-md-3  top_left">
        <h1>预约管理</h1>
        <a href="./content3.jsp" class="btn-default btn" style="background: #fff;z-index: 999">返回</a>
    </div>
    <div class="san" style="z-index: 9999;position: absolute;left: 33.3%;top: 5%;width: 0;height: 0;border-top: 25px solid transparent;border-left: 30px solid #5eeeef;border-bottom: 25px solid transparent;"></div>
    <div class="col-lg-8 col-md-9  top_right clearfix">
        <p class="text-right"><span><%=manager.getUsername()%></span>  <a href="/loginOut.do" method="post"> [退出] </a></p>
        <div class="col-xs-12">
            <h3>修改<%=room_name%>预约情况</h3>
            <table class="tab-content col-xs-12 text-center" border="1" id="table">
                <thead>
                    <tr>
                        <td>序号</td>
                        <td>日期</td>
                        <td>预约人</td>
                        <td>开始时间</td>
                        <td>持续时间</td>
                        <td>删除预约</td>
                    </tr>
                </thead>
                <tbody id="JS_info_list">
                    
                </tbody>
            </table>
            <ul class="pagination navbar-right" id="JS_ul">
                <li id="li_prev">
                    <a href="#" id="JS_prev">上一页</a>
                </li>
                   
                <li>
                    <a href="javascript:;" id="JS_next">下一页</a>
                </li>
            </ul>
            
        </div>
    </div>
</div>
</body>
<script src="http://image.meilele.com/js/mll/jq.js?0419"></script>
<script src="./js/common.js"></script>
<script type="text/javascript">
    window.onload = function () {
        var top_left = document.getElementsByClassName('top_left')[0];
        var top_right = document.getElementsByClassName('top_right')[0];
        top_left.style.height = top_right.offsetHeight + 'px';
        init();
    };
    var list = new Array();
     var start;
     var end;
     var totalPageNum;
     var pagesize = 4;
     var pageNum;
     
   
     function deleteReservation(reservation_id){
         
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
                    alert("删除预约成功!");
                    var room_name = document.getElementById('room_name').value;
                    location.href ='./content_5.jsp?room_id='+<%=room_id%>+'&room_name='+room_name;
                   
                }
            }
        }
    }
    
     /*
         * 点击上一页按钮跳转响应事�?         */
        $('#JS_prev').click(function(){
            var h = '';
             if(totalPageNum>=1){
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
                            h+='<td><a href="javascript:deleteReservation('+list[i]['reservation_id']+');" class="btn btn-default">删除</a></td>';
                       h += '</tr>';
                    }
                    pageNum--;
                    start=i;
                    end=i;
                    $('#JS_info_list').html(h);
              }
          }else{
              alert("没有更多数据!");
          }
        })

        /*
         * 点击下一页按钮跳转响应事�?         */
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
                                h+='<td><a href="javascript:deleteReservation('+list[i]['reservation_id']+');" class="btn btn-default">删除</a></td>';
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
        }else if(totalPageNum==1){
             start=0;
             end=list.length;
        }
        var h='';
       for(i=start;i<end;i++){
           h += '<tr>';
               h += '<td>'+ list[i]['num'] +'</td>';
               h += '<td>'+ list[i]['date'] +'</td>';
               h += '<td>'+ list[i]['name'] +'</td>';
               h += '<td>'+ list[i]['starttime'] +'</td>';
               h += '<td>'+ list[i]['endtime'] +'</td>';
               h+='<td><a href="javascript:deleteReservation('+list[i]['reservation_id']+');" class="btn btn-default">删除</a></td>';
           h += '</tr>';
       }
       $('#JS_info_list').html(h);
       pageNum=pagenum;
       start=end;

    }
    
     /*
      *往table中动态添�?tr><td> 如序�?1 2 3  预约日期 2017/3/3 2017/4/5 等等
      */
     function input(){
         var h = '';
         var li='';
         var i;
         for(i=start;i<end;i++){
             h += '<tr>';
                h += '<td>'+ list[i]['num'] +'</td>';
                h += '<td>'+ list[i]['date'] +'</td>';
                h += '<td>'+ list[i]['name'] +'</td>';
                h += '<td>'+ list[i]['starttime'] +'</td>';
                h += '<td>'+ list[i]['endtime'] +'</td>';
                h+='<td><a href="javascript:deleteReservation('+list[i]['reservation_id']+');" class="btn btn-default">删除</a></td>';
             h += '</tr>';
         }
            for(k=1;k<=totalPageNum;k++){
                li+='<li>'
                   li+='<a href="javascript:gotoPageNum('+k+');" id="'+k+'">'+k+'</a>';
                li+='</li>';
            }
         pageNum++;
         start=i;
         $('#JS_info_list').html(h);
         $('#li_prev').after(li); 
     }
        
    function init(){
         var xmlhttp;
     if (window.XMLHttpRequest) {
         xmlhttp=new XMLHttpRequest();
     } else {          
         xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
     }
     
     //发送请求至后端 - 并传递参数数�?     
     xmlhttp.open("GET","QueryActivityRoomReservationMessageServlet?flag=query_activityRoomUsage_manager&room_id="+<%=room_id%>  ,true);
     xmlhttp.send();
     xmlhttp.onreadystatechange=function() {
         if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
             var x=xmlhttp.responseText;
             response=x;
             
             array=eval(response);
             if(array.length==0){
                 var h='';
                 h += '<h3 style="color:red" align="center">'+ "预约为空！"+'</h3>';
                 $('#table').after(h);
             }else{
                 totalPageNum=parseInt(array.length/pagesize);
                 if((array.length%pagesize)>0){
                     totalPageNum+=1;
                 }
                 pageNum=0;
                 var i=0;
                 for(i = 0; i < array.length; i++){
                     list[i]=new Array();
                     list[i]=['reservation_id','num','date','name','starttime','endtime'];
                     list[i]['reservation_id']=array[i].reservation_id;
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
 } 
      
</script>
</html>