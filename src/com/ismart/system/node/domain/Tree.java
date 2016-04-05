package com.ismart.system.node.domain;

import java.io.InputStream;
import java.io.Serializable;
import java.sql.Blob;

public class Tree implements Serializable {
	private String id = "";
	private String pid = "";
	private String value = "";
	private String level = "";
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
}
