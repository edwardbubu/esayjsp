package com.ismart.finance.supply.action;

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

import com.ismart.finance.supply.domain.Supply;
import com.ismart.finance.supply.service.SupplyService;

public class SupplyAction extends ActionSupport {

	private Supply supplier ;
	//private Resource resource ;
	private List<Supply> suppliers;
	private SupplyService supplyService;
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
		if(!"SUCCESS".equals(supplyService.delete(req.getParameter("sysuserid")))){
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

	public String getSupplyId(){
		return supplyService.getSupplyId();
	}
	
	public ArrayList getQuery() throws JSONException{
		ArrayList obj = new ArrayList();
		getPubPro();
		
		int crupage =Integer.parseInt(req.getParameter("page"));
		int row = Integer.parseInt(req.getParameter("rows"));
		supplier = new Supply();
		
		/*supplier.setLoginname(StrUtil.nullToString(req.getParameter("qloginname")));
		supplier.setUsername(StrUtil.nullToString(req.getParameter("qusername")));
		supplier.setPassword(StrUtil.nullToString(req.getParameter("qpassword")));
		supplier.setUsertype(StrUtil.nullToString(req.getParameter("qusertype")));
		supplier.setDisabledate(StrUtil.nullToString(req.getParameter("qdisabledate")));*/
		obj = supplyService.query(supplier);
		return obj;
	}
	
	public String userEdit(){
		
		String msg = "保存成功";
		try{
			getPubPro();
			res.setCharacterEncoding("UTF-8");
			if("".equals(req.getParameter("supplypenid"))){
				String userId = getSupplyId();
				
				supplier = new Supply();
				if("".equals(userId)||userId==null){
					supplier.setSupplypenid("1");
				}else{
					supplier.setSupplypenid(userId);
				}
				supplier.setSupplypename(req.getParameter("supplypename"));
				supplier.setSupplyorgname(req.getParameter("supplyorgname"));
				supplier.setSupplypenphone(req.getParameter("supplypenphone"));
				supplier.setSupplypenemail(req.getParameter("supplypenemail"));
				supplier.setSupplypenqq(req.getParameter("supplypenqq"));
				supplier.setSupplypenweixin(req.getParameter("supplypenweixin"));
				supplier.setSupplypensadd(req.getParameter("supplypensadd"));
				supplier.setSupplypenfadd(req.getParameter("supplypenfadd"));
				supplier.setSupplypenadd(req.getParameter("supplypenadd"));
				supplier.setSupplypentype(req.getParameter("supplypentype"));
				supplier.setSupplypenlink(req.getParameter("supplypenlink"));
				supplier.setSupplypentext(req.getParameter("supplypentext"));
				supplyService.insert(supplier);
			}else{
				supplier.setSupplypenid(req.getParameter("supplypenid"));
				supplier.setSupplypename(req.getParameter("supplypename"));
				supplier.setSupplyorgname(req.getParameter("supplyorgname"));
				supplier.setSupplypenphone(req.getParameter("supplypenphone"));
				supplier.setSupplypenemail(req.getParameter("supplypenemail"));
				supplier.setSupplypenqq(req.getParameter("supplypenqq"));
				supplier.setSupplypenweixin(req.getParameter("supplypenweixin"));
				supplier.setSupplypensadd(req.getParameter("supplypensadd"));
				supplier.setSupplypenfadd(req.getParameter("supplypenfadd"));
				supplier.setSupplypenadd(req.getParameter("supplypenadd"));
				supplier.setSupplypentype(req.getParameter("supplypentype"));
				supplier.setSupplypenlink(req.getParameter("supplypenlink"));
				supplier.setSupplypentext(req.getParameter("supplypentext"));
				supplyService.edit(supplier);
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

	public SupplyService getSysuserService() {
		return supplyService;
	}

	public void setSysuserService(SupplyService supplyService) {
		this.supplyService = supplyService;
	}

	

}
