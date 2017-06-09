<%@page import="cn.cslg.CSLGAccessReservationSystem.ServerBean.Manager"%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>预约管理</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="shortcut icon" href="door-icons.ico" type="image/x-icon"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        .container-fluid{margin: 0;padding: 0;}
        .top_left{background: #c3d6dd;height: 500px;}
        .top_right{background: #91b3bf;min-height: 500px;}
        .top_left h1{line-height: 5.1;text-align: right;padding: 0 15%;margin: 0;}
        .top_left a{padding: 10px 30px;float: right;border-color: #000;background: transparent;margin-right: 20%;}
        .top_right>p{padding-right: 10%;color: #fff;line-height: 2.3}
        .top_right>p a{color:#fff;margin-left: 10px;}
        .top_right >div{margin-top: 2%;}
        .top_right >div a{text-decoration: none;color: #000;border: 1px solid #333;margin-left: 3%;padding: 6% 0;text-align: center;box-shadow: 2px 2px 2px rgba(0,0,0,0.5)}
        .header > a{padding: 5% 0;margin-top: 1%;font-size: 36px;text-decoration: none;color: #000}
        .scroll{
        list-style:none;
	width: 90%;
	height: 35px;
	margin: 0 auto;
	margin-top: 0px;
	overflow: hidden;
	text-align:left;
        margin-bottom:5px;
        position:absolute; 
        bottom:10px; 
        }
        .scroll > ul{
                width: 50%;
                height: 35px;
                position:absolute;
                right: 0;
                overflow: hidden;
                list-style:none;
        }
        .scroll > ul li{
                float: left;
                height: 100%;
                width: 20px;
                text-align: center;
                margin-right: 5px;
                list-style:none;
        }
        .scroll > ul li a{
                color: #2A2A2A;
                background: #fff;
                display: block;
                font-size: 20px;
        }
        .scroll > ul li.up{
                width: 30%;
        }
        .scroll > ul li.down{
                width: 30%;
        }
    </style>
</head>
<% 
       request.setCharacterEncoding("utf-8");
       
       Manager manager = (Manager) request.getSession().getAttribute("manager");
    %>
<body>
<div class="container-fluid">
    <div class="col-lg-4 col-md-3  top_left ">
        <h1>预约管理</h1>
        <a href="./content3_addReservationMessage.jsp" class="btn-default btn">添加</a>
    </div>
    <div class="col-lg-8 col-md-9  top_right clearfix">
        <p id="p_admin" class="text-right"><span><%=manager.getUsername()%></span>  <a href="/loginOut.do" method="post"> [退出] </a></p>
        
        <div id="div_button" class="scroll">
				<ul id="JS_ul">
					<li class="up"id="li_prev">
						<a href="javascript:;" id="JS_prev">上一页</a>
					</li>
					<!-- <li>
						<a href="javascript:;"></a>
					</li>
					<li>
						<a href="javascript:;"></a>
					</li>
					<li>
						<a href="javascript:;"></a>
					</li> -->
					<li class="down">
						<a href="javascript:;" id="JS_next">下一页</a>
					</li>
				</ul>
        </div>
    </div>
    <div class="col-xs-12 header">
        <div style="width: 0;height: 0;position: relative;left: 45%;border-left: 25px solid transparent;border-right: 25px solid transparent;border-top: 35px solid #91b3bf;"></div>
        <div class="col-xs-1"></div>
        <a href="./content1.jsp" class="col-xs-2 text-center" style="background: #57c176">
            <span>人员管理</span>
        </a>
        <div class="col-xs-1"></div>
        <a href="javascript:;" class="col-xs-2 text-center" style="background: #91b3bf">
            <span>预约管理</span>
        </a>
        <div class="col-xs-1"></div>
        <a href="./content_6.jsp" class="col-xs-2 text-center" style="background: #a27150">
            <span>设备管理</span>
        </a>
        <div class="col-xs-1"></div>
        <a href="./content2.jsp" class="col-xs-2 text-center" style="background: #e0706f">
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
    
     var array;
     var arr;
     var arrNum;
    var start;
    var end;
    var totalPageNum;
    var pagesize=15;
    var pageNum;
    
    
      

$('#JS_prev').click(function(){
	var h = '';
        if(totalPageNum>=1){
            if(end<=4){
                alert("此页为首页！");
            }else{
                start=pagesize*(pageNum-2);
                end=pagesize*(pageNum-1);
               $("#div_roomList div").remove();
                    $("#JS_ul ul").remove();
                    dynamicCreate();
                pageNum-=2;
          }
      }else{
          alert("没有更多数据！");
      }
       
	
})


$('#JS_next').click(function(){
    
	var h = '';
        var i;
        var ii;
        if(totalPageNum>1){
            if(pageNum!=totalPageNum){
                pageNum++;
                ii=(pagesize*pageNum)<array.length?pagesize*pageNum:array.length;
                end=ii;
                pageNum--;
                $("#div_roomList div").remove();
                $("#JS_ul ul").remove();
                dynamicCreate();
                
                start=ii;
            }else{
                alert("此页为尾页！");
            }
        }else{
            alert("没有更多数据！");
        }
})


function gotoPageNum(pagenum){
      if(totalPageNum>1){
        if(pagenum==1){
            start=0;
            end=pagesize*pagenum;
        }else{
            start=pagesize*(pagenum-1);
            end=(pagesize*pagenum)<arr.length?pagesize*pagenum:arr.length;
        }
    }else if(totalPageNum==1){
         start=0;
         end=arr.length;
    }
    $("#div_activityRoom").remove();
    $("#JS_ul ul").remove();
    dynamicCreate();
   pageNum=pagenum;
    
}
    
  
    function dynamicCreate(){
        
        var h = '';
        var li='';
        var j=0;
        var k;
        
        h+='<div id="div_activityRoom"class="row col-xs-12">';
        for(var i=start;i<end;i++,j++){
            h+='<a href="./content_5.jsp?room_id='+array[arrNum[i]].room_id+'&room_name='+arr[i]+'"class="col-xs-2">'+arr[i]+'</a>';
        }
        h+='</div>';
            
        li+='<ul>';
        for(k=1;k<=totalPageNum;k++){
            li+='<li>'
                li+='<a href="javascript:gotoPageNum('+k+');" id="'+k+'">'+k+'</a>';
            li+='</li>';
        }
        li+='</ul>'
        
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
     
 
     xmlhttp.open("GET","QueryActivityRoomReservationMessageServlet?flag=query_activityRoomReservation_manager",true);
     xmlhttp.send();
     xmlhttp.onreadystatechange=function() {
         if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
             var x=xmlhttp.responseText;
             response=x;
             array=eval(response);
             if(array.length!=0){
                arr=new Array();
                arrNum=new Array();
                var flag;
                var p=1;
                arr[0]=array[0].room_name; 
                arrNum[0]=0;
                for(var i=0;i<array.length;i++){
                    flag=false;
                    for(var j=0;j<i;j++){
                        if(arr[j]!=array[i].room_name){
                            flag=true;
                        }else{
                            flag=false;
                            break;
                        } 
                    }
                    if(flag==true){
                        arr[p]=array[i].room_name;
                        arrNum[p]=i;
                        p++;
                    }
                }
                totalPageNum=parseInt(arr.length/pagesize);
                 if((arr.length%pagesize)>0){
                     totalPageNum+=1;
                 }
                 pageNum=0;
                 if(arr.length<=pagesize){
                       start=0;
                       end=arr.length;
                   }else{
                       start=0;
                       end=pagesize;
                   } 
                   p=start; 
                   dynamicCreate(); 
            }else{
                var h='';
                h+='<div align="center">'
                h+='<h2 style="color:red">预约为空！</h2>';
                h+='</div>'
                $("#div_button").remove();
                $('#p_admin').after(h); 
            } 
        }
      }   
    }
</script>
</html>