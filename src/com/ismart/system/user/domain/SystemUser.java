package com.ismart.system.user.domain;

import java.io.InputStream;
import java.io.Serializable;
import java.sql.Blob;

public class SystemUser implements Serializable {
	private String userid = "";
	private String username= "";
	private String loginname= "";
	private String password= "";
	private String createdate= "";
	private String lastupdatedate= "";
	private String disabledate= "";
	private String usertype= "";
	
	public String getLastupdatedate() {
		return lastupdatedate;
	}
	public void setLastupdatedate(String lastupdatedate) {
		this.lastupdatedate = lastupdatedate;
	}
	public String getDisabledate() {
		return disabledate;
	}
	public void setDisabledate(String disabledate) {
		this.disabledate = disabledate;
	}
	public String getUsertype() {
		return usertype;
	}
	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getLoginname() {
		return loginname;
	}
	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}
}
