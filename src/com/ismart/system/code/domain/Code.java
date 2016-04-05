package com.ismart.system.code.domain;

import java.io.InputStream;
import java.io.Serializable;
import java.sql.Blob;

public class Code implements Serializable {	
	private String codeid = "";
	private String codetypename= "";
	private String codename= "";
	private String codecname= "";
	
	public String getCodeid() {
		return codeid;
	}
	public void setCodeid(String codeid) {
		this.codeid = codeid;
	}
	public String getCodetypename() {
		return codetypename;
	}
	public void setCodetypename(String codetypename) {
		this.codetypename = codetypename;
	}
	public String getCodename() {
		return codename;
	}
	public void setCodename(String codename) {
		this.codename = codename;
	}
	public String getCodecname() {
		return codecname;
	}
	public void setCodecname(String codecname) {
		this.codecname = codecname;
	}
	

}
