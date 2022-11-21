<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>와이파이 정보 구하기</title>
</head>
<body>
<h1><%= "와이파이 정보 구하기" %>
</h1>
<br/>

<a href="index.jsp">home</a>
<a>|</a>
<a href="">위치 히스토리 목록</a>
<a>|</a>
<a href="">Open API 와이파이 정보 가져오기</a>
<br><br>
<label for="latitude">LAT: </label><input id="latitude">
<label for="longitude">LNT: </label><input id="longitude">
<input type="button" value="근처 WIFI 정보 보기">
<br>
<table border="1">
    <thead>
    <tr>
        <th>거리(Km)</th>
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
    <tr>
        <td colspan="17">위치 정보를 입력한 후에 조회해 주세요.</td>
    </tr>
    </tbody>
</table>
</body>
</html>