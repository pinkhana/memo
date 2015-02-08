/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pinkxx.memo.dao;

import java.util.List;

import com.pinkxx.memo.models.MMap;
import com.pinkxx.memo.models.Memo;

/**
 *
 * @author Ayami
 */
public interface MemoDAO {

    void addMemo(Memo memo);
    
    void updateMemo(Memo memo);

    List<Memo> listMemo();
    
    List<Memo> listMemo(final int firstResult, final int maxResults);
    
    int countMemo();
    
    void addMMap(MMap mmap);
    
    List<Object[]> getMemoMapFromByIdto(int idto);
}
