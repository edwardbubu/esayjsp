package com.ismart.finance.supply.serviceImp;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ismart.common.json.JSONException;
import com.ismart.common.json.JSONObject;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ismart.finance.supply.domain.Supply;
import com.ismart.finance.supply.service.SupplyService;

public class SupplyServiceImp extends SqlMapClientDaoSupport implements
       SupplyService {
	SqlMapClient sqlMap;

	// ע��
	public void insert(Supply c) {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		st.insert("insertSupply", c);
	}
	public void edit(Supply u) {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		st.update("updateSupply", u);
	}

	// �û���Ϣ�б��ѯ
	public ArrayList query(Supply supply) throws JSONException {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		ArrayList al = new ArrayList();
		//m.put("page", page);
		List set = st.queryForList("QuerySupplyInfo", supply);// st.queryForObject("getLoginInfo",user);
		for (int i = 0; i < set.size(); i++) {
			supply = (Supply) set.get(i);
			Map hm = new HashMap();
			hm.put("supplypenid", supply.getSupplypenid());
			hm.put("supplypename", supply.getSupplypename());
			hm.put("supplyorgname", supply.getSupplyorgname());
			hm.put("supplypenphone", supply.getSupplypenphone());
			hm.put("supplypenemail", supply.getSupplypenemail());
			hm.put("supplypenqq", supply.getSupplypenqq());
			hm.put("supplypenweixin", supply.getSupplypenweixin());
			hm.put("supplypenadd", supply.getSupplypenadd());
			hm.put("supplypensadd", supply.getSupplypensadd());
			hm.put("supplypenfadd", supply.getSupplypenfadd());
			hm.put("supplypentype", supply.getSupplypentype());
			hm.put("supplypenlink", supply.getSupplypenlink());
			hm.put("supplypentext", supply.getSupplypentext());	
			al.add(hm);
		}

		return al;
	}

	// ��ȡ�������ID
	public String getSupplyId() {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		String maxId = (String) st.queryForObject("getSupplyId");
		return maxId;
	}

	public String delete(String supplypenid) {
		try{
			SqlMapClientTemplate st = super.getSqlMapClientTemplate();
			st.delete("deleteSupply",supplypenid);// st.queryForObject("getLoginInfo",user);
		}catch(Exception e){
			return e.getMessage();
		}
		return "SUCCESS";
	}
	
	public void setSqlMap(SqlMapClient sqlMap) {
		this.sqlMap = sqlMap;
	}

	public SqlMapClient getSqlMap() {
		return sqlMap;
	}

	


//	public static void main(String args[]) throws Exception {
//		ApplicationContext ctx = new ClassPathXmlApplicationContext(
//				"applicationContext.xml");
//		UserServiceImp ul = (UserServiceImp) ctx.getBean("pageservices");
//
//		User user = new User();
//		Page page = new Page();
//		try {
//			System.out.println(ul.query(user, page).getJSONArray("data")
//					.toString());
//		} catch (JSONException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			// }
//
//		}
//	}
}
