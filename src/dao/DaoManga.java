
import java.util.List;
import models.Manga;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */



/**
 *
 * @author PEDRO
 */
public interface DaoManga {
    //ver voleta por desc
    public List<Manga> mangaSel();
    
    public String mangaIns(Manga manga);
    public String mangaUpd(Manga manga);
    public String mangaDel(List<Integer> ids);
    
    public String getMenssage();
}
