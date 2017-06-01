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
        <title>常熟理工学院二维码门禁预约系统 - 修改资料</title>
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
		<!-- 外部容器 修改个人信息 -->
		<div class="wrapper">
			<!-- 头部-->
			<header class="index_1">
				<!-- logo -->
				<div class="logo">
					<div id="orderID_1">
                        <img src="images/logo.png" alt="logo" title="常熟理工二维码门禁预约系统">
						<a href="javascript:" id="index_1"><%=user.getUserName()%></a>
					</div>
                    <ul class="pullDown">
                        <li>
                            <a href="index.jsp">首页</a>
                        </li>
                        <li>
                            <a href="">修改资料</a>
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
			<div class="container_1">
				<!-- 内容 左 -->
				<div class="contentLeft">
					<div class="leftBox">
						<div>
							<img src="images/information.png" alt="个人资料" title="个人资料">
							<span>个人信息</span>
						</div>
					</div>
				</div>
				<!-- 内容 右 -->
				<div class="contentRight">
					<div class="rightBox">
						<div class="rightBoxLeft">
							<ul id="userInformation">
								<li>
									<span>微信号</span>
									<label for="name">
										<input id="wechat_id" type="text" placeholder="请输入微信号" />
									</label>
								</li>
								<li>
									<span>手机号</span>
									<label for="phoneNum">
										<input id="phoneNum" style="IME-MODE: disabled;" onkeyup="this.value=this.value.replace(/\D/g,'')"
                                               onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="11" name="phoneNum" type="text" placeholder="请输入手机号" />
									</label>
								</li>
								<li>
									<span>学/工号</span>
									<label for="amount">
										<input id="amount" style="IME-MODE: disabled;" onkeyup="this.value=this.value.replace(/\D/g,'')"
                                               onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="8" name="amount" type="text" placeholder="请输入学/工号" />
									</label>
								</li>
								<li>
									<span>密码</span>
									<label for="password">
										<input id="password" type="password" maxlength="16" placeholder="请输入密码">
									</label>
								</li>
								<li>
									<span >备注</span>
									<textarea id="information"></textarea>
								</li>
							</ul>
						</div>
						<div class="rightBoxRight">
							<div class="portrait">
								头像
								<img src="images/portrait.png" alt="头像" title="头像" >
							</div>
							<a href="javascript:" id="JS_Preservation">点击保存</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>

	<script src="http://image.meilele.com/js/mll/jq.js?0419"></script>
	<script type="text/javascript">
		var orderID_1 = document.getElementById('orderID_1');
		var pullDown = document.getElementsByClassName('pullDown')[0];

		orderID_1.onclick = function() {
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

		$('#JS_Preservation').click(function(){
			var wechat_id = $('#wechat_id').val(),
				phoneNum = $('#phoneNum').val(),
				amount = $('#amount').val(),
				password = $('#password').val();
			if( wechat_id == '' ){
				alert('请填写用户名');
				return false;
			}
			if( phoneNum == '' ){
				alert('请输入手机号');
				return false;
			}else if( !/^1\d{10}$/.test(phoneNum) ){
				alert('手机号格式错误');
				return false;
			}
			if( amount == '' ){
				alert('请填写教/工号');
				return false;
			}
			if( password == '' ){
				alert('请填写密码');
				return false;
			}

			update(wechat_id, phoneNum, amount, password, document.getElementById("information").value);
		})
		var time=3;

		/*
		 * 与servlet交互，提交用户输入数据
		 * servlet根据用户输入的数据，更新数据库信息
		 * 接收servlet返回的boolean 判断是否提交成功
		 * 根据返回的boolean 做出相应的跳转操作
		 */
		function update(wechat_id,phoneNum,amount,password,information){
			var xmlhttp;
			 if (window.XMLHttpRequest) {
				 xmlhttp = new XMLHttpRequest();
			 } else {
				 xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			 }

			 //发送请求至后端 - 并传递参数数据
			 xmlhttp.open("GET","UpdateUserServlet?flag=update&wechat_id="+wechat_id+"&phoneNum="+phoneNum+"&amount="+amount+"&password="+password+"&information="+information,true);
			 xmlhttp.send();
			 xmlhttp.onreadystatechange=function() {
				 if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					 var x=xmlhttp.responseText;
					 if(x=="true"){
						 alert("个人信息修改成功，3秒钟后跳转到首页");
						 setInterval(go, 1000);
					 }else{
						 alert("个人信息修改失败，请重新操作");
						 location.href = 'page1.jsp';
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
				document.getElementById("JS_Preservation").innerHTML = time; //每次设置的x的值都不一样了。
			}else{
				location.href = 'index.jsp';
			}
		}
	</script>
</html>