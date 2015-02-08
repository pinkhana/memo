/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pinkxx.memo.actions;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.opensymphony.xwork2.ModelDriven;
import com.pinkxx.memo.dao.MemoDAO;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pinkxx.memo.models.MMap;
import com.pinkxx.memo.models.Memo;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 *
 * @author Ayami
 */
//The Struts2 action is no longer need to extends the ActionSupport, Spring will handle it.
@Component
public class MemoAction implements ModelDriven {

    Memo memo = new Memo();
    MMap mmap = new MMap();
    List<Memo> memoList = new ArrayList<Memo>();
    List<MMap> mmapList = new ArrayList<MMap>();
    @Autowired
    MemoDAO memoDAO;

    public Object getModel() {
        return memo;
    }

    public List<Memo> getMemoList() {
        return memoList;
    }

    public void setMemoList(List<Memo> memoList) {
        this.memoList = memoList;
    }
    //save memo

    public String addMemo() throws Exception {

		HttpServletRequest req = ServletActionContext.getRequest();
		HttpServletResponse res = ServletActionContext.getResponse();
		//Ayami*~
		req.setCharacterEncoding("UTF-8");
		//String mkey = req.getParameter("mkey");
		
    	//save it
    	Date now = new Date(System.currentTimeMillis());
        memo.setCreatedDate(now);
        memoDAO.addMemo(memo);

        //reload the memo list
        memoList = null;
        memoList = memoDAO.listMemo();
        res.setCharacterEncoding("UTF-8");
        return "success";
    }

    public String listMemo() throws Exception {
    	HttpServletResponse res = ServletActionContext.getResponse();
        memoList = memoDAO.listMemo();
        res.setCharacterEncoding("UTF-8");
        return "success";

    }
    
    public String getListMemoAjax() throws Exception{

		HttpServletResponse res = ServletActionContext.getResponse();
		HttpServletRequest req = ServletActionContext.getRequest();
		req.setCharacterEncoding("UTF-8");
		  
		String start = req.getParameter("start");
		String limit = req.getParameter("limit");
		
		int index = Integer.parseInt(start);
		int pageSize = Integer.parseInt(limit);		
		
		int totalCount = memoDAO.countMemo();
		memoList = memoDAO.listMemo(index, index+pageSize);
		
		GsonBuilder builder = new GsonBuilder();
	    //builder.excludeFieldsWithoutExposeAnnotation();
	    Gson gson = builder.create();
	    
	    String jsonMemoList = gson.toJson(memoList);
	    jsonMemoList = "{totalCount:" + totalCount + ",memo:" + jsonMemoList;
	    jsonMemoList = jsonMemoList + "}";
	    System.out.println(jsonMemoList);
		  
		res.setCharacterEncoding("UTF-8");
		//res.getWriter().print("{\"info\":"+0+"}");
		res.getWriter().print(jsonMemoList);
		  
		return null;
    }
    
    public String addMemoAjax() throws Exception {

		HttpServletRequest req = ServletActionContext.getRequest();
		HttpServletResponse res = ServletActionContext.getResponse();
		req.setCharacterEncoding("UTF-8");
		
    	//save it
    	Date now = new Date(System.currentTimeMillis());
        memo.setCreatedDate(now);
        memoDAO.addMemo(memo);

        //reload the memo list
        //memoList = null;
        //memoList = memoDAO.listMemo();
        //res.setCharacterEncoding("UTF-8");
        return null;
    }
    
    public String updateMemoAjax() throws Exception {

		HttpServletRequest req = ServletActionContext.getRequest();
		HttpServletResponse res = ServletActionContext.getResponse();
		req.setCharacterEncoding("UTF-8");
		
    	//save it
    	//Date now = new Date(System.currentTimeMillis());
        //memo.setCreatedDate(now);
        memoDAO.updateMemo(memo);

        //reload the memo list
        //memoList = null;
        //memoList = memoDAO.listMemo();
        //res.setCharacterEncoding("UTF-8");
        return null;
    }

    public String getMemoMapListAjax() throws Exception {

		HttpServletRequest req = ServletActionContext.getRequest();
		HttpServletResponse res = ServletActionContext.getResponse();
		req.setCharacterEncoding("UTF-8");
		
		//String start = req.getParameter("start");
		//String limit = req.getParameter("limit");
		
		//int index = Integer.parseInt(start);
		//int pageSize = Integer.parseInt(limit);		
		
		//int totalCount = memoDAO.countMemo();
		memoList = memoDAO.listMemo(0, 8);
		
		GsonBuilder builder = new GsonBuilder();
	    //builder.excludeFieldsWithoutExposeAnnotation();
	    Gson gson = builder.create();
	    
	    String jsonMemoList = gson.toJson(memoList);
	    //jsonMemoList = "{memo:" + jsonMemoList;
	    //jsonMemoList = jsonMemoList + "}";
	    System.out.println(jsonMemoList);
		  
		res.setCharacterEncoding("UTF-8");
		//res.getWriter().print("{\"info\":"+0+"}");
		res.getWriter().print(jsonMemoList);
		  
		return null;
    }    
    
    public String addMemoMapAjax() throws Exception {

		HttpServletRequest req = ServletActionContext.getRequest();
		HttpServletResponse res = ServletActionContext.getResponse();
		req.setCharacterEncoding("UTF-8");
		
    	//save it
		String strIdfrom = req.getParameter("dragmemoid");
		String strIdto = req.getParameter("editmemoid");
		
		int idfrom = Integer.parseInt(strIdfrom);
		int idto = Integer.parseInt(strIdto);			
		
		mmap.setIdfrom(idfrom);
		mmap.setIdto(idto);
        memoDAO.addMMap(mmap);

        return null;
    }
    
    public String getMemoMapFromByIdtoAjax() throws Exception {

		HttpServletRequest req = ServletActionContext.getRequest();
		HttpServletResponse res = ServletActionContext.getResponse();
		req.setCharacterEncoding("UTF-8");
		
		String strIdto = req.getParameter("editmemoid");
		int idto = Integer.parseInt(strIdto);

		memoList = new ArrayList<Memo>();
		List<Object[]> oList = memoDAO.getMemoMapFromByIdto(idto);
		for(Object[] o:oList){
			for(int i=0;i<o.length;i++){
				if(o[i] instanceof Memo){
					memoList.add((Memo) o[i]);
				}
			}
		}
		
		GsonBuilder builder = new GsonBuilder();
	    Gson gson = builder.create();
	    
	    String jsonMMapList = gson.toJson(memoList);
	    System.out.println(jsonMMapList);
		  
		res.setCharacterEncoding("UTF-8");
		res.getWriter().print(jsonMMapList);
		  
		return null;
    }    
}
