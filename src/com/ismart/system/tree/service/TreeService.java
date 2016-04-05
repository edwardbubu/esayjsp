package com.ismart.system.tree.service;

import java.util.ArrayList;
import com.ismart.common.json.JSONException;
import com.ismart.system.node.domain.Node;

public interface TreeService {
	public ArrayList nodeTree(Node node) throws JSONException;
}
