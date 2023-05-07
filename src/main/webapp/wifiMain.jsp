<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>와이파이 정보 구하기</title>
<style>
#wifi {
	font-family: Arial, Helvetica, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

#wifi td, #wifi th {
	border: 1px solid #ddd;
	padding: 8px;
}

#wifi tr:nth-child(even) {
	background-color: #f2f2f2;
}

#wifi tr:hover {
	background-color: #ddd;
}

#wifi th {
	padding-top: 12px;
	padding-bottom: 12px;
	text-align: center;
	background-color: #04AA6D;
	color: white;
	font-size: 13px;
}

#wifi td {
	font-size: 12px;
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
	<form id="form1" method="get" onsubmit="saveValues()">
		LAT : <input type="text" name="lat" id="lat" size=10> ,
		LNT : <input type="text" name="lnt" id="lnt" size=10>
		<input type='button' value='내 위치 가져오기' onclick="getLocation()">
		<input type='submit' value='근처 WIFI 정보 보기'>
	</form>
	<br>
	<script>
		function getLocation() {
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(function(position) {
					var lat = document.getElementById("lat");
					var lnt = document.getElementById("lnt");
					lat.value = position.coords.latitude;
					lnt.value = position.coords.longitude;
				}, function(error) {
					console.error(error);
				}, {
					enableHighAccuracy : false,
					maximumAge : 0,
					timeout : Infinity
				});
			}
		}

		function saveValues() {
			localStorage.setItem('lat', document.getElementById('lat').value);
			localStorage.setItem('lnt', document.getElementById('lnt').value);
		}

		function loadValues() {
			var lat = localStorage.getItem('lat');
			var lnt = localStorage.getItem('lnt');
			if (lat && lnt) {
				document.getElementById('lat').value = lat;
				document.getElementById('lnt').value = lnt;
				localStorage.removeItem('lat');
				localStorage.removeItem('lnt');
			} else {
				document.getElementById('lat').value = '0.0';
				document.getElementById('lnt').value = '0.0';
			}
		}

		function submit() {
			saveValues();
			document.getElementById("form1").submit();
		}

		document.addEventListener("DOMContentLoaded", function() {
			var noResult = document.getElementById("null");
			if (document.getElementById("wifi").rows.length < 2) {
				noResult.style.display = "block";
			} else {
				noResult.style.display = "none";
			}
		});

		window.onload = function() {
			loadValues();
		}
	</script>
	<table id="wifi">
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
			<th>실내외구분</th>
			<th>WIFI접속환경</th>
			<th>X좌표</th>
			<th>Y좌표</th>
			<th>작업일자</th>
		</tr>
		<%
		String driver = "org.mariadb.jdbc.Driver";
		String url = "jdbc:mariadb://192.168.35.18:3307/mission1";
		String user = "mission1user";
		String password = "0000";

		String lat = request.getParameter("lat");
		String lnt = request.getParameter("lnt");

		session.setAttribute("lat", lat);
		session.setAttribute("lnt", lnt);

		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, user, password);

		if (request.getParameter("lat") != null && request.getParameter("lnt") != null) {
			String sql = "select *, round((6371 * acos(cos(radians('" + lat + "'))"
			+ " * cos(radians(x)) * cos(radians(y) - radians('" + lnt + "'))" + " + sin( radians('" + lat
			+ "')) * sin( radians(x)))), 4)" + " as distance from wifi order by distance limit 20";

			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				String distance = rs.getString("distance");
				String number = rs.getString("number");
				String gu = rs.getString("gu");
				String wifi_name = rs.getString("wifi_name");
				String address = rs.getString("address");
				String address2 = rs.getString("address2");
				String floor = rs.getString("floor");
				String category = rs.getString("category");
				String office = rs.getString("office");
				String service = rs.getString("service");
				String network = rs.getString("network");
				String year = rs.getString("year");
				String in_out = rs.getString("in_out");
				String environment = rs.getString("environment");
				String x = rs.getString("x");
				String y = rs.getString("y");
				String date = rs.getString("date");
		%>
		<tr>
			<td><%=distance%></td>
			<td><%=number%></td>
			<td><%=gu%></td>
			<td><a href="wifiDetail.jsp?number=<%=number%>"><%=wifi_name%></a></td>
			<td><%=address%></td>
			<td><%=address2%></td>
			<td><%=floor%></td>
			<td><%=category%></td>
			<td><%=office%></td>
			<td><%=service%></td>
			<td><%=network%></td>
			<td><%=year%></td>
			<td><%=in_out%></td>
			<td><%=environment%></td>
			<td><%=x%></td>
			<td><%=y%></td>
			<td><%=date%></td>
		</tr>
		<%
		}

		String sql2 = "insert into history(lat, lnt) values(?,?)";

		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, lat);
		pstmt.setString(2, lnt);
		pstmt.executeUpdate();

		}
		%>
	</table>
	<h5 id="null" align="center">위치 정보를 입력한 후에 조회해 주세요.</h5>
</body>
</html>