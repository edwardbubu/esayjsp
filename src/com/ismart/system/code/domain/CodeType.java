package com.ismart.system.code.domain;

import java.io.InputStream;
import java.io.Serializable;
import java.sql.Blob;

public class CodeType implements Serializable {
	private String codetypeid = "";
	private String codetypename= "";
	private String codetypecname= "";
	
	public String getCodetypeid() {
		return codetypeid;
	}
	public void setCodetypeid(String codetypeid) {
		this.codetypeid = codetypeid;
	}
	public String getCodetypename() {
		return codetypename;
	}
	public void setCodetypename(String codetypename) {
		this.codetypename = codetypename;
	}
	public String getCodetypecname() {
		return codetypecname;
	}
	public void setCodetypecname(String codetypecname) {
		this.codetypecname = codetypecname;
	}
	
}
