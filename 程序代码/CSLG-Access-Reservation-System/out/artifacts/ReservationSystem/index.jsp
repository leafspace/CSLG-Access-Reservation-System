<%--
    Created by IntelliJ IDEA.
    User: Administrator
    Date: 2017/4/14
    Time: 21:00
    To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>常熟理工学院门禁预约系统登陆</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <link href="css/login2.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="door-icons.ico" type="image/x-icon"/>
        <script type="text/javascript" src="js/jquery-1.9.0.min.js"></script>
        <script type="text/javascript" src="images/login.js"></script>
    </head>
    <body>
        <%
            String errorInfo = request.getParameter("errorInfo");
        %>
        <h1>常熟理工学院二维码门禁预约系统<sup>V1.0</sup></h1>
        <div class="login" style="margin-top:50px;">

            <div class="header">
                <div class="switch" id="switch"><a class="switch_btn_focus" id="switch_qlogin" href="javascript:void(0);" tabindex="7">快速登录</a>
                    <a class="switch_btn" id="switch_login" href="javascript:void(0);" tabindex="8">快速注册</a>
                    <div class="switch_bottom" id="switch_bottom" style="position: absolute; width: 64px; left: 0px;"></div>
                </div>
            </div>

            <div>
                <%
                    if(errorInfo != null) {
                %>
                    <p><%=errorInfo%></p>
                <%
                    }
                %>
            </div>
            <div class="web_qr_login" id="web_qr_login" style="display: block; height: 235px;">
                <!--登录-->
                <div class="web_login" id="web_login">
                   <div class="login-box">
                        <div class="login_form">
                            <form action="login.do" name="loginform" accept-charset="utf-8" id="login_form" class="loginForm" method="post">
                                <input type="hidden" name="did" value="0"/>
                                <input type="hidden" name="to" value="log"/>
                                <div class="uinArea" id="uinArea">
                                    <label class="input-tips" for="u">帐号：</label>
                                    <div class="inputOuter" id="uArea">
                                        <input type="text" id="u" name="username" class="inputstyle" />
                                    </div>
                                </div>
                                <div class="pwdArea" id="pwdArea">
                                    <label class="input-tips" for="p">密码：</label>
                                    <div class="inputOuter" id="pArea">
                                        <input type="password" id="p" name="password" class="inputstyle"/>
                                    </div>
                                </div>
                                <div style="padding-left:50px;margin-top:20px;"><input type="submit" value="登 录" style="width:150px;" class="button_blue"/></div>
                          </form>
                       </div>
                    </div>
                </div>
                <!--登录end-->
            </div>

            <!--注册-->
            <div class="qlogin" id="qlogin" style="display: none;">
                <div class="web_login">
                    <form name="form2" id="regUser" accept-charset="utf-8"  action="register.do" method="post">
                        <input type="hidden" name="to" value="reg"/>
                        <input type="hidden" name="did" value="0"/>
                        <ul class="reg_form" id="reg-ul">
                            <div id="userCue" class="cue">快速注册请注意格式</div>
                            <li>
                                <label for="user"  class="input-tips2">用户名：</label>
                                <div class="inputOuter2">
                                    <input type="text" id="user" name="user" maxlength="15" class="inputstyle2"/>
                                </div>
                            </li>

                            <li>
                            <label for="passwd" class="input-tips2">密码：</label>
                                <div class="inputOuter2">
                                    <input type="password" id="passwd"  name="passwd" maxlength="16" class="inputstyle2"/>
                                </div>

                            </li>

                            <li>
                            <label for="passwd2" class="input-tips2">确认密码：</label>
                                <div class="inputOuter2">
                                    <input type="password" id="passwd2" name="" maxlength="16" class="inputstyle2" />
                                </div>

                            </li>

                            <li>
                             <lbel for="qq" class="input-tips2">学/工号</lbel>
                                <div class="inputOuter2">
                                    <input type="text" id="identity_number" name="identity_number" maxlength="9" class="inputstyle2" />
                                </div>

                            </li>

                            <li>
                                <label for="wechat_id" class="input-tips2">微信号</label>
                                <div class="inputOuter2">
                                    <input type="text" id="wechat_id" name="wechat_id" maxlength="16" class="inputstyle2" />
                                </div>

                            </li>

                            <li>
                                <label for="information" class="input-tips2">备注</label>
                                <div class="inputOuter2">
                                    <input type="text" id="information" name="information" maxlength="30" class="inputstyle2" />
                                </div>

                            </li>

                            <li>
                                <div class="inputArea">
                                    <input type="button" id="reg" style="margin-top:10px;margin-left:85px;" class="button_blue" value="同意协议并注册"/>
                                    <a href="#" class="zcxy" >注册协议</a>
                                </div>

                            </li>
                            <div class="cl"></div>
                        </ul>
                    </form>
                </div>
            </div>
            <!--注册end-->
        </div>
    </body>
</html>