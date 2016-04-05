package com.ismart.system.tree.action;

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
import com.ismart.common.util.StrUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.ismart.system.node.domain.Node;
import com.ismart.system.tree.domain.Tree;
import com.ismart.system.tree.service.TreeService;

public class TreeAction extends ActionSupport {

	private Tree tree ;
	private Node node ;
	private TreeService treeService;
	ActionContext context = null;  
	HttpServletRequest req = null;  
	HttpServletResponse res = null; 
	HttpSession session = null;
	PrintWriter pw = null;
	
	
	
	public String queryNode() throws Exception {
		ArrayList  success = getQueryNode();
		res.setCharacterEncoding("UTF-8");
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
	public ArrayList getQueryNode() throws JSONException{
		ArrayList obj = new ArrayList();
		getPubPro();
		node = new Node();
		node.setNodeid(StrUtil.nullToString(req.getParameter("id")));
		node.setPid(StrUtil.nullToString(req.getParameter("pid")));
		node.setLevel(StrUtil.nullToString(req.getParameter("level")));
		node.setNodename(StrUtil.nullToString(req.getParameter("value")));
		obj = treeService.nodeTree(node);
		return obj;
	}
	public String treeMain() throws Exception {
		getPubPro();
		req.setAttribute("type", StrUtil.nullToString(req.getParameter("type")));
		req.setAttribute("pid", StrUtil.nullToString(req.getParameter("pid")));
		req.setAttribute("level", StrUtil.nullToString(req.getParameter("level")));
		req.setAttribute("isSearch", StrUtil.nullToString(req.getParameter("isSearch")));
		return SUCCESS;
	}
	public void getPubPro(){
		context = ActionContext.getContext();
		req = (HttpServletRequest) context.get(ServletActionContext.HTTP_REQUEST); 
		res = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE); 
		session = req.getSession();//(ServletRequest) context.getSession();
		
	}
	public TreeService getTreeService() {
		return treeService;
	}
	public void setTreeService(TreeService treeService) {
		this.treeService = treeService;
	}


	

}
