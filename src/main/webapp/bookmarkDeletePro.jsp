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

	String id = request.getParameter("id");

	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, user, password);

	String sql = "delete from bookmark_list where id = ?";

	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	pstmt.executeUpdate();
	%>
	<script>
		alert("북마크 정보를 삭제하였습니다.");
		location.href = 'bookmarkList.jsp';
	</script>
</body>
</html>