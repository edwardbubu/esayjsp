package com.ismart.system.code.domain;

import java.io.Serializable;

public class Cref implements Serializable {
	private String pid = " ";
	private String zid = " ";
	private String bname = " ";
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getZid() {
		return zid;
	}
	public void setZid(String zid) {
		this.zid = zid;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	
}
