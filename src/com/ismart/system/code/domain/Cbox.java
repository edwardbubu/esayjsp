package com.ismart.system.code.domain;

import java.io.Serializable;

public class Cbox implements Serializable {
	private String pid = "";
	private String id = "";
	private String name = "";
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
}
