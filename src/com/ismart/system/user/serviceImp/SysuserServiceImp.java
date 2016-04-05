package com.ismart.system.user.serviceImp;

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
import com.ismart.system.user.domain.SystemUser;
import com.ismart.system.node.domain.Node;
import com.ismart.system.user.service.SysuserService;

public class SysuserServiceImp extends SqlMapClientDaoSupport implements
		SysuserService {
	SqlMapClient sqlMap;
	Node node = new Node();

	// ע��
	public void insert(SystemUser c) {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		st.insert("insertUser11", c);
	}
	public void edit(SystemUser u) {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		st.update("updateUser11",u);
	}
	// ��½��ȡ�û���Ϣ
	public SystemUser LoginInfo(SystemUser sysUser) {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		List set = st.queryForList("getLoginInfo11", sysUser);// st.queryForObject("getLoginInfo",user);
		if(set.size()>0){
			sysUser = (SystemUser) set.get(0);
		}else{
			sysUser = new SystemUser();
		}
		return sysUser;
	}

	// �û���Ϣ�б��ѯ
	public ArrayList query(SystemUser user) throws JSONException {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		ArrayList al = new ArrayList();
		//m.put("page", page);
		List set = st.queryForList("getQuery11", user);// st.queryForObject("getLoginInfo",user);
		for (int i = 0; i < set.size(); i++) {
			user = (SystemUser) set.get(i);
			Map hm = new HashMap();
			hm.put("userid", user.getUserid());
			hm.put("username", user.getUsername());
			hm.put("loginname", user.getLoginname());
			hm.put("password", user.getPassword());
			hm.put("createdate", user.getCreatedate());
			hm.put("lastupdatedate", user.getLastupdatedate());
			hm.put("usertype", user.getUsertype());
			hm.put("disabledate", user.getDisabledate());
			al.add(hm);
		}

		return al;
	}

	// ��ȡ�������ID
	public String getUserId() {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		String maxId = (String) st.queryForObject("getUserId11");
		return maxId;
	}

	public String delete(String userid) {
		try{
			SqlMapClientTemplate st = super.getSqlMapClientTemplate();
			st.delete("deleteUser11",userid);// st.queryForObject("getLoginInfo",user);
		}catch(Exception e){
			return e.getMessage();
		}
		return "SUCCESS";
	}
	
	public Map getNavigation(SystemUser user) {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		StringBuffer al = new StringBuffer();
		Map mp = new HashMap();
		List set = st.queryForList("navigation11", user);// st.queryForObject("getLoginInfo",resource);
		List set1 = new ArrayList();
		List set2 = new ArrayList();
//		Resource r1 = new Resource();
//		Resource r2 = new Resource();
		for (int i = 0; i < set.size(); i++) {
			node = (Node) set.get(i);
			if("1".equals(node.getLevel())){
				set1.add(node);
			}else if("2".equals(node.getLevel())){
				set2.add(node);
			}
		}
		mp.put("set1", set1);
		mp.put("set2", set2);
//		for(int j = 0;j <set1.size();j++){
//			r1 = (Resource) set1.get(j);
//			al.append("<div title='"+r1.getValue()+"'>");
//			for(int k = 0;k <set2.size();k++){
//				r2 = (Resource) set2.get(k);
//				if(r1.getId().equals(r2.getPid())){
//					al.append("<p>"
//								+ "<a href='javascript:void(0);' src='"+r2.getSpurl()+"'"
//								+ "class='cs-navi-tab'>"+r2.getValue()+"</a>"
//							    + "</p>");
//				}
//			}
//			al.append("</div>");
//		}
//		System.out.println(al);
		return mp;
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
