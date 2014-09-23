package com.sydenycode.mobile.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import com.opensymphony.xwork2.ActionSupport;
import com.sydenycode.mobile.dto.MSearchResutlShopDTO;
import com.sydenycode.mobile.impl.MSearchImpl;
import com.sydenycode.po.Catalog;

public class MSearchAction extends ActionSupport {

	/** serialVersionUID*/
	private static final long serialVersionUID = 4946409021912039226L;
	
	private String catalog1;
	private String catalog2;
	private String suburb;
	private String bh;
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


	public String getCatalog1() {
		return catalog1;
	}


	public void setCatalog1(String catalog1) {
		this.catalog1 = catalog1;
	}


	public String getCatalog2() {
		return catalog2;
	}


	public void setCatalog2(String catalog2) {
		this.catalog2 = catalog2;
	}


	public String getSuburb() {
		return suburb;
	}


	public void setSuburb(String suburb) {
		this.suburb = suburb;
	}


	public String getBh() {
		return bh;
	}


	public void setBh(String bh) {
		this.bh = bh;
	}


	@Override
	public String execute() throws Exception {
		Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	List<MSearchResutlShopDTO> list = new MSearchImpl().getSearchResultShops(catalog1, catalog2, suburb, bh);
    	tempMap.put("all", list);
    	JsonConfig config = new JsonConfig();
    	config.registerPropertyExclusions(Catalog.class, new String[]{"parent_id"});
    	result = JSONObject.fromObject(tempMap,config);//格式化result   一定要是JSONObject
    	return SUCCESS;
		
	}
	
	
}
