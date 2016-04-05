package com.ismart.system.code.action;

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

import com.google.gson.Gson;
import com.ismart.system.code.domain.Code;
import com.ismart.system.code.domain.CodeType;
import com.ismart.system.code.service.CodeService;

public class CodeAction extends ActionSupport {

	private Code code ;
	private CodeType codeType ;
	//private Resource resource ;
	private List<Code> codes;
	private List<CodeType> codeTypes;
	private CodeService codeService;
	ActionContext context = null;  
	HttpServletRequest req = null;  
	HttpServletResponse res = null; 
	HttpSession session = null;
	PrintWriter pw = null;
	
	/*public String queryCodeTypeList() throws Exception {
		ArrayList  success = getQueryCodeTypeList();
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
	
	public ArrayList getQueryCodeTypeList() throws JSONException{
		ArrayList obj = new ArrayList();
		getPubPro();//��ȡ�����
		codeType = new CodeType();	
		obj = codeService.getCodeTypeList();
		return obj;
	}*/
	
	public String editCodeType() throws Exception {
		String success = codeType();
		pw = res.getWriter();
		try {
			pw.write(success);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public String deleteCodeType() throws Exception {
		
		String msg = "删除成功";
		String codeTypeId = req.getParameter("codetypeid");
		String codetypename = req.getParameter("codetypename");
		getPubPro();
		if(!"SUCCESS".equals(codeService.deleteCodeType(codeTypeId))){
			msg = "删除失败";
		}else{
			if(!"SUCCESS".equals(codeService.deleteCodeInfoByType(codetypename))){
				msg = "删除失败";
			}
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

	public String queryCodeType() throws Exception {
		ArrayList  success = getQueryCodeType();
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
	
	public String editCodeInfo() throws Exception {
		String success = codeInfo();
		pw = res.getWriter();
		try {
			pw.write(success);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public String deleteCodeInfo() throws Exception {
		
		String msg = "删除成功";
		getPubPro();
		if(!"SUCCESS".equals(codeService.delete(req.getParameter("codeid")))){
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

	public String queryCodeInfo() throws Exception {
		ArrayList  success = getQueryCodeInfo();
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
	
	public String getAuotIdFromCodeInfo(){
		return codeService.getAuotIdFromCodeInfo();
	}
	
	public String getAuotIdFromCodeType(){
		return codeService.getAuotIdFromCodeType();
	}

	public ArrayList getQueryCodeType() throws JSONException{
		ArrayList obj = new ArrayList();
		getPubPro();
		
		int crupage =Integer.parseInt(req.getParameter("page"));
		int row = Integer.parseInt(req.getParameter("rows"));//���ܲ���page��rows
		codeType = new CodeType();
		
		codeType.setCodetypeid(StrUtil.nullToString(req.getParameter("codetypeid")));
		codeType.setCodetypename(StrUtil.nullToString(req.getParameter("codetypename")));
		codeType.setCodetypecname(StrUtil.nullToString(req.getParameter("codetypecname")));
		obj = codeService.queryCodeType(codeType);
		return obj;
	}
	
	public String codeType(){
		
		String msg = "保存成功";
		try{
			getPubPro();//��ȡ�����
			res.setCharacterEncoding("UTF-8");
			if("".equals(req.getParameter("codetypeid"))){
				String maxId = getAuotIdFromCodeType();
				
				codeType = new CodeType();
				if("".equals(maxId)||maxId==null){
					codeType.setCodetypeid("1");
				}else{
					codeType.setCodetypeid(maxId);
				}
				codeType.setCodetypename(req.getParameter("codetypename"));
				codeType.setCodetypecname(req.getParameter("codetypecname"));
				codeService.insertCodeType(codeType);
			}else{
				codeType.setCodetypeid(req.getParameter("codetypeid"));
				codeType.setCodetypename(req.getParameter("codetypename"));
				codeType.setCodetypecname(req.getParameter("codetypecname"));
				codeService.editCodeType(codeType);
			}
			
		}catch(Exception e){
			msg="保存失败";
			e.printStackTrace();
		}
		return msg;
	}
	
	public ArrayList getQueryCodeInfo() throws JSONException{
		ArrayList obj = new ArrayList();
		getPubPro();
		
		//int crupage =Integer.parseInt(req.getParameter("page"));
		//int row = Integer.parseInt(req.getParameter("rows"));//���ܲ���page��rows
		code = new Code();
		
		code.setCodeid(StrUtil.nullToString(req.getParameter("codeid")));
		code.setCodetypename(StrUtil.nullToString(req.getParameter("codetypename")));
		code.setCodename(StrUtil.nullToString(req.getParameter("codename")));
		code.setCodecname(StrUtil.nullToString(req.getParameter("codecname")));
		obj = codeService.query(code);
		return obj;
	}
	
	public String codeInfo(){
		
		String msg = "保存成功";
		try{
			getPubPro();
			res.setCharacterEncoding("UTF-8");
			if("".equals(req.getParameter("codeid"))){
				String codeId = getAuotIdFromCodeInfo();
				
				code = new Code();
				if("".equals(codeId)||codeId==null){
					code.setCodeid("1");
				}else{
					code.setCodeid(codeId);
				}
				code.setCodetypename(req.getParameter("codetypename"));
				code.setCodename(req.getParameter("codename"));
				code.setCodecname(req.getParameter("codecname"));
				codeService.insert(code);
			}else{
				code.setCodeid(req.getParameter("codeid"));
				code.setCodetypename(req.getParameter("codetypename"));
				code.setCodename(req.getParameter("codename"));
				code.setCodecname(req.getParameter("codecname"));
				codeService.edit(code);
			}
			
		}catch(Exception e){
			msg="保存失败";
			e.printStackTrace();
		}
		return msg;
	}
	
	public void getPubPro(){
		context = ActionContext.getContext();
		req = (HttpServletRequest) context.get(ServletActionContext.HTTP_REQUEST); 
		res = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE); 
		session = req.getSession();//(ServletRequest) context.getSession();		
	}

	public CodeService getCodeService() {
		return codeService;
	}

	public void setCodeService(CodeService codeService) {
		this.codeService = codeService;
	}

	

}
