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
@Table(name = "memo")
public class Memo implements Serializable {

    @Id
    //@GeneratedValue(strategy = IDENTITY)
    //@generatedvalue(strategy = GenerationType.AUTO)
    //@GeneratedValue(strategy=GenerationType.AUTO, generator="my_entity_seq_gen")
    @GeneratedValue(strategy = GenerationType.AUTO, generator="memo_seq_gen")
    @SequenceGenerator(name="memo_seq_gen", sequenceName="MEMO_SEQ")
    @Column(name = "id", unique = true, nullable = false)
    private Integer id;
    @Column(name = "mkey")
    private String mkey;
    @Column(name = "memo")
    private String memo;
    @Column(name = "createdDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date createdDate;

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
    	/*try {
    		byte byteData[] = memo.getBytes( "UTF8" );
    		String utf8Str  = new String(byteData ,0 ,byteData.length, "shift-jis");
			memo = utf8Str;//URLDecoder.decode(memo,"UTF-16");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
        this.memo = memo;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMkey() {
        return mkey;
    }

    public void setMkey(String mkey) {
        this.mkey = mkey;
    }
}
