<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>와이파이 정보 구하기</title>
<style>
#detail {
	font-family: Arial, Helvetica, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

#detail td, #detail th {
	border: 1px solid #ddd;
	padding: 8px;
}

#detail tr:nth-child(even) {
	background-color: #f2f2f2;
}

#detail tr:hover {
	background-color: #ddd;
}

#detail th {
	padding-top: 12px;
	padding-bottom: 12px;
	text-align: center;
	background-color: #04AA6D;
	color: white;
}
</style>
</head>
<body>
	<h1>와이파이 정보 구하기</h1>
	<a href="wifiMain.jsp">홈</a> |
	<a href="wifiHistory.jsp">위치 히스토리 목록</a> |
	<a href="wifiInfo.jsp">Open API 와이파이 정보 가져오기</a> |
	<a href="bookmarkList.jsp">북마크 목록 보기</a> |
	<a href="bookmarkGroup.jsp">북마크 그룹 관리</a>
	<br>
	<br>
	<%
	String driver = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://192.168.35.18:3307/mission1";
	String user = "mission1user";
	String password = "0000";

	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, user, password);

	String number = request.getParameter("number");
	String wifi_name = request.getParameter("wifi_name");
	String lat = (String) session.getAttribute("lat");
	String lnt = (String) session.getAttribute("lnt");

	String sql = "select name from bookmark_group";

	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();

	ArrayList<String> selectBox = new ArrayList<String>();

	while (rs.next()) {
		String name = rs.getString("name");
		selectBox.add(name);
	}
	%>
	<form action="bookmarkAdd.jsp" method="post">
		<select name="name">
			<option value="">북마크 그룹 이름 선택</option>
			<%
			for (String name : selectBox) {
			%>
			<option value="<%=name%>"><%=name%></option>
			<%
			}
			%>
		</select>
		<input type="hidden" name="wifi_name" value="<%=wifi_name%>">
		<input type="hidden" name="number" value="<%=number%>">
		<button type="submit">북마크 추가하기</button>
	</form>
	<br>
	<table id="detail">
		<%
		sql = "select *, " + "round((6371 * acos(cos(radians('" + lat + "')) "
				+ "* cos(radians(x)) * cos(radians(y) - radians('" + lnt + "')) " + "+ sin(radians('" + lat
				+ "')) * sin(radians(x)))), 4) as distance " + "from wifi where number = '" + number + "' "
				+ "order by distance limit 20;";

		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();

		while (rs.next()) {
		%>
		<tr>
			<th>거리(Km)</th>
			<td><%=rs.getString("distance")%></td>
		</tr>
		<tr>
			<th>관리번호</th>
			<td><%=rs.getString("number")%></td>
		</tr>
		<tr>
			<th>자치구</th>
			<td><%=rs.getString("gu")%></td>
		</tr>
		<tr>
			<th>와이파이명</th>
			<td><%=rs.getString("wifi_name")%></td>
		</tr>
		<tr>
			<th>도로명주소</th>
			<td><%=rs.getString("address")%></td>
		</tr>
		<tr>
			<th>상세주소</th>
			<td><%=rs.getString("address2")%></td>
		</tr>
		<tr>
			<th>설치위치(층)</th>
			<td><%=rs.getString("floor")%></td>
		</tr>
		<tr>
			<th>설치유형</th>
			<td><%=rs.getString("category")%></td>
		</tr>
		<tr>
			<th>설치기관</th>
			<td><%=rs.getString("office")%></td>
		</tr>
		<tr>
			<th>서비스구분</th>
			<td><%=rs.getString("service")%></td>
		</tr>
		<tr>
			<th>망종류</th>
			<td><%=rs.getString("network")%></td>
		</tr>
		<tr>
			<th>설치년도</th>
			<td><%=rs.getString("year")%></td>
		</tr>
		<tr>
			<th>실내외구분</th>
			<td><%=rs.getString("in_out")%></td>
		</tr>
		<tr>
			<th>WIFI접속환경</th>
			<td><%=rs.getString("environment")%></td>
		</tr>
		<tr>
			<th>X좌표</th>
			<td><%=rs.getString("x")%></td>
		</tr>
		<tr>
			<th>Y좌표</th>
			<td><%=rs.getString("y")%></td>
		</tr>
		<tr>
			<th>작업일자</th>
			<td><%=rs.getString("date")%></td>
		</tr>
		<%
		}
		%>
	</table>
</body>
</html>