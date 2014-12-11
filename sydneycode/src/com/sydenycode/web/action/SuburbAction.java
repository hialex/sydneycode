package com.sydenycode.web.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.sydenycode.impl.SuburbImpl;
import com.sydenycode.po.Suburb;

public class SuburbAction extends ActionSupport {

	/** serialVersionUID*/
	private static final long serialVersionUID = 5485775660092973959L;
	private JSONObject result;//返回的json
    Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
    private Suburb suburb;
	int status;
    String message;
    private String parent_id;
    private String id;
    private String from;
    private String rootId;
    
    

	public String getRootId() {
		return rootId;
	}

	public void setRootId(String rootId) {
		this.rootId = rootId;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getParent_id() {
		return parent_id;
	}

	public void setParent_id(String parentId) {
		parent_id = parentId;
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

	public Suburb getSuburb() {
		return suburb;
	}

	public void setSuburb(Suburb suburb) {
		this.suburb = suburb;
	}

	public Map<String, Object> getJsonMap() {
		return jsonMap;
	}

	//添加分类
    public String add(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	
    	int flag = SuburbImpl.addSuburb(suburb);
    	if(flag==1){
            //保存成功
            status = 1;
            message = "Suburb添加成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else{
            //保存失败
            status = 0; 
            message = "Suburb添加失败，请检查！";
            tempMap.put("message", message);
        }
    	
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    //根据父分类id获取所有地区
    public String listByParentId(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	List<Suburb> ret = new ArrayList<Suburb>();
    	if(from==null||from.equals("")){
    		from = "web";
    	}
    	ret = SuburbImpl.getSuburbListByParentId(parent_id,from,rootId);
//    	System.out.println(ret.size());
    	tempMap.put("suburb_list", ret);
    	result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject
    	return SUCCESS;
    }
    
  //获取热门地区
    public String listHot(){
    	if(from==null||from.equals("")){
    		from = "web";
    	}
    	if(rootId==null||rootId.equals("")){
    		rootId = "0";
    	}
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	List<Suburb> ret = new ArrayList<Suburb>();
    	ret = SuburbImpl.getHotSuburbList(parent_id,from,rootId);
    	tempMap.put("hot_suburb_list", ret);
    	result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject
    	return SUCCESS;
    }
    
  //显示所有地区
    public String listAll(){  
    	int total = SuburbImpl.getTotal();//获取数据总量
        List<Suburb> list = SuburbImpl.queryAllSuburbs();//获取客户数据，放入list 
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
    
    //删除地区
    public String delete(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	
    	int flag = SuburbImpl.deleteSuburb(id);
    	if(flag==1){
            //删除成功
            status = 1;
            message = "地区删除成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else if(flag==-1){
            //删除失败
            status = -1; 
            message = "该地区有下级地区，不能删除！若要删除请先删除下级地区！";
            tempMap.put("message", message);
        }else if(flag==-2){
            //删除失败
            status = -2; 
            message = "该地区有所属商家，不能删除！若要删除请先删除或修改对应商家信息！";
            tempMap.put("message", message);
        }
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
    /**
     * 获取地区详细信息
     * @return
     */
    public String getCatalogById(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map
    	suburb = SuburbImpl.querySuburbById(id);
    	tempMap.put("suburb", suburb);
    	result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
  //编辑地区
    public String edit(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	
    	int flag = SuburbImpl.editSuburb(suburb);
    	if(flag==1){
            //保存成功
            status = 1;
            message = "地区信息编辑成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else{
            //保存失败
            status = 0; 
            message = "地区信息编辑失败，请检查！";
            tempMap.put("message", message);
        }
    	
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
  
}
