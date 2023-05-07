package mission1;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class json1 {
	public static void main(String[] args) {
		try {
			String urlStr = "http://openapi.seoul.go.kr:8088";
			urlStr += "/" + URLEncoder.encode("75575553686161613636744e456377", "UTF-8");
			urlStr += "/" + URLEncoder.encode("json", "UTF-8");
			urlStr += "/" + URLEncoder.encode("TbPublicWifiInfo", "UTF-8");
			urlStr += "/" + URLEncoder.encode("23001", "UTF-8");
			urlStr += "/" + URLEncoder.encode("23082", "UTF-8");

			URL url = new URL(urlStr);

			String line = "";
			String result = "";

			BufferedReader br;
			br = new BufferedReader(new InputStreamReader(url.openStream()));
			while ((line = br.readLine()) != null) {
				result = result.concat(line);
			}

			JSONParser parser = new JSONParser();
			JSONObject obj = (JSONObject) parser.parse(result);
			JSONObject obj2 = (JSONObject) obj.get("TbPublicWifiInfo");
			JSONArray array = (JSONArray) obj2.get("row");

			for (int i = 0; i < array.size(); i++) {
				JSONObject wifi = (JSONObject) array.get(i);

				String number = (String) wifi.get("X_SWIFI_MGR_NO");
				String gu = (String) wifi.get("X_SWIFI_WRDOFC");
				String wifi_name = (String) wifi.get("X_SWIFI_MAIN_NM");
				String address = (String) wifi.get("X_SWIFI_ADRES1");
				String address2 = (String) wifi.get("X_SWIFI_ADRES2");
				String floor = (String) wifi.get("X_SWIFI_INSTL_FLOOR");
				String category = (String) wifi.get("X_SWIFI_INSTL_TY");
				String office = (String) wifi.get("X_SWIFI_INSTL_MBY");
				String service = (String) wifi.get("X_SWIFI_SVC_SE");
				String network = (String) wifi.get("X_SWIFI_CMCWR");
				String year = (String) wifi.get("X_SWIFI_CNSTC_YEAR");
				String in_out = (String) wifi.get("X_SWIFI_INOUT_DOOR");
				String environment = (String) wifi.get("X_SWIFI_REMARS3");
				String lat = (String) wifi.get("LAT");
				String lnt = (String) wifi.get("LNT");
				String date = (String) wifi.get("WORK_DTTM");

				String driver = "org.mariadb.jdbc.Driver";
				String DB_IP = "192.168.35.18";
				String DB_PORT = "3307";
				String DB_NAME = "mission1";
				String DB_URL = "jdbc:mariadb://" + DB_IP + ":" + DB_PORT + "/" + DB_NAME;

				Connection conn = null;
				PreparedStatement pstmt = null;

				try {
					Class.forName(driver);
					conn = DriverManager.getConnection(DB_URL, "mission1user", "0000");

					String sql = "insert into wifi values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

					pstmt = conn.prepareStatement(sql);

					pstmt.setString(1, number);
					pstmt.setString(2, gu);
					pstmt.setString(3, wifi_name);
					pstmt.setString(4, address);
					pstmt.setString(5, address2);
					pstmt.setString(6, floor);
					pstmt.setString(7, category);
					pstmt.setString(8, office);
					pstmt.setString(9, service);
					pstmt.setString(10, network);
					pstmt.setString(11, year);
					pstmt.setString(12, in_out);
					pstmt.setString(13, environment);
					pstmt.setString(14, lat);
					pstmt.setString(15, lnt);
					pstmt.setString(16, date);

					int rs = pstmt.executeUpdate();
					conn.close();
					pstmt.close();
					br.close();
					
				} catch (SQLException e) {
					System.out.print(e.getMessage());
				}
			}
		} catch (Exception e) {
			System.out.print(e.getMessage());
		}
	}
}