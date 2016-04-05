package com.ismart.system.code.serviceImp;

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
import com.ismart.system.code.domain.Cbox;
import com.ismart.system.code.domain.CodeType;
import com.ismart.system.code.domain.Code;
import com.ismart.system.code.service.CboxService;
//import com.sp.system.tree.model.Tree;
//import com.sp.system.tree.service.TreeService;

public class CboxServiceImp extends SqlMapClientDaoSupport implements
		CboxService {
	SqlMapClient sqlMap;
	private CodeType codeType ;
	private Code code ;

	// dict query
	public ArrayList query(Cbox cb) throws JSONException {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		ArrayList al = new ArrayList();
		// m.put("page", page);
		List set = st.queryForList("cbQuery", cb);// st.queryForObject("getLoginInfo",dict);
		for (int i = 0; i < set.size(); i++) {
			code = (Code) set.get(i);
			Map hm = new HashMap();
			hm.put("pid", code.getCodetypename());
			hm.put("id", code.getCodename());
			hm.put("name", code.getCodecname());
			al.add(hm);
		}

		return al;
	}
	public ArrayList queryType() throws JSONException {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		ArrayList al = new ArrayList();
		// m.put("page", page);
		List set = st.queryForList("typeQuery");// st.queryForObject("getLoginInfo",dict);
		for (int i = 0; i < set.size(); i++) {
			codeType = (CodeType) set.get(i);
			Map hm = new HashMap();
			hm.put("pid", codeType.getCodetypeid());
			hm.put("id", codeType.getCodetypename());
			hm.put("name", codeType.getCodetypecname());
			al.add(hm);
		}
		
		return al;
	}

}
