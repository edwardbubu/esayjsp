package com.ismart.system.user.domain;

import java.io.InputStream;
import java.io.Serializable;
import java.sql.Blob;

public class RoleNode implements Serializable {	
	private String rolenodeid = "";
	private String nodeid= "";
	private String usertypename= "";
	public String getRolenodeid() {
		return rolenodeid;
	}
	public void setRolenodeid(String rolenodeid) {
		this.rolenodeid = rolenodeid;
	}
	public String getNodeid() {
		return nodeid;
	}
	public void setNodeid(String nodeid) {
		this.nodeid = nodeid;
	}
	public String getUsertypename() {
		return usertypename;
	}
	public void setUsertypename(String usertypename) {
		this.usertypename = usertypename;
	}
	
}
