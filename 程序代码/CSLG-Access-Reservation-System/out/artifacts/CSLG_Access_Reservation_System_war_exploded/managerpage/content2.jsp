<%@page import="cn.cslg.CSLGAccessReservationSystem.ServerBean.Manager"%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>消息管理</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="shortcut icon" href="door-icons.ico" type="image/x-icon"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        .container-fluid{margin: 0;padding: 0;}
        .top_left{background: #ebadae;height: 500px;}
        .top_right{background: #e0706f;min-height: 500px;}
        .top_left h1{line-height: 5.1;text-align: right;padding: 0 15%;margin: 0;}
        .top_left button{padding: 10px 30px;float: right;border-color: #000;background: transparent;margin-right: 20%;}
        .top_right>p{padding-right: 10%;color: #fff;line-height: 2.3}
        .top_right>p a{color:#fff;margin-left: 10px;}
        .top_right >h3 span{border: 1px solid #333;padding:.5% 5%;}
        .top_right >h3 a{text-decoration: none;position: relative;padding:5px 15px;border: 1px solid #333; margin-left: 10px;}
        .yes{background: url("./img/zhengque.png") no-repeat;background-size: 90% 90%;}
        .no{background: url("./img/quxiao.png") no-repeat 2px 1px;background-size: 90% 90%;}
        @media screen and (max-width: 768px){
            .top_right >h3 span{font-size: 16px;}
        }
        @media screen and (max-width: 480px){
            .top_right >h3 span{font-size: 12px;}
            .top_right >h3 a{display: inline-block;margin-top: 20px;}
        }
        .header > a{padding: 5% 0;margin-top: 1%;font-size: 36px;text-decoration: none;color: #000}
    </style>
</head>
<% 
       request.setCharacterEncoding("utf-8");
       
       Manager manager = (Manager) request.getSession().getAttribute("manager");
    %>
<body>
<div class="container-fluid">
    <div class="col-lg-4 col-md-3  top_left ">
        <h1>消息管理</h1>
        
    </div>
    <div  id="div" class="col-lg-8 col-md-9  top_right clearfix">
        <p  id="p_admin" class="text-right"><span><%=manager.getUsername()%></span>  <a href="/loginOut.do" method="post"> [退出] </a></p>
     
        
        <ul class="pagination navbar-right"id="JS_ul">
                <li id="li_prev">
                    <a href="#" id="JS_prev">上一页</a>
                </li>
                   
                <li>
                    <a href="javascript:;" id="JS_next">下一页</a>
                </li>
            </ul>
    </div>

    <div class="col-xs-12 header">
        <div style="width: 0;height: 0;position: relative;left: 95%;border-left: 25px solid transparent;border-right: 25px solid transparent;border-top: 35px solid #e0706f;"></div>
        <div class="col-xs-1"></div>
        <a href="./content1.jsp" class="col-xs-2 text-center" style="background: #57c176">
            <span>人员管理</span>
        </a>
        <div class="col-xs-1"></div>
        <a href="./content3.jsp" class="col-xs-2 text-center" style="background: #91b3bf">
            <span>预约管理</span>
        </a>
        <div class="col-xs-1"></div>
        <a href="./content_6.jsp" class="col-xs-2 text-center" style="background: #a27150">
            <span>设备管理</span>
        </a>
        <div class="col-xs-1"></div>
        <a href="javascript:;" class="col-xs-2 text-center" style="background: #e0706f">
            <span>消息管理</span>
        </a>
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
     var pagesize = 6;
     var pageNum;
     
   
     function manageMessage(reservation_id,isValid){
         alert(isValid);
       var xmlhttp;
       if (window.XMLHttpRequest) {
           xmlhttp=new XMLHttpRequest();
       } else {          
           xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
       }

        //发送请求至后端 - 并传递参数数�?        
        xmlhttp.open("GET","ManageMessageServlet?reservation_id="+reservation_id+"&isValid="+isValid,true);
        xmlhttp.send();
        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var x=xmlhttp.responseText;
                response=x;
                if(response=="false"){
                    alert("该预约失败!");
                }else{
                    alert("该预约成功!");
                }
                location.href ='./content2.jsp';
            }
        }
    }
    
     /*
         * 点击上一页按钮跳转响应事�?         */
        $('#JS_prev').click(function(){
            var h = '';
             if(totalPageNum>=1){
                if(end<=pagesize){
                    alert("此页为首页！");
                }else{
                   for(var i=pagesize*(pageNum-2),ii=pagesize*(pageNum-1);i<ii;i++){
                       str=list[i]['num']+'. '+list[i]['name']+' 请求 '+list[i]['date']+' '+list[i]['room_name']+' '+list[i]['starttime']+'-'+list[i]['endtime'];
                       h += '<h3 class="col-xs-12">';
                       h+='<span>'+str+'</span>';
                       h+='<a class="yes" href="javascript:manageMessage('+list[i]['reservation_id']+',1'+');">&nbsp;</a>';
                       h+='<a class="no" href="javascript:manageMessage('+list[i]['reservation_id']+',0'+');">&nbsp;</a>';
                       h+='</h3>';
                    }
                    pageNum--;
                    start=i;
                    end=i;
                    $('#div h3').remove();
                    $('#p_admin').after(h);
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
                            str=list[i]['num']+'. '+list[i]['name']+' 请求 '+list[i]['date']+' '+list[i]['room_name']+' '+list[i]['starttime']+'-'+list[i]['endtime'];
                            h += '<h3 class="col-xs-12">';
                            h+='<span>'+str+'</span>';
                             h+='<a class="yes" href="javascript:manageMessage('+list[i]['reservation_id']+',1'+');">&nbsp;</a>';
                             h+='<a class="no" href="javascript:manageMessage('+list[i]['reservation_id']+',0'+');">&nbsp;</a>';
                            h+='</h3>';
                        }
                        $('#div h3').remove();
                         $('#p_admin').after(h);
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
            str=list[i]['num']+'. '+list[i]['name']+' 请求 '+list[i]['date']+' '+list[i]['room_name']+' '+list[i]['starttime']+'-'+list[i]['endtime'];
            h += '<h3 class="col-xs-12">';
            h+='<span>'+str+'</span>';
            h+='<a class="yes" href="javascript:manageMessage('+list[i]['reservation_id']+',1'+');">&nbsp;</a>';
            h+='<a class="no" href="javascript:manageMessage('+list[i]['reservation_id']+',0'+');">&nbsp;</a>';
            h+='</h3>';
        }
        $('#div h3').remove();
        $('#p_admin').after(h);
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
         var str;
         for(i=start;i<end;i++){
             str=list[i]['num']+'. '+list[i]['name']+' 请求 '+list[i]['date']+' '+list[i]['room_name']+' '+list[i]['starttime']+'-'+list[i]['endtime'];
             h += '<h3 class="col-xs-12">';
             h+='<span>'+str+'</span>';
             h+='<a class="yes" href="javascript:manageMessage('+list[i]['reservation_id']+',1'+');">&nbsp;</a>';
              h+='<a class="no" href="javascript:manageMessage('+list[i]['reservation_id']+',0'+');">&nbsp;</a>';
             h+='</h3>';
         }
         for(k=1;k<=totalPageNum;k++){
             li+='<li>'
             li+='<a href="javascript:gotoPageNum('+k+');" id="'+k+'">'+k+'</a>';
             li+='</li>';
         }
         
         pageNum++;
         start=i;
         $('#p_admin').after(h);
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
     xmlhttp.open("GET","QueryMessagesServlet",true);
     xmlhttp.send();
     xmlhttp.onreadystatechange=function() {
         if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
             var x=xmlhttp.responseText;
             response=x;
             
             array=eval(response);

             if(array.length==0){
                 var h='';
                 h += '<h3 style="color:red" align="center">'+ "预约消息为空！"+'</h3>';
                 $('#p_admin').after(h);
                  $('#JS_ul').remove();
             }else{
                 totalPageNum=parseInt(array.length/pagesize);
                 if((array.length%pagesize)>0){
                     totalPageNum+=1;
                 }
                 pageNum=0;
                 var i=0;
                 for(i = 0; i < array.length; i++){
                     list[i]=new Array();
                     list[i]=['reservation_id','num','date','name','room_name','starttime','endtime'];
                     list[i]['reservation_id']=array[i].reservation_id;
                     list[i]['num']=i+1;
                     list[i]['date']=array[i].date;
                     list[i]['name']=array[i].username;
                     list[i]['room_name']=array[i].room_name;
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