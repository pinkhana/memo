/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pinkxx.memo.dao;

import java.sql.SQLException;
import java.util.List;

import com.pinkxx.memo.models.MMap;
import com.pinkxx.memo.models.Memo;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Ayami
 */
@Repository("memoDao")
public class MemoDAOImpl extends HibernateDaoSupport implements MemoDAO {
//public class MemoDAOImpl implements MemoDAO {

    @Autowired
    public void anyMethodName(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }
    
    //add the memo
    public void addMemo(Memo memo) {
        getHibernateTemplate().save(memo);
    }

    //update the memo
    public void updateMemo(Memo memo) {
        Memo hbnMemo = getHibernateTemplate().get(Memo.class, memo.getId());
        hbnMemo.setMkey(memo.getMkey());
        hbnMemo.setMemo(memo.getMemo());
        getHibernateTemplate().update(hbnMemo);
    }
    
    //return all the memos in list
    public List<Memo> listMemo() {
        return getHibernateTemplate().find("from Memo");
    }
    
    /*public List<MMap> getMemoMapFromByIdto(int idto) {
        return getHibernateTemplate().find("from MMap where idto = ?",idto);
    }*/

    public List<Object[]> getMemoMapFromByIdto(int idto) {
        return getHibernateTemplate().find("from Memo as memo, MMap as mmap where memo.id = mmap.idfrom and mmap.idto = ?",idto);
    }
    
    //page
    /*public List<Memo> listMemo(int index, int pageSize) {
        return getHibernateTemplate().find("from (select t.* from (select * from MEMO.MEMO order by CREATEDDATE desc) t ) where rownum>"+index+" and rownum<="+(index+pageSize));
    }
    @SuppressWarnings("rawtypes")
	public List getListForPage(final String hql, final int offset, final int length) { 
    	List list = getHibernateTemplate().executeFind(new HibernateCallback() { 
    	public Object doInHibernate(Session session) throws HibernateException, SQLException { 
    	Query query = session.createQuery(hql); 
    	query.setFirstResult(offset); 
    	query.setMaxResults(length); 
    	List list = query.list(); 
    	return list; }}); 
    	return list;
    }*/ 
    public List<Memo> listMemo(final int firstResult,final int maxResults) { 
    	return getHibernateTemplate().executeFind(new HibernateCallback() { 
    	public Object doInHibernate(Session s) 
    	throws HibernateException, SQLException { 
    	String q = "from Memo as memo order by CREATEDDATE desc"; 
    	Query query = s.createQuery(q);
    	query.setFirstResult(firstResult); 
    	query.setMaxResults(maxResults); 
    	List<Memo> list = query.list(); 
    	return list; 
    	} 
    	}); 
    }
    
    public int countMemo() {
    	String hqlString = "select count(*) from Memo";
    	Query query = this.getSession().createQuery(hqlString);
    	return ((Number)query.uniqueResult()).intValue();
    }
    /*public int findCountByYear(String currYear) {
        String hqlString = "select count(*) from WaterPlan as p where p.planYear ='"+currYear+"'";
        Query query = this.getSession().createQuery(hqlString);
    		
        return ((Number)query.uniqueResult()).uniqueResult();
    }*/
    
    //add the mmap
    public void addMMap(MMap mmap) {
        getHibernateTemplate().save(mmap);
    }    
}
