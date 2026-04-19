import java.sql.*;

public class CheckUsers {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://192.168.1.7:54321/postgres";
        String user = "postgres";
        String password = "Huilian1234";
        
        String sql = "SELECT name, password, salt FROM heating_analytics.s2_user";
        
        try (Connection conn = DriverManager.getConnection(url, user, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                System.out.println("Name: " + rs.getString("name"));
                System.out.println("Password: " + rs.getString("password"));
                System.out.println("Salt: " + rs.getString("salt"));
                System.out.println("---");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
