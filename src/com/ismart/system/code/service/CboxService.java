package com.ismart.system.code.service;

import java.util.ArrayList;
import com.ismart.common.json.JSONException;

import com.ismart.system.code.domain.Cbox;

public interface CboxService {
	public ArrayList query(Cbox cb) throws JSONException;
	public ArrayList queryType() throws JSONException;
} 