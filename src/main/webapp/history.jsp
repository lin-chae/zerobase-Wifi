<%@ page import="com.example.zerobasestudy.WifiService" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.example.zerobasestudy.History" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: flsrh
  Date: 2022-11-22
  Time: 오후 10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="style.css" rel="stylesheet" type="text/css"/>
    <title>와이파이 정보 구하기</title>
</head>
<body>
<h1>위치 히스토리 목록</h1>
<a href="index.jsp">home</a>
<a>|</a>
<a href="history.jsp">위치 히스토리 목록</a>
<a>|</a>
<a href="openAPI.jsp">Open API 와이파이 정보 가져오기</a>
<br><br>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>X좌표</th>
        <th>Y좌표</th>
        <th>조회일자</th>
        <th>비고</th>
    </tr>
    </thead>
    <tbody>
    <%
        WifiService wifiService = new WifiService();
        if (request.getParameter("id") != null) {
            Integer delId = Integer.valueOf(request.getParameter("id"));
            wifiService.deleteHistory(delId);
        }
        List<History> historys = wifiService.getHistorys();
        for (History history : historys) {
    %>
    <tr>
        <td><%=history.ID%>
        </td>
        <td><%=history.My_LAT%>
        </td>
        <td><%=history.My_LNT%>
        </td>
        <td><%=history.My_Work_Date%>
        </td>
        <td>
            <center><button type="button" onclick="location.href='history.jsp?id=<%=history.ID%>'">삭제</button></center>
        </td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
</body>
</html>
