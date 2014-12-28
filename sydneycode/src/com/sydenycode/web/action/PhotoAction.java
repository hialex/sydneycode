package com.sydenycode.web.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.sydenycode.dto.PhotoDTO;
import com.sydenycode.impl.PhotoDTOImpl;
import com.sydenycode.impl.PhotoImpl;
import com.sydenycode.po.Photo;

public class PhotoAction extends ActionSupport {

	
	/** serialVersionUID*/
	private static final long serialVersionUID = 118938482575344768L;
	private JSONObject result;//返回的json
    Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
    private String shop_id;
    private String category_id;

	int status;
    String message;
	
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public JSONObject getResult() {
		return result;
	}

	public void setResult(JSONObject result) {
		this.result = result;
	}


	public Map<String, Object> getJsonMap() {
		return jsonMap;
	}
	
    public String getShop_id() {
		return shop_id;
	}

	public void setShop_id(String shopId) {
		shop_id = shopId;
	}

	public String getCategory_id() {
		return category_id;
	}

	public void setCategory_id(String categoryId) {
		category_id = categoryId;
	}

    
    /**
     * 根据shop_id，category_id获取图片
     * @return
     */
    public String getPhotosByShopIdAndCategoryId(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map
    	List<Photo> photos = new ArrayList<Photo>();
    	photos = PhotoImpl.getPhotosByShopIdAndCategoryId(shop_id,category_id);
    	tempMap.put("photos", photos);
    	result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
    public String listAll(){  
    	int total = PhotoDTOImpl.getTotal(category_id);//获取数据总量
        List<PhotoDTO> list = PhotoDTOImpl.queryAllPhotos(category_id);//获取客户数据，放入list 
        //System.out.println(total);
        jsonMap.clear();
        jsonMap.put("draw", 1);
        jsonMap.put("recordsTotal", total);
        jsonMap.put("recordsFiltered", total);
        jsonMap.put("data", list);//rows键 存放每页记录 list 
        //result = JSONObject.fromObject(jsonMap);//格式化result   一定要是JSONObject 
        //System.out.println(result);   
        //result = JSONArray.fromObject(jsonMap);   
        return SUCCESS; 
    }
    
    
}
