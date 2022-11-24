<%@ page import="com.example.zerobasestudy.WifiService" %>
<%@ page import="com.example.zerobasestudy.WifiInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <title>와이파이 정보 구하기</title>
    <script>
        function myLocation() {
            navigator.geolocation.getCurrentPosition((position) => {
                document.getElementById('latitude').value = position.coords.latitude
                document.getElementById('longitude').value = position.coords.longitude
            });
        }
    </script>
</head>
<body>
<h1><%= "와이파이 정보 구하기" %>
</h1>
<br/>

<a href="index.jsp">home</a>
<a>|</a>
<a href="history.jsp">위치 히스토리 목록</a>
<a>|</a>
<a href="openAPI.jsp">Open API 와이파이 정보 가져오기</a>
<br><br>
<form action="index.jsp">
    <label for="latitude">LAT: </label><input type="text"
                                              value="<%=Objects.requireNonNullElse(request.getParameter("latitude"),"0.0")%>"
                                              id="latitude" name="latitude">
    ,
    <label for="longitude">LNT: </label><input type="text"
                                               value="<%=Objects.requireNonNullElse(request.getParameter("longitude"),"0.0")%>"
                                               id="longitude" name="longitude">
    <button type="button" onclick="myLocation()">내 위치 가져오기</button>
    <button type="submit">근처 WIFI 정보 보기</button>
</form>
<%
    String lat = request.getParameter("latitude");
    String lnt = request.getParameter("longitude");
%>
<br>
<table width="100%">
    <thead>
    <tr id="tbtitle">
        <th>거리<br>(Km)</th>
        <th>관리번호</th>
        <th>자치구</th>
        <th>와이파이명</th>
        <th>도로명주소</th>
        <th>상세주소</th>
        <th>설치위치(층)</th>
        <th>설치유형</th>
        <th>설치기관</th>
        <th>서비스구분</th>
        <th>망종류</th>
        <th>설치년도</th>
        <th>실내와구분</th>
        <th>WIFI접속환경</th>
        <th>X좌표</th>
        <th>Y좌표</th>
        <th>작업일자</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (lat == null || lnt == null) {
    %>
    <tr>
        <td colspan="17" style="padding: 20px;" font-weight: bold;>
            <center>위치 정보를 입력한 후에 조회해 주세요.</center>
        </td>
    </tr>
    <%
    } else {
        WifiService wifiService = new WifiService();
        List<WifiInfo> wifiInfos = wifiService.getWifiInfos(lat, lnt);
        for (WifiInfo wifiInfo : wifiInfos) {
    %>
    <tr>
        <td><%=Math.round(wifiInfo.distance * 10000) / 10000.0%>
        </td>
        <td><%=wifiInfo.X_SWIFI_MGR_NO%>
        </td>
        <td><%=wifiInfo.X_SWIFI_WRDOFC%>
        </td>
        <td><%=wifiInfo.X_SWIFI_MAIN_NM%>
        </td>
        <td><%=wifiInfo.X_SWIFI_ADRES1%>
        </td>
        <td><%=wifiInfo.X_SWIFI_ADRES2%>
        </td>
        <td><%=wifiInfo.X_SWIFI_INSTL_FLOOR%>
        </td>
        <td><%=wifiInfo.X_SWIFI_INSTL_TY%>
        </td>
        <td><%=wifiInfo.X_SWIFI_INSTL_MBY%>
        </td>
        <td><%=wifiInfo.X_SWIFI_SVC_SE%>
        </td>
        <td><%=wifiInfo.X_SWIFI_CMCWR%>
        </td>
        <td><%=wifiInfo.X_SWIFI_CNSTC_YEAR%>
        </td>
        <td><%=wifiInfo.X_SWIFI_INOUT_DOOR%>
        </td>
        <td><%=wifiInfo.X_SWIFI_REMARS3%>
        </td>
        <td><%=wifiInfo.LAT%>
        </td>
        <td><%=wifiInfo.LNT%>
        </td>
        <td><%=wifiInfo.WORK_DTTM%>
        </td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>
</body>
</html>