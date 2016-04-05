package com.ismart.finance.supply.service;

import java.util.ArrayList;
import java.util.Map;

import com.ismart.common.json.JSONException;
import com.ismart.finance.supply.domain.Supply;


public interface SupplyService {
	public void insert(Supply u);
	public void edit(Supply u);
	public String getSupplyId();
	public ArrayList query(Supply u) throws JSONException;
	public String delete(String userId); 
}
