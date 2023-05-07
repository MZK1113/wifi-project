<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>와이파이 정보 구하기</title>
<style>
#bookmark {
	font-family: Arial, Helvetica, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

#bookmark td, #bookmark th {
	border: 1px solid #ddd;
	padding: 8px;
}

#bookmark tr:nth-child(even) {
	background-color: #f2f2f2;
}

#bookmark tr:hover {
	background-color: #ddd;
}

#bookmark th {
	padding-top: 12px;
	padding-bottom: 12px;
	text-align: center;
	background-color: #04AA6D;
	color: white;
}
</style>
</head>
<body>
	<h1>북마크 목록</h1>
	<a href="wifiMain.jsp">홈</a> |
	<a href="wifiHistory.jsp">위치 히스토리 목록</a> |
	<a href="wifiInfo.jsp">Open API 와이파이 정보 가져오기</a> |
	<a href="bookmarkList.jsp">북마크 목록 보기</a> |
	<a href="bookmarkGroup.jsp">북마크 그룹 관리</a>
	<br>
	<br>
	<table id="bookmark">
		<tr>
			<th>ID</th>
			<th>북마크 이름</th>
			<th>와이파이명</th>
			<th>등록일자</th>
			<th>비고</th>
		</tr>
		<%
		String driver = "org.mariadb.jdbc.Driver";
		String url = "jdbc:mariadb://192.168.35.18:3307/mission1";
		String user = "mission1user";
		String password = "0000";

		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, user, password);

		String sql = "select * from bookmark_list";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {
			String id = rs.getString("id");
			String name = rs.getString("name");
			String wifi_name = rs.getString("wifi_name");
			String date = rs.getString("date");
		%>
		<tr>
			<td><%=id%></td>
			<td><%=name%></td>
			<td><%=wifi_name%></td>
			<td><%=date%></td>
			<td align="center">
				<a href="bookmarkDelete.jsp?id=<%=rs.getString("id")%>">삭제</a>
			</td>
		</tr>
		<%
		}
		%>
	</table>
</body>
</html>