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
import com.ismart.system.user.domain.RoleNode;
import com.ismart.system.user.service.RoleService;

public class RoleServiceImp extends SqlMapClientDaoSupport implements
     RoleService {
	SqlMapClient sqlMap;

	// ע��
	public void insert(RoleNode c) {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		st.insert("insertRoleNode", c);
	}
	public void edit(RoleNode u) {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		st.update("updateRoleNode",u);
	}

	// �û���Ϣ�б��ѯ
	public ArrayList query(RoleNode role) throws JSONException {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		ArrayList al = new ArrayList();
		//m.put("page", page);
		List set = st.queryForList("queryRoleNode", role);
		for (int i = 0; i < set.size(); i++) {
			role = (RoleNode) set.get(i);
			Map hm = new HashMap();
			hm.put("nodeid", role.getNodeid());
			hm.put("rolenodeid", role.getRolenodeid());
			hm.put("usertypename", role.getUsertypename());
			al.add(hm);
		}

		return al;
	}

	// ��ȡ�������ID
	public String getRoleId() {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		String maxId = (String) st.queryForObject("getAuotIdFromRoleNode");
		return maxId;
	}

	public String delete(String rolenodeid) {
		try{
			SqlMapClientTemplate st = super.getSqlMapClientTemplate();
			st.delete("deleteRoleNode",rolenodeid);// st.queryForObject("getLoginInfo",user);
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

}
