<%@page import="java.sql.SQLException"%>
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
p {
	text-align: center;
}
</style>
</head>
<body>
	<%
	String driver = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://192.168.35.18:3307/mission1";
	String user = "mission1user";
	String password = "0000";

	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, user, password);

	String sql = "select count(*) from wifi";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();

	int rowCount = 0;

	if (rs.next()) {
		rowCount = rs.getInt(1);
	}
	%>
	<h1 align="center"><%=rowCount%>개의 WIFI 정보를 정상적으로 저장하였습니다.</h1>
	<p>
		<a href="wifiMain.jsp">홈으로 가기</a>
	</p>
</body>
</html>