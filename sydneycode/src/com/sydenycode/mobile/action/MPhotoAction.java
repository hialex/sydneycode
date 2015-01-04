package com.sydenycode.mobile.action;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import com.opensymphony.xwork2.ActionSupport;
import com.sydenycode.impl.PhotoCategoryImpl;
import com.sydenycode.impl.PhotoImpl;
import com.sydenycode.po.Photo;
import com.sydenycode.po.PhotoCategory;
import com.sydenycode.util.CONSTANT;
import com.sydenycode.util.DateJsonValueProcessor;

public class MPhotoAction extends ActionSupport{

	/** serialVersionUID*/
	private static final long serialVersionUID = -1142833927009270928L;
	
	private JSONObject result;//返回的json
    Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map
    
    private String shop_id;
    private String root_catalog_id;
    
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

	public String getShop_id() {
		return shop_id;
	}

	public void setShop_id(String shopId) {
		shop_id = shopId;
	}

	public String getRoot_catalog_id() {
		return root_catalog_id;
	}

	public void setRoot_catalog_id(String rootCatalogId) {
		root_catalog_id = rootCatalogId;
	}

	public String list(){
		Map<String, Object> tempMap = new HashMap<String, Object>();//定义map
		List<PhotoCategory> categories = PhotoCategoryImpl.queryPhotoCategoryByCatalogId(root_catalog_id);
		tempMap.put("category", categories);
		for (PhotoCategory category : categories) {
			List<Photo> fans_photos = PhotoImpl.getPhotosByShopIdAndCategoryId(shop_id, String.valueOf(category.getId()),CONSTANT.FANSUPLOADPHOTOS);
			List<Photo> official_photos = PhotoImpl.getPhotosByShopIdAndCategoryId(shop_id, String.valueOf(category.getId()),CONSTANT.OFFICIALPHOTOS);
			tempMap.put("fans_"+category.getId(), fans_photos);
			tempMap.put("official_"+category.getId(), official_photos);
		}
		JsonConfig config = new JsonConfig();
		config.registerJsonValueProcessor(Timestamp.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		result = JSONObject.fromObject(tempMap,config);//格式化result   一定要是JSONObject 
		return SUCCESS;
	}
}
