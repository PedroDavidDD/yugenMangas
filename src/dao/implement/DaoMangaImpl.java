/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import java.util.List;
import models.Manga;
import util.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;

/**
 *
 * @author PEDRO
 */
public class DaoMangaImpl implements DaoManga {

    private final ConexionBD conectaDb;
    private String mensaje;

    public DaoMangaImpl() {
        this.conectaDb = new ConexionBD();
    }

    @Override
    public List<Manga> mangaSel() {
        List<Manga> list = new ArrayList<>();
        Manga manga;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT ")
                .append("man_id,")
                .append("man_description,")
                //.append("man_date")
                .append("man_ar_id,")
                .append("man_author_id,")
                .append("man_comment_id,")
                .append("man_production_id,")
                .append("man_scan_id,")
                .append("man_title_id")
                .append(" FROM mangas");
        try (Connection cn = conectaDb.conexionDB()) {
            PreparedStatement ps = cn.prepareStatement(sql.toString());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                //  pedimos los datos
                manga = new Manga();

                manga.setMan_id(rs.getInt(1));

                manga.setMan_description(rs.getString(2).toLowerCase().trim());
                //manga.setMan_date(LocalDate.parse(rs.getString(3)));

                manga.setMan_ar_id(rs.getInt(3));
                manga.setMan_author_id(rs.getInt(4));
                manga.setMan_comment_id(rs.getInt(5));
                manga.setMan_production_id(rs.getInt(6));
                manga.setMan_scan_id(rs.getInt(7));
                manga.setMan_title_id(rs.getInt(8));

                list.add(manga);
            }
        } catch (Exception e) {
            mensaje = e.getMessage();
        }

        return list;
    }

    @Override
    public String mangaIns(Manga manga) {
        StringBuilder sql = new StringBuilder();
        sql.append("EXECUTE insert_mangas ")
                .append("?,?,?,?,?,?,?");
        try ( Connection cn = conectaDb.conexionDB()) {
            PreparedStatement ps = cn.prepareStatement(sql.toString());
            ps.setString(1, manga.getMan_description() );
            ps.setInt(2, manga.getMan_ar_id());
            ps.setInt(3, manga.getMan_author_id());
            ps.setInt(4, manga.getMan_comment_id());
            ps.setInt(5, manga.getMan_production_id());
            ps.setInt(6, manga.getMan_scan_id());
            ps.setInt(7, manga.getMan_title_id());
            int ctos = ps.executeUpdate();

            if (ctos == 0) {
                mensaje = "cero filas insertadas";
            }
        } catch (Exception e) {
            mensaje = e.getMessage();
        }
        return mensaje;
    }

    @Override
    public String mangaUpd(Manga manga) {

        /*
                StringBuilder sql = new StringBuilder();
        sql.append("UPDATE boleta SET ")
                .append("fecha_reg_boleta = ?, ")
                .append("idUsuario = ?, ")
                .append("id_compra = ?, ")
                .append("iva = ?, ")
                .append("metodo_de_pago = ?, ")
                .append("nombres = ?, ")
                .append("email = ?, ")
                .append("telefono = ?, ")
                .append("direccion = ?, ")
                .append("subTotal = ?, ")
                .append("totalPagar = ?, ")
                .append("status = ?, ")
                .append("tiempo_estimado = ? ")
                .append("WHERE id = ? ");
        try ( Connection cn = conectaDb.conexionDB()) {
            PreparedStatement ps = cn.prepareStatement(sql.toString());
            ps.setString(1, LocalDate.now().toString());
            ps.setInt(2, boleta.getIdUsuario());
            ps.setInt(3, boleta.getId_compra());
            ps.setDouble(4, boleta.getIva());
            ps.setString(5, boleta.getMetodo_de_pago().trim().toLowerCase());
            ps.setString(6, boleta.getNombres().toLowerCase());
            ps.setString(7, boleta.getEmail().toLowerCase());
            ps.setInt(8, boleta.getTelefono());
            ps.setString(9, boleta.getDireccion());
            ps.setDouble(10, boleta.getSubTotal());
            ps.setDouble(11, boleta.getTotalPagar());
            ps.setString(12, boleta.getStatus());
            ps.setInt(13, boleta.getTiempo_estimado());
            ps.setInt(14, boleta.getId());
            int ctos = ps.executeUpdate();
            if (ctos == 0) {
                mensaje = "No se pudo actualizar";
            }
        } catch (SQLException e) {
            mensaje = e.getMessage();
        }
        return mensaje;
         */
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public String mangaDel(List<Integer> ids) {
        /*
        
        StringBuilder sql = new StringBuilder();
        sql.append("DELETE FROM boleta WHERE ")
                .append("id = ? ");
        try ( Connection cn = conectaDb.conexionDB()) {
            PreparedStatement ps = cn.prepareStatement(sql.toString());
            cn.setAutoCommit(false);
            boolean ok = true;
            for (int id = 0; id < ids.size(); id++) {
                ps.setInt(1, ids.get(id));
                int ctos = ps.executeUpdate();
                if (ctos == 0) {
                    ok = false;
                    mensaje = "ID: " + ids.get(id) + " no existe";
                }
            }
            if (ok) {
                cn.commit();
            } else {
                cn.rollback();
            }
            cn.setAutoCommit(true);
        } catch (SQLException e) {
            mensaje = e.getMessage();
        }
        return mensaje;
         */
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public String getMenssage() {
        return mensaje;
    }

}
