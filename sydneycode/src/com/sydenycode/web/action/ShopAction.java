package com.sydenycode.web.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.sydenycode.dto.ShopDTO;
import com.sydenycode.impl.Bussiness_hourImpl;
import com.sydenycode.impl.CatalogImpl;
import com.sydenycode.impl.ShopDTOImpl;
import com.sydenycode.impl.ShopImpl;
import com.sydenycode.impl.Shop_catalogImpl;
import com.sydenycode.po.Bussiness_hour;
import com.sydenycode.po.Catalog;
import com.sydenycode.po.Shop;

public class ShopAction extends ActionSupport{
	
	
	/** serialVersionUID*/
	private static final long serialVersionUID = -5276907166989129940L;
	private JSONObject result;//返回的json
    Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
    private Shop shop;
    int status;
    String message;
    //接受添加页面传来的catalog id json串
    private String catalogs;
   
    //接受添加页面传来的pic urls json串
	//private String picurls;
	
	//接受添加页面传来的bussiness_hours json串
    private String bussiness_hours;
    
    //接受列表页面传来的shop_id
    private String id;
    
    //将查询出来的营业时间list返回至页面
    private List<Bussiness_hour> bussiness_hours_list = new ArrayList<Bussiness_hour>();
    
    //将查询出来的图片list返回至页面
    //private List<Pic> pics = new ArrayList<Pic>();
    
    //将查询出来的catalog names list返回至页面
    private List<Catalog> catalog_names_list = new ArrayList<Catalog>();
    
    //接受列表页面传来的pic_id
    private String pic_id;
    
    //接受置顶id
    private String top_id;
    
    //接受root catalog id
    private String root_catalog_id;
    
    
    
    public String getRoot_catalog_id() {
		return root_catalog_id;
	}

	public void setRoot_catalog_id(String rootCatalogId) {
		root_catalog_id = rootCatalogId;
	}

	public String getTop_id() {
		return top_id;
	}

	public void setTop_id(String topId) {
		top_id = topId;
	}

	public String getPic_id() {
		return pic_id;
	}

	public void setPic_id(String picId) {
		pic_id = picId;
	}

	

	public List<Catalog> getCatalog_names_list() {
		return catalog_names_list;
	}

	public void setCatalog_names_list(List<Catalog> catalogNamesList) {
		catalog_names_list = catalogNamesList;
	}


	public List<Bussiness_hour> getBussiness_hours_list() {
		return bussiness_hours_list;
	}

