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
<title>Insert title here</title>
</head>
<body>
	<%
	String driver = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://192.168.35.18:3307/mission1";
	String user = "mission1user";
	String password = "0000";

	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	String wifi_name = request.getParameter("wifi_name");
	String number = request.getParameter("number");

	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, user, password);

	String sql = "insert into bookmark_list (name, wifi_name) select ?, wifi_name from wifi where number = ?";

	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, name);
	pstmt.setString(2, number);
	pstmt.executeUpdate();
	%>
	<script>
		alert("북마크 정보를 추가하였습니다.");
		location.href = 'bookmarkList.jsp';
	</script>
</body>
</html>