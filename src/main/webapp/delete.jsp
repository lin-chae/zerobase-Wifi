<%@ page import="com.example.zerobasestudy.WifiService" %><%--
  Created by IntelliJ IDEA.
  User: flsrh
  Date: 2022-11-22
  Time: 오후 11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
</head>
<body>
<% Integer delId = Integer.valueOf(request.getParameter("id"));
    WifiService wifiService = new WifiService();
    wifiService.deleteHistory(delId);%>
</body>
</html>
