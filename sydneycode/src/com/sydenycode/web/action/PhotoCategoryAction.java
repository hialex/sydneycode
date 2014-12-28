package com.sydenycode.web.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.sydenycode.impl.PhotoCategoryImpl;
import com.sydenycode.po.PhotoCategory;

public class PhotoCategoryAction extends ActionSupport {

	/** serialVersionUID*/
	private static final long serialVersionUID = -6693523036450014641L;
	
	private JSONObject result;//返回的json
    Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
    private PhotoCategory category;
	int status;
    String message;
    private String id;
    private String root_catalog_id;
    
    
    
    
	public String getRoot_catalog_id() {
		return root_catalog_id;
	}
	public void setRoot_catalog_id(String rootCatalogId) {
		root_catalog_id = rootCatalogId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public void setJsonMap(Map<String, Object> jsonMap) {
		this.jsonMap = jsonMap;
	}
	public PhotoCategory getCategory() {
		return category;
	}
	public void setCategory(PhotoCategory category) {
		this.category = category;
	}
    
	//添加分类
    public String add(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	
    	int flag = PhotoCategoryImpl.addPhotoCategory(category);
    	if(flag==1){
            //保存成功
            status = 1;
            message = "图片分类添加成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else{
            //保存失败
            status = 0; 
            message = "图片分类添加失败，请检查！";
            tempMap.put("message", message);
        }
    	
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
  //显示所有图片分类
    public String listAll(){  
    	int total = PhotoCategoryImpl.getTotal();//获取数据总量
        List<PhotoCategory> list = PhotoCategoryImpl.queryAll();//获取客户数据，放入list 
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
    //编辑图片分类
    public String edit(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	
    	int flag = PhotoCategoryImpl.editCategory(category);
    	if(flag==1){
            //保存成功
            status = 1;
            message = "图片分类编辑成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else{
            //保存失败
            status = 0; 
            message = "图片分类编辑失败，请检查！";
            tempMap.put("message", message);
        }
    	
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
    /**
     * 获取图片分类详细信息
     * @return
     */
    public String getPhotoCategoryById(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map
    	category = PhotoCategoryImpl.queryPhotoCategoryById(id);
    	tempMap.put("category", category);
    	result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    /**
     * 获取图片分类详细信息
     * @return
     */
    public String getPhotoCategoryByCatalogId(){
    	List<PhotoCategory> allCategories = new ArrayList<PhotoCategory>();
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map
    	allCategories = PhotoCategoryImpl.queryPhotoCategoryByCatalogId(root_catalog_id);
    	tempMap.put("allCategories", allCategories);
    	result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    public String setDefaultDisplay(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	
    	int flag = PhotoCategoryImpl.setDefaultDisplay(id,root_catalog_id);
    	if(flag==1){
            //保存成功
            status = 1;
            message = "默认显示设置成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else{
            //保存失败
            status = 0; 
            message = "默认显示设置失败，请检查！";
            tempMap.put("message", message);
        }
    	
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
}