	public void setBussiness_hours_list(List<Bussiness_hour> bussinessHoursList) {
		bussiness_hours_list = bussinessHoursList;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCatalogs() {
		return catalogs;
	}

	public void setCatalogs(String catalogs) {
		this.catalogs = catalogs;
	}


	public String getBussiness_hours() {
		return bussiness_hours;
	}

	public void setBussiness_hours(String bussinessHours) {
		bussiness_hours = bussinessHours;
	}
	
	public Map<String, Object> getJsonMap() {
		return jsonMap;
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
	
    
	public Shop getShop() {
		return shop;
	}

	public void setShop(Shop shop) {
		this.shop = shop;
	}

	//添加商铺
    public String add(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	//写入shop对象，返回shop_id
    	int shop_id = ShopImpl.addShop(shop);
//    	System.out.println("picurls====>"+picurls);
//    	System.out.println("bussiness_hours====>"+bussiness_hours);
    	if(shop_id!=0){
    		int[] catalog_ids = new CatalogImpl().getCatalogsFromJSON(catalogs);
    		//2.写入商户-分类数据
    		Shop_catalogImpl.addShop_catalogs(shop_id, catalog_ids);
    		if((bussiness_hours!=null)&&(bussiness_hours.length()!=0)){
    			List<Bussiness_hour> bussinessHours = new Bussiness_hourImpl().getBussinessHoursFromJSON(bussiness_hours);
    			//3.写入商户-营业时间数据
        		Bussiness_hourImpl.addBussiness_hours(shop_id, bussinessHours);
    		}
    		status = 1;
            message = "商铺信息添加成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else{
            //保存失败
            status = 0; 
            message = "商铺信息添加失败，请检查！";
            tempMap.put("message", message);
        }
    	
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
        //System.out.println(result);
    	return SUCCESS;
    }
    
    //编辑商铺
    public String edit(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	//写入shop对象，返回shop_id
//    	System.out.println("catalogs====>"+catalogs);
//    	System.out.println("picurls====>"+picurls);
//    	System.out.println("bussiness_hours====>"+bussiness_hours);
    	if((catalogs!=null)&&(catalogs.length()!=0)){
	    	int[] catalog_ids = new CatalogImpl().getCatalogsFromJSON(catalogs);
	    	//2.清除原分类数据，写入商户-分类数据
	    	Shop_catalogImpl.delete(id);
			Shop_catalogImpl.addShop_catalogs(Integer.parseInt(id), catalog_ids);
    	}
		if((bussiness_hours!=null)&&(bussiness_hours.length()!=0)){
			List<Bussiness_hour> bussinessHours = new Bussiness_hourImpl().getBussinessHoursFromJSON(bussiness_hours);
			//3.清除原营业时间数据,写入商户-营业时间数据
			Bussiness_hourImpl.delete(id);
    		Bussiness_hourImpl.addBussiness_hours(Integer.parseInt(id), bussinessHours);
		}
		int flag = ShopImpl.editShop(id,shop);
    	if(flag!=0){
    		status = 1;
            message = "商铺信息编辑成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else{
            //保存失败
            status = 0; 
            message = "商铺信息编辑失败，请检查！";
            tempMap.put("message", message);
        }
    	
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
        //System.out.println(result);
    	return SUCCESS;
    }
    
    //商铺列表
    public String list(){       
        //System.out.println(area);
    	int total = ShopDTOImpl.getTotal();//获取数据总量
        List<ShopDTO> list = ShopDTOImpl.queryAllShops();//获取客户数据，放入list 
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
    
    /**
     * 查看商铺详细信息
     * @return
     */
    public String show(){
        shop = ShopImpl.getShopById(id);
        //System.out.println(shop.getName());
        bussiness_hours_list = Bussiness_hourImpl.getBussinessHourById(id);
        catalog_names_list = Shop_catalogImpl.getCatalogNames(id);
        return "GoToDetail";
    }
    
    
    
    /**
     * 设置店铺归属大类
     * <p>Title: setRootCatalog</p>
     * <p>Description: </p>
     * @return
     */
    public String setRootCatalog(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	//System.out.println("id==>"+id+",root_catalog_id==>"+root_catalog_id);
    	int flag = ShopImpl.setRootCatalog(id,root_catalog_id);
    	if(flag==1){
            //删除成功
            status = 1;
            message = "设置成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else{
            //删除失败
            status = -1; 
            message = "设置失败，请检查！";
            tempMap.put("message", message);
        }
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
    //删除商铺
    public String delete(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	
    	
    	//删除营业时间数据
    	Bussiness_hourImpl.delete(id);
    	//删除店铺-分类数据
    	Shop_catalogImpl.delete(id);
    	//删除店铺数据
    	int delete_shop_flag = ShopImpl.deleteShop(id);
    	if(delete_shop_flag==1){
            //删除成功
            status = 1;
            message = "商铺信息删除成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else{
            //删除失败
            status = -1; 
            message = "商铺信息删除失败，请检查！";
            tempMap.put("message", message);
        }
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
    
	/**
     * 获取商铺详细信息
     * @return
     */
    public String getShopById(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map
    	shop = ShopImpl.queryShopById(id);
    	tempMap.put("shop", shop);
    	result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
    /**
     * 设置店铺置顶，写入top_id
     * <p>Title: top</p>
     * <p>Description: </p>
     * @param id
     * @param top_id
     * @return
     */
    public String top(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map 
    	//设置置顶id
    	int flag = ShopImpl.topShop(id,top_id);
    	if(flag==1){
            //删除成功
            status = 1;
            message = "店铺置顶成功！";
            tempMap.put("status", status);
            tempMap.put("message", message);
            
        }else{
            //删除失败
            status = -1; 
            message = "店铺置顶失败，请检查！";
            tempMap.put("message", message);
        }
        result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
}
