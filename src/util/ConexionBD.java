package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {    
    private final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private final String DATABASE = "yugenmangas";
    private final String URL = "jdbc:mysql://localhost:3306/"+DATABASE;
    private final String USER = "root";
    private final String PASS = "";
    
    public Connection conexionDB() throws SQLException{
    Connection c = null;
        try {
            Class.forName(DRIVER);
            c = DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException | SQLException e) {
            throw new SQLException(e.getMessage());
        }    
    return c;
    }
}



