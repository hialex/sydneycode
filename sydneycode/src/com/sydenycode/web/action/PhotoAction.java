package com.sydenycode.web.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.opensymphony.xwork2.ActionSupport;
import com.sydenycode.dto.PhotoDTO;
import com.sydenycode.impl.PhotoDTOImpl;
import com.sydenycode.impl.PhotoImpl;
import com.sydenycode.po.Photo;

public class PhotoAction extends ActionSupport implements ServletRequestAware{

	
	/** serialVersionUID*/
	private static final long serialVersionUID = 118938482575344768L;
	private JSONObject result;//返回的json
    Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
    private String shop_id;
    private String category_id;
    private String id;
    private String filename;
    private String type;
    private Photo photo;
	int status;
    String message;
	
    private HttpServletRequest request;
	public void setServletRequest(HttpServletRequest req) {
		this.request=req;
	}
    
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
    
    public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}
	
	public Photo getPhoto() {
		return photo;
	}

	public void setPhoto(Photo photo) {
		this.photo = photo;
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	/**
     * 根据shop_id，category_id获取图片
     * @return
     */
    public String getPhotosByShopIdAndCategoryId(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map
    	List<Photo> photos = new ArrayList<Photo>();
    	photos = PhotoImpl.getPhotosByShopIdAndCategoryId(shop_id,category_id,null);
    	tempMap.put("photos", photos);
    	result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
    /**
     * 图片库获取列表
     * <p>Title: listAll</p>
     * <p>Description: </p>
     * @return
     */
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
    
  //删除图片
    public String delete(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	
    	int flag = PhotoImpl.deletePhoto(request,id,filename);
    	if(flag==1){
            //删除成功
            status = 1;
            message = "图片删除成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else{
            //删除失败
            status = 0; 
            message = "图片删除失败，请重试！！";
            tempMap.put("message", message);
        }
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
    /**
     * 根据id查询图片信息
     * <p>Title: getPhotoById</p>
     * <p>Description: </p>
     * @return
     */
    public String getPhotoById(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map
    	Photo photo = PhotoImpl.getPhotoById(id);
    	tempMap.put("photo", photo);
    	result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
  //编辑照片
    public String editPhoto(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map
    	int flag = PhotoImpl.editPhoto(photo);
    	if(flag==1){
            //保存成功
            status = 1;
            message = "图片信息编辑成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else{
            //保存失败
            status = 0; 
            message = "图片信息编辑失败，请检查！";
            tempMap.put("message", message);
        }
    	
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    //设置图片类别，小编精选/网友晒图
    public String setType(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	
    	int flag = PhotoImpl.setType(id,type);
    	if(flag==1){
            //设置成功
            status = 1;
            message = "图片类别设置成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else{
            //设置失败
            status = 0; 
            message = "图片类别设置失败，请重试！！";
            tempMap.put("message", message);
        }
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
}
