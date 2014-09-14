package com.sydenycode.util;

import net.sf.json.JSONObject;

public class JSONUtil {
    
    public static String toJson(Object o) {
        JSONObject jsonObject = JSONObject.fromObject( o ); 
        return jsonObject.toString();
    }
}
