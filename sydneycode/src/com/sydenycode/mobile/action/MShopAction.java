package com.sydenycode.mobile.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

import com.opensymphony.xwork2.ActionSupport;
import com.sydenycode.impl.Bussiness_hourImpl;
import com.sydenycode.impl.PicImpl;
import com.sydenycode.impl.ShopImpl;
import com.sydenycode.impl.Shop_catalogImpl;
import com.sydenycode.po.Bussiness_hour;
import com.sydenycode.po.Catalog;
import com.sydenycode.po.Pic;
import com.sydenycode.po.Shop;

public class MShopAction extends ActionSupport{

	/** serialVersionUID*/
	private static final long serialVersionUID = 6499178417059349581L;
	private JSONObject result;//返回的json
    Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
    
    
    private String id;
    
    public Map<String, Object> getJsonMap() {
		return jsonMap;
	}


	public void setJsonMap(Map<String, Object> jsonMap) {
		this.jsonMap = jsonMap;
	}

	public JSONObject getResult() {
		return result;
	}
	
	public void setResult(JSONObject result) {
		this.result = result;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	/**
     * 查看商铺详细信息
     * @return
     */
    public String show(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map
        Shop shop = ShopImpl.getShopById(id);
        //System.out.println(shop.getName());
        ArrayList<Bussiness_hour> bussiness_hours_list = (ArrayList<Bussiness_hour>) Bussiness_hourImpl.getBussinessHourById(id);
        ArrayList<Pic> pics = (ArrayList<Pic>) PicImpl.getPicsById(id);
        ArrayList<Catalog> catalog_names_list = (ArrayList<Catalog>) Shop_catalogImpl.getCatalogNames(id);
    	tempMap.put("shop", shop);
    	tempMap.put("bussiness_hours", bussiness_hours_list);
    	tempMap.put("pics", pics);
    	tempMap.put("catalog_names", catalog_names_list);
    	JsonConfig config = new JsonConfig();
    	config.registerPropertyExclusions(Shop.class, new String[]{"add_time"});
    	config.registerPropertyExclusions(Catalog.class, new String[]{"parent_id"});
    	config.registerJsonValueProcessor(java.sql.Time.class, new JsonValueProcessor() {
			private SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
			public Object processObjectValue(String key, Object value, JsonConfig config) {
				// TODO Auto-generated method stub
				return value==null?"":sdf.format(value);
			}
			
			public Object processArrayValue(Object value, JsonConfig config) {
				// TODO Auto-generated method stub
				return null;
			}
		});
    	result = JSONObject.fromObject(tempMap,config);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }

    
	
}
