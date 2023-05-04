/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


//import com.mysql.cj.protocol.Resultset;
import java.sql.SQLException;
import util.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author PEDRO
 */
public class Conexion {
    public static void main(String[] args) throws SQLException{
        //verConexion();
        verDataMangas();
    }
    
    public static void verConexion() throws SQLException{
        ConexionBD c = new ConexionBD();
        if(c.conexionDB() != null){
            System.out.println("correcta la conexion");
        }else{
            System.out.println("incorrecta la conexion");
        }
        
    }
    public static void verDataMangas() throws SQLException{
        try {
        ConexionBD c = new ConexionBD();
        PreparedStatement ps = null;
        ResultSet rs= null;
        Connection con = c.conexionDB();
        
        String sql="select * from mangas";
        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();
        
        while (rs.next()) {    
            System.out.println(rs.getObject(3));
            System.out.println(rs.getObject(3).getClass().getSimpleName());
        }
        } catch (Exception e) {
            System.out.println("error-test");
        } finally {
        }
        
        
    }
}
