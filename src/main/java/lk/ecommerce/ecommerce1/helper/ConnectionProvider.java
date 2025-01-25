package lk.ecommerce.ecommerce1.helper;

import jakarta.servlet.http.HttpServlet;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider extends HttpServlet {
    private static final Long serialVersionUID = 1L;
    private static Connection connection;
    private static DataSource dataSource;


    public static Connection getConnection(){
        try {
            if (connection == null) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/zeemart", "root", "Ijse@123");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }

    public static DataSource getDataSource() {
        return dataSource;
    }

    public static void setDataSource(DataSource dataSource) {
        ConnectionProvider.dataSource = dataSource;
    }
}
