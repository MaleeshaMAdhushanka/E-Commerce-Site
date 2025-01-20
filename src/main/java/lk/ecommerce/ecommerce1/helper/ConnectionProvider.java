package lk.ecommerce.ecommerce1.helper;

import jakarta.servlet.http.HttpServlet;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider extends HttpServlet {
    private static final Long serialVersionUID = 1L;
    private static Connection connection;


    private static Connection getConnection(){
        try {
            if (connection == null) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ZeeMart", "root", "root");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }

}
