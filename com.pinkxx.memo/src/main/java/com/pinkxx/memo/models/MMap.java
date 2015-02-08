/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pinkxx.memo.models;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Ayami
 */
@Entity
@Table(name = "mmap")
public class MMap implements Serializable {

    @Id
    @Column(name = "idfrom", unique = false, nullable = false)
    private Integer idfrom;

    @Id
    @Column(name = "idto", unique = false, nullable = false)
    private Integer idto;    
    
    public Integer getIdfrom() {
        return idfrom;
    }

    public void setIdfrom(Integer idfrom) {
        this.idfrom = idfrom;
    }
    
    public Integer getIdto() {
        return idto;
    }

    public void setIdto(Integer idto) {
        this.idto = idto;
    }    
}
