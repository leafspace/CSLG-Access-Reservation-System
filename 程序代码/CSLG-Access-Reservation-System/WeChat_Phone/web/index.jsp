<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<!DOCTYPE html>
<html>	
    <head>
        <title>常熟理工学院二维码预约系统</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script type="application/x-javascript">
            addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
            function hideURLbar(){ window.scrollTo(0,1); }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href="css/style.css" rel='stylesheet' type='text/css' />
    </head>
    <body>
        <script>
            $(document).ready(function(c) {
            $('.close').on('click', function(c){
            $('.login-form').fadeOut('slow', function(c){
            $('.login-form').remove();
            });
            });
            });
        </script>
        <div class="login-form">
            <div class="close"> </div>
            <div class="head-info">
                <label class="lbl-1"> </label>
                <label class="lbl-2"> </label>
                <label class="lbl-3"> </label>
            </div>
            <div class="clear"> </div>
            <div class="avtar">
                <img src="images/avtar.png" />
            </div>
            <form action="login.do" method="post">
                <input type="text"  class="text" name="username" placeholder="用户名" required="" />
                <div class="key">
                    <input type="password"  name="password" placeholder="密码" required="" />
                </div>
                <div class="signin">
                    <input type="submit" value="登陆" >
                </div>
            </form>
        </div>
        <div class="copy-rights">
            <p>&copy; 2017. CSLG Reservation System . All Rights Reserved  | Sign by <a href="http://www.cslg.edu.cn/" target="_blank">CSLG</a> </p>
        </div>
    </body>
</html>