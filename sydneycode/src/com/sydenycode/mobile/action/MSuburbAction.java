package com.sydenycode.mobile.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.sydenycode.impl.SuburbImpl;
import com.sydenycode.po.Suburb;

public class MSuburbAction extends ActionSupport {

	/** serialVersionUID*/
	private static final long serialVersionUID = 3134050734480829319L;
	
	private JSONObject result;//返回的json
    Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
	
    
    
	public JSONObject getResult() {
		return result;
	}



	public void setResult(JSONObject result) {
		this.result = result;
	}



	public Map<String, Object> getJsonMap() {
		return jsonMap;
	}



	public void setJsonMap(Map<String, Object> jsonMap) {
		this.jsonMap = jsonMap;
	}



	public String list(){
		Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	List<Suburb> list = SuburbImpl.queryAllSuburbs();
    	tempMap.put("all", list);
    	result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject
    	return SUCCESS;
	}
	

}
