package com.ismart.system.node.domain;

import java.io.Serializable;

public class Node implements Serializable {
	private String nodeid = "";
	private String pid = "";
	private String nodename = "";
	private String level = "";
	private String spurl = "";
	private String sporder = "";
	
	
	public String getNodeid() {
		return nodeid;
	}
	public void setNodeid(String nodeid) {
		this.nodeid = nodeid;
	}
	public String getNodename() {
		return nodename;
	}
	public void setNodename(String nodename) {
		this.nodename = nodename;
	}
	public String getSpurl() {
		return spurl;
	}
	public void setSpurl(String spurl) {
		this.spurl = spurl;
	}
	public String getSporder() {
		return sporder;
	}
	public void setSporder(String sporder) {
		this.sporder = sporder;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
}
