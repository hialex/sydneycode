package com.sydenycode.web.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.sydenycode.dto.CatalogDTO;
import com.sydenycode.impl.CatalogDTOImpl;
import com.sydenycode.impl.CatalogImpl;
import com.sydenycode.impl.Shop_catalogImpl;
import com.sydenycode.po.Catalog;

public class CatalogAction extends ActionSupport {

	/** serialVersionUID*/
	private static final long serialVersionUID = 5485775660092973959L;
	private JSONObject result;//返回的json
    Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
    private Catalog catalog;
    private CatalogDTO cdto;
    private String parent_id;
    
    
    public CatalogDTO getCdto() {
		return cdto;
	}

	public void setCdto(CatalogDTO cdto) {
		this.cdto = cdto;
	}

	private String id;
    
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

	public Catalog getCatalog() {
		return catalog;
	}

	public void setCatalog(Catalog catalog) {
		this.catalog = catalog;
	}

	public Map<String, Object> getJsonMap() {
		return jsonMap;
	}

	//添加分类
    public String add(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	
    	int flag = CatalogImpl.addCatalog(catalog);
    	if(flag==1){
            //保存成功
            status = 1;
            message = "分类信息添加成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else{
            //保存失败
            status = 0; 
            message = "分类信息添加失败，请检查！";
            tempMap.put("message", message);
        }
    	
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
  //编辑分类
    public String edit(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	
    	int flag = CatalogImpl.editCatalog(catalog);
    	if(flag==1){
            //保存成功
            status = 1;
            message = "分类信息编辑成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else{
            //保存失败
            status = 0; 
            message = "分类信息编辑失败，请检查！";
            tempMap.put("message", message);
        }
    	
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
    //根据父分类id获取所有子分类
    public String listByParentId(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	List<Catalog> ret = new ArrayList<Catalog>();
    	ret = CatalogImpl.getCatalogListByParentId(parent_id);
    	tempMap.put("catalog_list", ret);
    	result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject
    	return SUCCESS;
    }
    
    /**
     * 根据shop_id获取分类名称，用于编辑
     * @return
     */
    public String listCatalogNamesByShopId(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map
    	List<Object[]> catalog_names = Shop_catalogImpl.getCatalogNames(id);
    	tempMap.put("catalog_names", catalog_names);
    	result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
    
    //显示所有分类
    public String listAll(){  
    	int total = CatalogDTOImpl.getTotal();//获取数据总量
        List<CatalogDTO> list = CatalogDTOImpl.queryAllCatalogs();//获取客户数据，放入list 
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
    
    //删除分类
    public String delete(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	
    	int flag = CatalogImpl.deleteCatalog(id);
    	if(flag==1){
            //删除成功
            status = 1;
            message = "分类删除成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else if(flag==-1){
            //删除失败
            status = -1; 
            message = "该分类有下级分类，不能删除！若要删除请先删除下级分类！";
            tempMap.put("message", message);
        }else if(flag==-2){
            //删除失败
            status = -2; 
            message = "该分类有所属商家，不能删除！若要删除请先删除或修改对应商家信息！";
            tempMap.put("message", message);
        }
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
    /**
     * 获取分类详细信息
     * @return
     */
    public String getCatalogById(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map
    	cdto = CatalogDTOImpl.queryCatalogById(id);
    	tempMap.put("catalog", cdto);
    	result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
    
}
