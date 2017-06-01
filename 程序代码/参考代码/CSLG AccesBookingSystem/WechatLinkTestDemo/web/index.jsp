<%--
  Created by IntelliJ IDEA.
  User: 18852
  Date: 2016/12/22
  Time: 15:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>默认标题</title>
  </head>
  <body>
    <%
      String signature = request.getParameter("signature"); //微信加密签名
      String timestamp = request.getParameter("timestamp"); //时间戳
      String nonce = request.getParameter("nonce");         //随机数
      String echostr = request.getParameter("echostr");     //随机字符串-认证成功需原样返回

      System.out.println("微信加密签名：" + signature);
      System.out.println("时间戳：" + timestamp);
      System.out.println("随机数：" + nonce);
      System.out.println("随机字符串：" + echostr);
      System.out.println("-------------------------------------------");

      String hostAddress = request.getHeader("Referer");
      System.out.println("跳转地址集合：" + hostAddress);
      System.out.println("-------------------------------------------");

      response.getWriter().print(echostr);
    %>
    <h3>微信平台接入认证</h3>
    <from action="">
      <span>微信加密签名：<%=signature%></span>
      <br />
      <span>时间戳：<%=timestamp%></span>
      <br />
      <span>随机数：<%=nonce%></span>
      <br />
      <span>随机字符串：<%=echostr%></span>
      <br />
      <span>跳转地址集合：<%=hostAddress%></span>
      <br />
    </from>
  </body>
</html>
