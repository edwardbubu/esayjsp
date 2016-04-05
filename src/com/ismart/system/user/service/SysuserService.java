package com.ismart.system.user.service;

import java.util.ArrayList;
import java.util.Map;

import com.ismart.common.json.JSONException;
import com.ismart.system.user.domain.SystemUser;



public interface SysuserService {
	public void insert(SystemUser u);
	public void edit(SystemUser u);
	public String getUserId();
	public SystemUser LoginInfo(SystemUser user);
	public ArrayList query(SystemUser user) throws JSONException;
	public String delete(String userId); 
	public Map getNavigation(SystemUser user);
}
