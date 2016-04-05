package com.ismart.system.node.serviceImp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ismart.common.json.JSONException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ismart.system.node.domain.Node;
import com.ismart.system.node.service.NodeService;
import com.ismart.system.user.domain.RoleNode;

public class NodeServiceImp extends SqlMapClientDaoSupport implements
NodeService {
	SqlMapClient sqlMap;

	// resource query
	public ArrayList query(Node node) throws JSONException {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		ArrayList al = new ArrayList();
		//m.put("page", page);
		List set = st.queryForList("nodeQuery", node);// st.queryForObject("getLoginInfo",resource);
		for (int i = 0; i < set.size(); i++) {
			node = (Node) set.get(i);
			Map hm = new HashMap();
			hm.put("nodeid", node.getNodeid());
			hm.put("pid", node.getPid());
			hm.put("nodename", node.getNodename());
			hm.put("level", node.getLevel());
			hm.put("spurl", node.getSpurl());
			hm.put("sporder", node.getSporder());
			al.add(hm);
		}

		return al;
	}
	// resource query
	public ArrayList queryTree(Node node) throws JSONException {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		ArrayList al = new ArrayList();
		//m.put("page", page);
		List set = st.queryForList("nodeQuery", node);// st.queryForObject("getLoginInfo",resource);
		for (int i = 0; i < set.size(); i++) {
			node = (Node) set.get(i);
			Map hm = new HashMap();
			hm.put("id", node.getNodeid());
			hm.put("pid", node.getPid());
			hm.put("value", node.getNodename());
			hm.put("level", node.getLevel());
			hm.put("spurl", node.getSpurl());
			hm.put("sporder", node.getSporder());
			al.add(hm);
		}
		
		return al;
	}
	

	public void insert(Node node) {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		st.insert("insertNode", node);
	}
	public void insertRightAuto(RoleNode roleNode) {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		st.insert("insertRoleNode", roleNode);
	}
	public void edit(Node node) {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		st.update("updateNode",node);
	}
	public void delete(String nodeid) {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		st.delete("deleteNode",nodeid);// st.queryForObject("getLoginInfo",user);
	}

	// ��ȡ�������ID
	public String getNodeId() {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		String maxId = (String) st.queryForObject("getNodeId");
		return maxId;
	}
	
	// ��ȡ�������ID
	public String getUserTypeRightId() {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		String maxId = (String) st.queryForObject("getAuotIdFromRoleNode");
		return maxId;
	}
	
	public void setSqlMap(SqlMapClient sqlMap) {
		this.sqlMap = sqlMap;
	}

	public SqlMapClient getSqlMap() {
		return sqlMap;
	}

}
