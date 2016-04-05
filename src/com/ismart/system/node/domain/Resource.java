package com.ismart.system.node.domain;

import java.io.Serializable;

public class Resource implements Serializable {
	private String usertyperightid = "";
	private String nodename = "";
	private String usertypename = "";
	public String getUsertyperightid() {
		return usertyperightid;
	}
	public void setUsertyperightid(String usertyperightid) {
		this.usertyperightid = usertyperightid;
	}
	public String getNodename() {
		return nodename;
	}
	public void setNodename(String nodename) {
		this.nodename = nodename;
	}
	public String getUsertypename() {
		return usertypename;
	}
	public void setUsertypename(String usertypename) {
		this.usertypename = usertypename;
	}
	
}
