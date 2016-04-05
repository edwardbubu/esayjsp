package com.ismart.system.node.service;

import java.util.ArrayList;
import java.util.Map;

import com.ismart.common.json.JSONException;

import com.ismart.system.node.domain.Node;
import com.ismart.system.user.domain.RoleNode;

public interface NodeService {
	public ArrayList query(Node node) throws JSONException;
	public ArrayList queryTree(Node node) throws JSONException;
	public String getNodeId();
	public String getUserTypeRightId();
	public void edit(Node node);
	public void insert(Node node);
	public void insertRightAuto(RoleNode roleNode);
	public void delete(String nodeid);
	
}