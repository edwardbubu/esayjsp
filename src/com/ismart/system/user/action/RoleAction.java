package com.ismart.system.user.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import com.ismart.common.json.JSONException;
import com.ismart.common.json.JSONObject;
import com.ismart.common.json.JsonUtil;
import com.ismart.common.util.StrUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.ismart.system.node.domain.Node;
import com.ismart.system.user.service.RoleService;
import com.ismart.system.user.domain.RoleNode;
import com.ismart.system.code.action.CodeAction;

public class RoleAction extends ActionSupport {

	private RoleNode role ;
	private RoleService roleService;
	ActionContext context = null;  
	HttpServletRequest req = null;  
	HttpServletResponse res = null; 
	HttpSession session = null;
	PrintWriter pw = null;
	
	
	
	public String query() throws Exception {
		ArrayList  success = getQuery();
		Gson gson = new Gson(); 
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("total", success.size());   
		jsonMap.put("rows", success); 
		pw = res.getWriter();
		try {
			pw.write(JsonUtil.map2json(jsonMap));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public ArrayList getQuery() throws JSONException{
		ArrayList obj = new ArrayList();
		getPubPro();
		role = new RoleNode();
		role.setNodeid(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("setid"))));		
		obj = roleService.query(role);
		return obj;
	}
	
	public String add() throws Exception {
		String success = roleAdd();
		
		pw = res.getWriter();
		try {
			pw.write(success);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public String roleAdd(){
		
		String msg = "保存成功";
		try{
			getPubPro();
			role = new RoleNode();
			String MaxId = getRoleId();
			if("".equals(MaxId)||MaxId==null){
				role.setRolenodeid("1");
			}else{
				role.setRolenodeid(MaxId);
			}
			role.setNodeid(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("setid"))));		
			role.setUsertypename(StrUtil.nullToString(req.getParameter("usertypename")));
			roleService.insert(role);
			
		}catch(Exception e){
			msg="保存失败";
			e.printStackTrace();
		}
		return msg;
	}
	
	public String getRoleId(){
		return roleService.getRoleId();
	}
	
	
	public String delete() throws IOException{
		getPubPro();
		String msg = "删除成功";
		pw = res.getWriter();
		try{
			roleService.delete(StrUtil.nullToString(req.getParameter("rolenodeid")));
		}catch(Exception e){
			msg = "删除失败";
			e.printStackTrace();
		}
		pw.write(msg);
		return null;
	}
	
	public void getPubPro(){
		context = ActionContext.getContext();
		req = (HttpServletRequest) context.get(ServletActionContext.HTTP_REQUEST); 
		res = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE); 
		session = req.getSession();//(ServletRequest) context.getSession();
		res.setCharacterEncoding("UTF-8");
		
	}
	public RoleService getRoleService() {
		return roleService;
	}
	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}


	

}
