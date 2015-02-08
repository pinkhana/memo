/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pinkxx.memo.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public abstract class MemoHibernateDaoSupport extends HibernateDaoSupport {

    @Autowired
    public void anyMethodName(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }
}
