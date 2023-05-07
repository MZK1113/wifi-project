<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
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
	request.setCharacterEncoding("UTF-8");

	String driver = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://192.168.35.18:3307/mission1";
	String user = "mission1user";
	String password = "0000";

	String ordernum = request.getParameter("ordernum");

	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, user, password);

	String sql = "delete from bookmark_group where ordernum = ?";

	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, ordernum);
	pstmt.executeUpdate();
	%>
	<script>
		alert("북마크 그룹 정보를 삭제하였습니다.");
		location.href = 'bookmarkGroup.jsp';
	</script>
</body>
</html>