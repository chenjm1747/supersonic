import java.sql.*;

public class AlterTable {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://192.168.1.7:54321/postgres";
        String user = "postgres";
        String password = "Huilian1234";
        
        String sql = "ALTER TABLE heating_analytics.s2_user ADD COLUMN IF NOT EXISTS last_login TIMESTAMP NULL";
        
        try (Connection conn = DriverManager.getConnection(url, user, password);
             Statement stmt = conn.createStatement()) {
            
            stmt.execute(sql);
            System.out.println("Column added successfully!");
            
            ResultSet rs = stmt.executeQuery("SELECT column_name FROM information_schema.columns WHERE table_name = 's2_user' AND column_name = 'last_login'");
            if (rs.next()) {
                System.out.println("Verified: last_login column exists");
            }
        } catch (SQLException e) {
            System.err.println("Error: " + e.getMessage());
        }
    }
}
