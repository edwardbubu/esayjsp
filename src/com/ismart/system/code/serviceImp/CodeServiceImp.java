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
import com.ismart.system.code.domain.Code;
import com.ismart.system.code.domain.CodeType;
import com.ismart.system.code.service.CodeService;

public class CodeServiceImp extends SqlMapClientDaoSupport implements
    CodeService {
	SqlMapClient sqlMap;
	private CodeType codeType ;
	// ע��
	public void insert(Code c) {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		st.insert("insertCode", c);
	}
	public void edit(Code u) {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		st.update("updateCode",u);
	}
	
	public void insertCodeType(CodeType c) {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		st.insert("insertCodeType", c);
	}
	public void editCodeType(CodeType u) {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		st.update("updateCodeType",u);
	}


	// �û���Ϣ�б��ѯ
	public ArrayList query(Code code) throws JSONException {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		ArrayList al = new ArrayList();
		//m.put("page", page);
		List set = st.queryForList("queryCodeInfo", code);// st.queryForObject("getLoginInfo",user);
		for (int i = 0; i < set.size(); i++) {
			code = (Code) set.get(i);
			Map hm = new HashMap();
			hm.put("codeid", code.getCodeid());
			hm.put("codetypename", code.getCodetypename());
			hm.put("codename", code.getCodename());
			hm.put("codecname", code.getCodecname());
			al.add(hm);
		}

		return al;
	}
	
	// �û���Ϣ�б��ѯ
	public ArrayList queryCodeType(CodeType code) throws JSONException {
			SqlMapClientTemplate st = super.getSqlMapClientTemplate();
			ArrayList al = new ArrayList();
			//m.put("page", page);
			List set = st.queryForList("queryCodeType", code);// st.queryForObject("getLoginInfo",user);
			for (int i = 0; i < set.size(); i++) {
				code = (CodeType) set.get(i);
				Map hm = new HashMap();
				hm.put("codetypeid", code.getCodetypeid());
				hm.put("codetypename", code.getCodetypename());
				hm.put("codetypecname", code.getCodetypecname());
				al.add(hm);
			}

			return al;
	}

	// ��ȡ�������ID
	public String getAuotIdFromCodeInfo() {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		String maxId = (String) st.queryForObject("getAuotIdFromCodeInfo");
		return maxId;
	}
	// ��ȡ�������ID
	public String getAuotIdFromCodeType() {
		SqlMapClientTemplate st = super.getSqlMapClientTemplate();
		String maxId = (String) st.queryForObject("getAuotIdFromCodeType");
		return maxId;
	}

	public String delete(String codeid) {
		try{
			SqlMapClientTemplate st = super.getSqlMapClientTemplate();
			st.delete("deleteCode",codeid);// st.queryForObject("getLoginInfo",user);
		}catch(Exception e){
			return e.getMessage();
		}
		return "SUCCESS";
	}
	public String deleteCodeType(String codetypeid) {
		try{
			SqlMapClientTemplate st = super.getSqlMapClientTemplate();
			st.delete("deleteCodeType",codetypeid);// st.queryForObject("getLoginInfo",user);
			//st.delete("deleteCodeInfoByType",codetypeid);// st.queryForObject("getLoginInfo",user);
		}catch(Exception e){
			return e.getMessage();
		}
		return "SUCCESS";
	}
	public String deleteCodeInfoByType(String codetypename) {
		try{
			SqlMapClientTemplate st = super.getSqlMapClientTemplate();
			//st.delete("deleteCodeType",codetypeid);// st.queryForObject("getLoginInfo",user);
			st.delete("deleteCodeInfoByType",codetypename);// st.queryForObject("getLoginInfo",user);
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
