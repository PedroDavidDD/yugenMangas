/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.time.LocalDate;


/**
 *
 * @author PEDRO
 */
public class Manga {

    private Integer man_id;

    private String man_description;
    //private LocalDate man_date;

    private Integer man_ar_id;
    private Integer man_author_id;
    private Integer man_comment_id;
    private Integer man_production_id;
    private Integer man_scan_id;
    private Integer man_title_id;

    public Manga() {
    }

    public Manga(Integer man_id, String man_description, Integer man_ar_id, Integer man_author_id, Integer man_comment_id, Integer man_production_id, Integer man_scan_id, Integer man_title_id) {
        this.man_id = man_id;
        this.man_description = man_description;
        this.man_ar_id = man_ar_id;
        this.man_author_id = man_author_id;
        this.man_comment_id = man_comment_id;
        this.man_production_id = man_production_id;
        this.man_scan_id = man_scan_id;
        this.man_title_id = man_title_id;
    }

    public Manga(Integer man_id, String man_description) {
        this.man_id = man_id;
        this.man_description = man_description;
    }

    public Integer getMan_id() {
        return man_id;
    }

    public void setMan_id(Integer man_id) {
        this.man_id = man_id;
    }

    public String getMan_description() {
        return man_description;
    }

    public void setMan_description(String man_description) {
        this.man_description = man_description;
    }

    public Integer getMan_ar_id() {
        return man_ar_id;
    }

    public void setMan_ar_id(Integer man_ar_id) {
        this.man_ar_id = man_ar_id;
    }

    public Integer getMan_author_id() {
        return man_author_id;
    }

    public void setMan_author_id(Integer man_author_id) {
        this.man_author_id = man_author_id;
    }

    public Integer getMan_comment_id() {
        return man_comment_id;
    }

    public void setMan_comment_id(Integer man_comment_id) {
        this.man_comment_id = man_comment_id;
    }

    public Integer getMan_production_id() {
        return man_production_id;
    }

    public void setMan_production_id(Integer man_production_id) {
        this.man_production_id = man_production_id;
    }

    public Integer getMan_scan_id() {
        return man_scan_id;
    }

    public void setMan_scan_id(Integer man_scan_id) {
        this.man_scan_id = man_scan_id;
    }

    public Integer getMan_title_id() {
        return man_title_id;
    }

    public void setMan_title_id(Integer man_title_id) {
        this.man_title_id = man_title_id;
    }
    
    public String getLista() {
        String data = "["+this.getMan_id()+"-"+this.getMan_description()+"-"+getMan_ar_id()+"] \n";
        
        return data;
    }

}
