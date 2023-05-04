/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import models.Manga;
import views.jfrmMangas;

/**
 *
 * @author PEDRO
 */
public class CrudControllers implements ActionListener{
    jfrmMangas vistaCrud = new jfrmMangas();
    DaoMangaImpl modeloCrud = new DaoMangaImpl();
    Manga manga;

    public CrudControllers(jfrmMangas vistaCrud,DaoMangaImpl modeloCrud) {
        this.modeloCrud=modeloCrud;
        this.vistaCrud=vistaCrud;
        this.vistaCrud=vistaCrud;
        
        // Si este evento se activa
        this.vistaCrud.btnVerDatos.addActionListener(this);
        this.vistaCrud.btnInsertar.addActionListener(this);
    }
    
    public void InitialCrud(){
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == vistaCrud.btnAdicionar){
            AdicionarTabla(vistaCrud.tableDatosDeMangas);
        }
        if (e.getSource() == vistaCrud.btnVerDatos){
            LlenarTabla(vistaCrud.tableDatosDeMangas);
        }
        
        if (e.getSource() == vistaCrud.btnInsertar){
            InsertTabla();
        }
        
    }
    
    public void LlenarTabla( JTable tablaD){
        DefaultTableModel modeloT= new DefaultTableModel();
        tablaD.setModel(modeloT);
        String data = "";
        
        modeloT.addColumn("id");
        modeloT.addColumn("Description");
        //modeloT.addColumn("date");
        modeloT.addColumn("restriction id");
        modeloT.addColumn("author id");
        modeloT.addColumn("comments id");
        modeloT.addColumn("production id");
        modeloT.addColumn("scan id");
        modeloT.addColumn("title id");
        Object[] columna = new Object[9];
        int numRegistros = modeloCrud.mangaSel().size();
        for (int i=0; i<numRegistros; i++) {
            columna[0]=modeloCrud.mangaSel().get(i).getMan_id();
            columna[1]=modeloCrud.mangaSel().get(i).getMan_description();
            //columna[2]=modeloCrud.mangaSel().get(i).getMan_date();
            columna[2]=modeloCrud.mangaSel().get(i).getMan_ar_id();
            columna[3]=modeloCrud.mangaSel().get(i).getMan_author_id();
            columna[4]=modeloCrud.mangaSel().get(i).getMan_comment_id();
            columna[5]=modeloCrud.mangaSel().get(i).getMan_production_id();
            columna[6]=modeloCrud.mangaSel().get(i).getMan_scan_id();
            columna[7]=modeloCrud.mangaSel().get(i).getMan_title_id();
            modeloT.addRow(columna);
            
            manga = new Manga(Integer.valueOf(columna[0].toString()),columna[1].toString());
            data += manga.getLista();
            
        }
            this.vistaCrud.txtLista.setText(data);
    }
    
    public void AdicionarTabla( JTable tablaD){
        
    }
    
    public void InsertTabla(){
        String description = vistaCrud.txtDescription.getText();
        int ageRestriction = vistaCrud.cbxMan_ar_id.getSelectedIndex()+1;
        int author = vistaCrud.cbxMan_author_id.getSelectedIndex()+1;
        int comments = vistaCrud.cbxMan_comment_id.getSelectedIndex()+1;
        int tm_production = vistaCrud.cbxMan_production_id.getSelectedIndex()+1;
        int tm_scan = vistaCrud.cbxMan_scan_id.getSelectedIndex()+1;
        int title = vistaCrud.cbxMan_title_id.getSelectedIndex()+1;
        
        
        manga = new Manga(description, ageRestriction, author, comments, tm_production, tm_scan, title);
        
        String rptaRegistro = modeloCrud.mangaIns(manga);
        
        if (rptaRegistro != null){
            JOptionPane.showMessageDialog(null, rptaRegistro);
        }else {
            JOptionPane.showMessageDialog(null, "registro erroneo");
        }
                
    }
}
