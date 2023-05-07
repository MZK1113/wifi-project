<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
	<h1>북마크 삭제</h1>
	<a href="wifiMain.jsp">홈</a> |
	<a href="wifiHistory.jsp">위치 히스토리 목록</a> |
	<a href="wifiInfo.jsp">Open API 와이파이 정보 가져오기</a> |
	<a href="bookmarkList.jsp">북마크 목록 보기</a> |
	<a href="bookmarkGroup.jsp">북마크 그룹 관리</a>
	<br>
	<h4>북마크를 삭제하시겠습니까?</h4>
</head>
<body>
	<form action="bookmarkDeletePro.jsp" method="post">
		<%
		request.setCharacterEncoding("UTF-8");

		String driver = "org.mariadb.jdbc.Driver";
		String url = "jdbc:mariadb://192.168.35.18:3307/mission1";
		String user = "mission1user";
		String password = "0000";

		String id = request.getParameter("id");

		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, user, password);

		String sql = "select * from bookmark_list where id = ?";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {
			String name = rs.getString("name");
			String wifi_name = rs.getString("wifi_name");
			String date = rs.getString("date");
		%>
		<table id="bookmark">
			<tr>
				<th>북마크 이름</th>
				<td><%=name%></td>
			</tr>
			<tr>
				<th>와이파이명</th>
				<td><%=wifi_name%></td>
			</tr>
			<tr>
				<th>등록일자</th>
				<td><%=date%></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<a href="bookmarkList.jsp">돌아가기</a> |
					<input type="hidden" name="id" value="<%=id%>">
					<button>삭제</button>
				</td>
			</tr>
			<%
			}
			%>
		</table>
	</form>
</body>
</html>