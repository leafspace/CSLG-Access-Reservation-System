<%@page import="cn.cslg.CSLGAccessReservationSystem.ServerBean.Manager"%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>人员管理</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="shortcut icon" href="door-icons.ico" type="image/x-icon"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        .container-fluid{margin: 0;padding: 0;}
        .top_left{background: #9cd4ad;height: 500px;}
        .top_right{background: #57c176;min-height: 500px;}
        .top_left h1{line-height: 5.1;text-align: right;padding: 0 15%;margin: 0;}
        .top_left a{padding: 10px 30px;float: right;border-color: #000;background: transparent;margin-right: 20%;}
        .top_right>p{padding-right: 10%;color: #fff;line-height: 2.3}
        .top_right>p a{color:#fff;margin-left: 10px;}
        .content_box{margin-top: 10%;color: #fff}
        .box{margin: 5% auto;}
        .header > a{padding: 5% 0;margin-top: 1%;font-size: 36px;text-decoration: none;color: #000}
        
        .scroll{
        list-style:none;
	width: 90%;
	height: 35px;
	margin: 0 auto;
	margin-top: 20px;
	overflow: hidden;
	text-align:left;
	position: relative;
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

       if(manager==null){
           response.sendRedirect("index.jsp");
       }
    %>
<body>
<div class="container-fluid">
    <div class="col-lg-4 col-md-3  top_left ">
        <h1>人员管理</h1>
        <a href="./content1_adduser.jsp" class="btn-default btn">添加</a>
    </div>
    <div class="col-lg-8 col-md-9  top_right clearfix">
        <p class="text-right"><span><%=manager.getUsername()%></span> <a href="/loginOut.do" method="post"> [退出] </a></p>
        <div id="div_userList" class="row col-xs-12">
           
        </div>
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
        <div style="width: 0;height: 0;position: relative;left: 20%;border-left: 25px solid transparent;border-right: 25px solid transparent;border-top: 35px solid #9cd4ad;"></div>
        <div class="col-xs-1"></div>
        <a href="javascript:;" class="col-xs-2 text-center" style="background: #57c176">
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
        <a href="./content2.jsp" class="col-xs-2 text-center" style="background: #e0706f">
            <span>消息管理</span>
        </a>
    </div>
</div>
</body>
<script src="http://image.meilele.com/js/mll/jq.js?0419"></script>
<script src="./js/common.js"></script>
<script type="text/javascript">
    window.onload =function () {
        var top_left = document.getElementsByClassName('top_left')[0];
        var top_right = document.getElementsByClassName('top_right')[0];
        top_left.style.height = top_right.offsetHeight + 'px';
        init();
        
    };
    
    var response;
    var array;
    var p;
    var arr;
    
    var reservationNumber=new Array();
    var start;
    var end;
    var totalPageNum;
    var pagesize=4;
    var pageNum;
    
    

$('#JS_prev').click(function(){
	var h = '';
        if(end<=4){
            alert("此页为首页！");
        }else{
            start=pagesize*(pageNum-2);
            end=pagesize*(pageNum-1);
           $("#div_userList div").remove();
                $("#JS_ul ul").remove();
                dynamicCreate();
            pageNum-=2;
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
                $("#div_userList div").remove();
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
    if(totalPageNum>=1){
        if(pagenum==1){
            start=0;
            end=pagesize*pagenum;
        }else{
            start=pagesize*(pagenum-1);
            end=(pagesize*pagenum)<array.length?pagesize*pagenum:array.length;
        }
    }
    $("#div_userList div").remove();
                $("#JS_ul ul").remove();
                dynamicCreate();
   pageNum=pagenum;
    
}
   
    function dynamicCreate(){
        var h = '';
        var li='';
        var j=0;
        var k;
        if(response=="false"){
            h+='<div align="center">'
                h+='<h1>暂未有任何用户！</h1>';
            h+='</div>'
             $("#div_button").remove();
        }else{
           
            h+='<div class="col-xs-10 box clearfix center-block">';
            for(var i=start;i<end;i++,j++){
                getUserReservationNumber(array[i].user_id);
                if(j==2){
                  h+='<div class="col-xs-10 box clearfix center-block">';
               }
                h+='<a onmousedown="mouseDown('+array[i].user_id+')"'+'class="row col-sm-6 col-xs-12 center-block">';
                    h+='<img class="col-sm-6 col-xs-7" src="./img/content1.png" alt="">';
                  h+='<div class="col-sm-6 col-xs-10 content_box">';
                            h+='<p>'+array[i].username+'</p>';
                            h+='<p>学号'+array[i].identity_number+'</p>';
                            h+='<p>次数'+reservationNumber[i]+'</p>';
                    h+='</div>';
                 h+='</a>';
               if(j==1){
                   h+='</div>';
               }
            }
            h+='</div>';
            
            li+='<ul>'
            for(k=1;k<=totalPageNum;k++){
                li+='<li>'
                   li+='<a href="javascript:gotoPageNum('+k+');" id="'+k+'">'+k+'</a>';
                li+='</li>';
            }
           li+='</ul>'
            pageNum++;
            start=i;
        }    
        $('#div_userList').append(h); 
        $('#li_prev').after(li); 
        
    }
    function mouseDown(user_id){
        location.href='content1_in.jsp?user_id='+user_id;
    }
    
    function init(){
        
        var xmlhttp;
     if (window.XMLHttpRequest) {
         xmlhttp=new XMLHttpRequest();
     } else {          
         xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
     }
     

     xmlhttp.open("GET","QueryAllUsersServlet",true);
     xmlhttp.send();
     xmlhttp.onreadystatechange=function() {
         if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
             var x=xmlhttp.responseText;
             response=x;
             array=eval(response);
              if(array.length==0){
                 var h='';
                 h += '<h3 style="color:red" align="center">'+ "暂未有任何用户！"+'</h3>';
                 $('#div_userList').append(h);
                  $('#div_button').remove();
             }else{
                 totalPageNum=parseInt(array.length/pagesize);
              if((array.length%pagesize)>0){
                  totalPageNum+=1;
              }
              pageNum=0;
              if(array.length<=pagesize){
                    start=0;
                    end=array.length;
                }else{
                    start=0;
                    end=pagesize;
                } 
                p=start;
                dynamicCreate(); 
             }
             
         } 
      }   
    }
    
    var getUserReservationNumber=function(user_id){
         var xmlhttp;
         if (window.XMLHttpRequest) {
             xmlhttp=new XMLHttpRequest();
         } else {
             xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
         }

         xmlhttp.open("GET","QueryUserReservationMessageServlet?flag=query_userReservationNumber&user_id="+user_id,false);

         xmlhttp.send();
         if (xmlhttp.readyState == 4 ) {
             var x=xmlhttp.responseText;
             arr=eval(x);
             reservationNumber[p++]=arr.length;
         }
    }
    
</script>
</html>