<%@ page import="com.example.zerobasestudy.WifiService" %><%--
  Created by IntelliJ IDEA.
  User: flsrh
  Date: 2022-11-21
  Time: 오후 10:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="style.css" rel="stylesheet" type="text/css"/>
    <title>와이파이 정보 구하기</title>
</head>
<body>
<p><%
    WifiService wifiService = new WifiService();
    int count = wifiService.saveWifiData();
%></p>
<h1><center><%= count %>개의 WIFI 정보를 정상적으로 저장하였습니다.</center></h1>
<a href="index.jsp"><center>홈 으로 가기</center></a>
</body>
</html>
