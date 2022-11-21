import com.example.zerobasestudy.ApiData;
import com.google.gson.Gson;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class WifiService {
    private static final String SQLITE_JDBC_DRIVER = "org.sqlite.JDBC";
    private static final String SQLITE_DB_URL = "jdbc:sqlite:";

    //  - Database 옵션 변수
    private static final boolean OPT_AUTO_COMMIT = false;
    final String insertSql = "INSERT INTO Wifi_Info (" + "\n" + "LNT, LAT, WORK_DTTM, ADRES1, ADRES2, CMCWR, CNSTC_YEAR,INOUT_DOOR, INSTL_FLOOR, INSTL_MBY, INSTL_TY, MAIN_NM, MGR_NO, REMARS3, SVC_SE, WRDOFC" + ") VALUES (                           " + "\n" + "    ?,                               " + "\n" + "    ?,                               " + "\n" + "    ?,                               " + "\n" + "    ?,                               " + "\n" + "    ?,                               " + "\n" + "    ?,                               " + "\n" + "    ?,?,?,?,?,?,?,?,?,?              " + "\n" + ");";
    // 변수 설정
    //   - Database 접속 정보 변수
    private Connection conn = null;
    private String driver = null;
    private String url = null;

    // 생성자
    public WifiService() {
        // JDBC Driver 설정
        this.driver = SQLITE_JDBC_DRIVER;
        this.url = SQLITE_DB_URL + "파일위치\\wifi.db";
    }

    // DB 연결 함수
    public Connection createConnection() throws SQLException {
        try {
            // JDBC Driver Class 로드
            Class.forName(this.driver);

            // DB 연결 객체 생성
            this.conn = DriverManager.getConnection(this.url);

            // 로그 출력
            System.out.println("CONNECTED");

            // 옵션 설정
            //   - 자동 커밋
            this.conn.setAutoCommit(OPT_AUTO_COMMIT);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return this.conn;
    }

    public void closeConnection() {
        try {
            if (this.conn != null) {
                this.conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.conn = null;

            // 로그 출력
            System.out.println("CLOSED");
        }
    }

    public void saveWifiData() throws IOException, SQLException {
        int start = 1;
        Connection connection = createConnection();
        connection.createStatement().execute("delete from Wifi_Info");
        while (true) {
            StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088/API KEY/json/TbPublicWifiInfo/");
            urlBuilder.append(start).append("/").append(start + 999);
            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/xml");
            System.out.println("Response code: " + conn.getResponseCode()); /* 연결 자체에 대한 확인이 필요하므로 추가합니다.*/
            BufferedReader rd;

            // 서비스코드가 정상이면 200~300사이의 숫자가 나옵니다.
            if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }
            rd.close();
            conn.disconnect();
            ApiData wifiInfo = new Gson().fromJson(sb.toString(), ApiData.class);
            start += 1000;
            if (wifiInfo.TbPublicWifiInfo == null) {
                break;
            }
            System.out.println(wifiInfo.TbPublicWifiInfo.row.size());

            PreparedStatement pstmt = null;

            try {
                // PreparedStatement 생성
                pstmt = connection.prepareStatement(insertSql);

                // 입력 데이터 매핑
                for (ApiData.WifiInfo data : wifiInfo.TbPublicWifiInfo.row) {
                    pstmt.setObject(1, data.LAT);
                    pstmt.setObject(2, data.LNT);
                    pstmt.setObject(3, data.WORK_DTTM);
                    pstmt.setObject(4, data.X_SWIFI_ADRES1);
                    pstmt.setObject(5, data.X_SWIFI_ADRES2);
                    pstmt.setObject(6, data.X_SWIFI_CMCWR);
                    pstmt.setObject(7, data.X_SWIFI_CNSTC_YEAR);
                    pstmt.setObject(8, data.X_SWIFI_INOUT_DOOR);
                    pstmt.setObject(9, data.X_SWIFI_INSTL_FLOOR);
                    pstmt.setObject(10, data.X_SWIFI_INSTL_MBY);
                    pstmt.setObject(11, data.X_SWIFI_INSTL_TY);
                    pstmt.setObject(12, data.X_SWIFI_MAIN_NM);
                    pstmt.setObject(13, data.X_SWIFI_MGR_NO);
                    pstmt.setObject(14, data.X_SWIFI_REMARS3);
                    pstmt.setObject(15, data.X_SWIFI_SVC_SE);
                    pstmt.setObject(16, data.X_SWIFI_WRDOFC);
                    // 쿼리 실행
                    pstmt.executeUpdate();
                }
                // 트랜잭션 COMMIT
                connection.commit();

            } catch (SQLException e) {
                // 오류출력
                System.out.println(e.getMessage());

                // 트랜잭션 ROLLBACK
                if (connection != null) {
                    connection.rollback();
                }
            } finally {
                // PreparedStatement 종료
                if (pstmt != null) {
                    try {
                        pstmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        closeConnection();
    }
}
