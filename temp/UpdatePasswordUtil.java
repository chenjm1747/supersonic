import java.sql.*;

public class UpdatePasswordUtil {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://192.168.1.7:54321/postgres";
        String user = "postgres";
        String password = "Huilian1234";
        
        String newPassword = "c3VwZXJzb25pY0BiaWNvbTD12g9wGXESwL7+o7xUW90=";
        String salt = "jGl25bVBBBW96Qi9Te4V3w==";
        
        String sql = "UPDATE heating_analytics.s2_user SET password = ?, salt = ? WHERE name = ?";
        
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, newPassword);
            pstmt.setString(2, salt);
            pstmt.setString(3, "admin");
            
            int rowsUpdated = pstmt.executeUpdate();
            System.out.println("Updated " + rowsUpdated + " row(s)");
            
            // 验证
            String verifySql = "SELECT name, password FROM heating_analytics.s2_user WHERE name = 'admin'";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(verifySql)) {
                if (rs.next()) {
                    System.out.println("Verification - Name: " + rs.getString("name"));
                    System.out.println("Verification - Password: " + rs.getString("password"));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
