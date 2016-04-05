package com.ismart.system.user.service;

import java.util.ArrayList;
import java.util.Map;

import com.ismart.common.json.JSONException;
import com.ismart.system.user.domain.RoleNode;

public interface RoleService {
	public void insert(RoleNode u);
	public void edit(RoleNode u);
	public String getRoleId();
	public ArrayList query(RoleNode role) throws JSONException;
	public String delete(String rolenodeid); 
}
