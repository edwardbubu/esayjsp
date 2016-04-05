package com.ismart.system.tree.serviceImp;

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
import com.ismart.system.node.domain.Node;
import com.ismart.system.tree.service.TreeService;

public class TreeServiceImp extends SqlMapClientDaoSupport implements
		TreeService {
	SqlMapClient sqlMap;

	// tree query
	public ArrayList nodeTree(Node node) throws JSONException {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		ArrayList al = new ArrayList();
		//m.put("page", page);
		List set = st.queryForList("nodeTree", node);// st.queryForObject("getLoginInfo",tree);
		for (int i = 0; i < set.size(); i++) {
			node = (Node) set.get(i);
			Map hm = new HashMap();
			hm.put("name", node.getNodename());
			hm.put("pid", node.getPid());
			hm.put("id", node.getNodeid());
			al.add(hm);
		}

		return al;
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
//		treeServiceImp ul = (treeServiceImp) ctx.getBean("pageservices");
//
//		tree tree = new tree();
//		Page page = new Page();
//		try {
//			System.out.println(ul.query(tree, page).getJSONArray("data")
//					.toString());
//		} catch (JSONException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			// }
//
//		}
//	}
}
