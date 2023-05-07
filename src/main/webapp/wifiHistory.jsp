<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>와이파이 정보 구하기</title>
<style>
#history {
	font-family: Arial, Helvetica, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

#history td, #history th {
	border: 1px solid #ddd;
	padding: 8px;
}

#history tr:nth-child(even) {
	background-color: #f2f2f2;
}

#history tr:hover {
	background-color: #ddd;
}

#history th {
	padding-top: 12px;
	padding-bottom: 12px;
	text-align: center;
	background-color: #04AA6D;
	color: white;
	font-size: 13px;
}

#history td {
	font-size: 12px;
}
</style>
</head>
<body>
<body>
	<h1>위치 히스토리 목록</h1>
	<a href="wifiMain.jsp">홈</a> |
	<a href="wifiHistory.jsp">위치 히스토리 목록</a> |
	<a href="wifiInfo.jsp">Open API 와이파이 정보 가져오기</a> |
	<a href="bookmarkList.jsp">북마크 목록 보기</a> |
	<a href="bookmarkGroup.jsp">북마크 그룹 관리</a>
	<br>
	<br>
	<%
	request.setCharacterEncoding("UTF-8");

	String driver = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://192.168.35.18:3307/mission1";
	String user = "mission1user";
	String password = "0000";

	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, user, password);
	%>
	<table id="history">
		<tr>
			<th>ID</th>
			<th>X좌표</th>
			<th>Y좌표</th>
			<th>조회일자</th>
			<th>비고</th>
		</tr>
		<%
		String sql = "select row_number () over(order by time asc) as id, lat, lnt, time from history order by id desc";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {
			String id = rs.getString("id");
			String lat = rs.getString("lat");
			String lnt = rs.getString("lnt");
			String time = rs.getString("time");
		%>
		<tr>
			<td><%=id%></td>
			<td><%=lat%></td>
			<td><%=lnt%></td>
			<td><%=time%></td>
			<td style="text-align: center;"><input type="button" value="삭제"></td>
		</tr>
		<%
		}
		%>
	</table>
</body>
</html>