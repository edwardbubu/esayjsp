package com.ismart.system.node.action;

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
import com.ismart.system.node.service.NodeService;
import com.ismart.system.user.domain.RoleNode;
import com.ismart.system.code.action.CodeAction;

public class NodeAction extends ActionSupport {

	private Node node ;
	private RoleNode cb ;
	private NodeService nodeService;
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
		node = new Node();
		node.setNodeid(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("nodeid"))));
		node.setPid(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("pid"))));
		node.setNodename(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("nodename"))));
		node.setLevel(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("level"))));
		node.setSpurl(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("spurl"))));
		node.setSporder(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("sporder"))));
		obj = nodeService.query(node);
		return obj;
	}
	
	public String edit() throws Exception {
		//String success = resource2user();
		String success = resourceEdit();
		
		pw = res.getWriter();
		try {
			pw.write(success);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public String resourceEdit(){
		
		String msg = "保存成功";
		try{
			getPubPro();//��ȡ�����
			if("".equals(StrUtil.nullToString(req.getParameter("nodeid")))){
				String nodeid = getNodeId();
				String rightid = getUserTypeRightId();
				
				node = new Node();
				cb = new RoleNode();
				
				if("".equals(nodeid)||nodeid==null){
					node.setNodeid("1");
					cb.setNodeid("1");
				}else{
					node.setNodeid(nodeid);
					cb.setNodeid(nodeid);
				}
				node.setPid(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("pid"))));
				node.setNodename(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("nodename"))));
				node.setLevel(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("level"))));
				node.setSpurl(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("spurl"))));
				node.setSporder(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("sporder"))));
				cb.setUsertypename("ADMIN");
				cb.setRolenodeid(rightid);
				nodeService.insertRightAuto(cb);
				nodeService.insert(node);	
			}else{
				node.setNodeid(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("nodeid"))));
				node.setPid(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("pid"))));
				node.setNodename(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("nodename"))));
				node.setLevel(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("level"))));
				node.setSpurl(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("spurl"))));
				node.setSporder(StrUtil.nullToString(StrUtil.nullToString(req.getParameter("sporder"))));
				nodeService.edit(node);
			}
			
		}catch(Exception e){
			msg="保存失败";
			e.printStackTrace();
		}
		return msg;
	}
	
	/*public String resource2user(){
		
		String msg = "����ɹ�!";
		try{
			getPubPro();//��ȡ�����
			if("".equals(StrUtil.nullToString(req.getParameter("nodeid")))){
				String nodeid = getNodeId();
				String rightid = getUserTypeRightId();	
				
				if("".equals(nodeid)||nodeid==null){
					tmp.setNodename("1");
				}else{
					tmp.setNodename(nodeid);
				}
				
				if("".equals(rightid)||rightid==null){
					tmp.setUsertyperightid("1");
				}else{
					tmp.setUsertyperightid(rightid);
				}
				tmp.setUsertypename("ADMIN");
				nodeService.insertRightAuto(tmp);
			}
			
		}catch(Exception e){
			msg="����ʧ��!";
			e.printStackTrace();
		}
		return msg;
	}*/
	
	public String getNodeId(){
		return nodeService.getNodeId();
	}
	
	public String getUserTypeRightId(){
		return nodeService.getUserTypeRightId();
	}
	public String delete() throws IOException{
		getPubPro();
		String msg = "删除成功";
		pw = res.getWriter();
		try{
			nodeService.delete(StrUtil.nullToString(req.getParameter("nodeid")));
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
	public NodeService getNodeService() {
		return nodeService;
	}
	public void setNodeService(NodeService nodeService) {
		this.nodeService = nodeService;
	}


	

}
