package com.ismart.system.user.action;

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
import com.ismart.common.json.JsonUtil;
import com.ismart.common.util.StrUtil;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import com.ismart.system.user.domain.SystemUser;
import com.ismart.system.user.service.SysuserService;

public class UserAction extends ActionSupport {

	private SystemUser user ;
	//private Resource resource ;
	private List<SystemUser> users;
	private SysuserService sysuserService;
	ActionContext context = null;  
	HttpServletRequest req = null;  
	HttpServletResponse res = null; 
	HttpSession session = null;
	PrintWriter pw = null;
	
	
	public String edit() throws Exception {
		String success = userEdit();
		pw = res.getWriter();
		try {
			pw.write(success);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public String delete() throws Exception {
		
		String msg = "删除成功";
		getPubPro();
		if(!"SUCCESS".equals(sysuserService.delete(req.getParameter("sysuserid")))){
			msg = "删除失败";
		}
		res.setCharacterEncoding("UTF-8");
		pw = res.getWriter();
		try {
			pw.write(msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public String login() throws Exception {
		String success = getLoginInfo();
		session.setAttribute("user", user);
		pw = res.getWriter();
		try {
			pw.write(success);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public String query() throws Exception {
		ArrayList  success = getQuery();
		res.setCharacterEncoding("UTF-8");
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
	public String home() throws Exception {
		Map  success = getNavigation();
		req.setAttribute("map", success);
		return SUCCESS;
	}
	public String getUserId(){
		return sysuserService.getUserId();
	}
	public String getLoginInfo(){
		getPubPro();
		user = new SystemUser();
		user.setLoginname(req.getParameter("loginname"));
		user.setPassword(req.getParameter("password"));
		String loginInfo = "";
		user = sysuserService.LoginInfo(user);
		if(!"".equals(user.getLoginname())&&null!=user.getLoginname()){
			loginInfo="SUCCESS";	
		}else{
			loginInfo="FAILURE";	
		}
		return loginInfo;
	}
	public ArrayList getQuery() throws JSONException{
		ArrayList obj = new ArrayList();
		getPubPro();
		
		int crupage =Integer.parseInt(req.getParameter("page"));
		int row = Integer.parseInt(req.getParameter("rows"));
		user = new SystemUser();
		
		user.setLoginname(StrUtil.nullToString(req.getParameter("qloginname")));
		user.setUsername(StrUtil.nullToString(req.getParameter("qusername")));
		user.setPassword(StrUtil.nullToString(req.getParameter("qpassword")));
		user.setUsertype(StrUtil.nullToString(req.getParameter("qusertype")));
		user.setDisabledate(StrUtil.nullToString(req.getParameter("qdisabledate")));
		obj = sysuserService.query(user);
		return obj;
	}
	
	public String userEdit(){
		
		String msg = "保存成功";
		try{
			getPubPro();
			res.setCharacterEncoding("UTF-8");
			if("".equals(req.getParameter("userid"))){
				String userId = getUserId();
				
				user = new SystemUser();
				if("".equals(userId)||userId==null){
					user.setUserid("1");
				}else{
					user.setUserid(userId);
				}
				user.setLoginname(req.getParameter("regloginname"));
				user.setUsername(req.getParameter("regusername"));
				user.setPassword(req.getParameter("regpassword"));
				user.setUsertype(req.getParameter("regusertype"));
				user.setDisabledate(req.getParameter("regdisabledate"));
				sysuserService.insert(user);
			}else{
				user.setUserid(req.getParameter("userid"));
				user.setLoginname(req.getParameter("regloginname"));
				user.setUsername(req.getParameter("regusername"));
				user.setPassword(req.getParameter("regpassword"));
				user.setUsertype(req.getParameter("regusertype"));
				user.setDisabledate(req.getParameter("regdisabledate"));
				sysuserService.edit(user);
			}
			
		}catch(Exception e){
			msg="保存失败";
			e.printStackTrace();
		}
		return msg;
	}
	public Map getNavigation() throws JSONException{
		getPubPro();
		user = (SystemUser)session.getAttribute("user");
		//resource.setType(StrUtil.nullToString(req.getParameter("type")));
		Map obj = sysuserService.getNavigation(user);
		return obj;
	}
	
	public void getPubPro(){
		context = ActionContext.getContext();
		req = (HttpServletRequest) context.get(ServletActionContext.HTTP_REQUEST); 
		res = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE); 
		session = req.getSession();//(ServletRequest) context.getSession();
		
	}

	public SysuserService getSysuserService() {
		return sysuserService;
	}

	public void setSysuserService(SysuserService sysuserService) {
		this.sysuserService = sysuserService;
	}

	

}
