package com.ismart.common.util;

public class StrUtil {
	public static String nullToString(Object val) {
		if (val == null) {
			val = "";
		} else if(val.toString().equals(" ")) {
            val = "";
        } //sts
		return val.toString();
	}
}
