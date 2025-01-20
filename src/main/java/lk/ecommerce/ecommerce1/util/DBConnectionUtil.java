package lk.ecommerce.ecommerce1.util;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DBConnectionUtil {

    private  static DataSource dataSource;

    static {
        try{
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            dataSource = (DataSource) envContext.lookup("jdbc/pool");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Faild to initializee DataSource" , e);
        }
    }

    private static Connection getConnection() throws Exception {
       return dataSource.getConnection();
    }

}
