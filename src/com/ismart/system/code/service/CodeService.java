package com.ismart.system.code.service;

import java.util.ArrayList;
import java.util.Map;

import com.ismart.common.json.JSONException;
import com.ismart.system.code.domain.Code;
import com.ismart.system.code.domain.CodeType;

public interface CodeService {
	public void insert(Code u);
	public void edit(Code u);
	public void insertCodeType(CodeType u);
	public void editCodeType(CodeType u);
	public String getAuotIdFromCodeInfo();
	public String getAuotIdFromCodeType();
	public ArrayList query(Code user) throws JSONException;
	public ArrayList queryCodeType(CodeType code) throws JSONException;
	public String delete(String codeId); 
	public String deleteCodeType(String codeTypeId);
	public String deleteCodeInfoByType(String codetypename);
}
