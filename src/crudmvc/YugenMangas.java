
import views.jfrmMangas;




/**
 *
 * @author PEDRO
 */
public class YugenMangas {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        jfrmMangas vistaManga = new jfrmMangas();
        DaoMangaImpl modeloManga= new DaoMangaImpl();
        CrudControllers controllersManga = new CrudControllers(vistaManga, modeloManga);
        
        vistaManga.setVisible(true);
        vistaManga.setLocationRelativeTo(null);
        
        
        System.out.println("Repositorio creado");
    }
    
}
