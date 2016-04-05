package com.ismart.system.code.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import com.ismart.common.json.JSONException;
import com.ismart.common.util.StrUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.ismart.system.code.domain.Cbox;
import com.ismart.system.code.service.CboxService;

public class CboxAction extends ActionSupport {

	private Cbox cb ;
	private CboxService cbService;
	ActionContext context = null;  
	HttpServletRequest req = null;  
	HttpServletResponse res = null; 
	HttpSession session = null;
	PrintWriter pw = null;
	
	
	public String query() throws Exception {
		ArrayList  success = getQuery();
		Gson gson = new Gson(); 
		String json = gson.toJson(success);
		pw = res.getWriter();
		try {
			pw.write(json);
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return null;
	}
	public ArrayList getQuery() throws JSONException{
		ArrayList obj = new ArrayList();
		getPubPro();
		cb = new Cbox();
		cb.setPid(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("pid"))));
		obj = cbService.query(cb);
		return obj;
	}
	
	public String queryType() throws Exception {
		ArrayList  success = getQueryType();
		Gson gson = new Gson(); 
		String json = gson.toJson(success);
		pw = res.getWriter();
		try {
			pw.write(json);
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return null;
	}
	public ArrayList getQueryType() throws JSONException{
		ArrayList obj = new ArrayList();
		getPubPro();
		obj = cbService.queryType();
		return obj;
	}
	
	
	public void getPubPro(){
		context = ActionContext.getContext();
		req = (HttpServletRequest) context.get(ServletActionContext.HTTP_REQUEST); 
		res = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE); 
		session = req.getSession();//(ServletRequest) context.getSession();
		res.setCharacterEncoding("UTF-8");
		
	}
	public CboxService getCbService() {
		return cbService;
	}
	public void setCbService(CboxService cbService) {
		this.cbService = cbService;
	}


}
