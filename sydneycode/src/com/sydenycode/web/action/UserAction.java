package com.sydenycode.web.action;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.sydenycode.impl.UserImpl;
import com.sydenycode.po.User;
import com.sydenycode.util.MD5Util;

public class UserAction extends ActionSupport implements ModelDriven<User>{

	private static final long serialVersionUID = -2593455889425684436L;
	
	private JSONObject result;//返回的json
    Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
    
    private String uid;
    private String oldPass;
    private String newPass;
	
    private User user;
    
    boolean success ;	
	String message;
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

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
	
	//显示所有用户
    public String listAll(){  
    	int total = UserImpl.getTotal();//获取数据总量
        List<User> list = UserImpl.queryAllUsers();//获取客户数据，放入list 
        //System.out.println(list.size());
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
     * 获取用户详细信息
     * @return
     */
    public String getUserById(){
    	Map<String, Object> tempMap = new HashMap<String, Object>();//定义map
    	user = UserImpl.getUserById(uid);
    	tempMap.put("user", user);
    	JsonConfig config = new JsonConfig();
    	config.setExcludes(new String[]{"password"});
    	result = JSONObject.fromObject(tempMap,config);//格式化result   一定要是JSONObject 
    	return SUCCESS;
    }
    
	public String editPass(){
//		System.out.println(uid);
//		System.out.println(oldPass);
//		System.out.println(newPass);
		user = UserImpl.getUserById(uid);
		Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
		//System.out.println(MD5Util.MD5(oldPass));
		//System.out.println(user.getPassword());
		if(MD5Util.MD5(oldPass).equalsIgnoreCase(user.getPassword())){
			//密码一致，更新密码
			int flag = UserImpl.updateUserPass(uid,newPass);
			if(flag==1){
				//添加成功
				success = true;
				message = "修改成功，务必牢记您的密码！请重新登录！";
			}else{
				//添加不成功
				success = false;
				message = "密码修改失败，请检查！";
			}
		}else{
			//密码不一致
			success = false;
			message = "您输入的原密码不正确，请重新输入！";
		}
		jsonMap.put("success", success);
        jsonMap.put("message", message);
        result = JSONObject.fromObject(jsonMap);//格式化result   一定要是JSONObject 
        // System.out.println(result);
        return SUCCESS;
	}
	
	/**
	 * 添加人员信息
	 * @return
	 */
	public String add() {
		user.setAdd_time(new Timestamp(new Date().getTime()));
		int flag = UserImpl.addUser(user);
		if(flag==1){
			//添加成功
			success = true;
			message = "用户信息添加成功,默认密码为123456，请及时修改密码！";
		}else{
			//添加不成功
			success = false;
			message = "用户信息添加失败，请检查！";
		}
		Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
		jsonMap.put("success", success);
        jsonMap.put("message", message);
        result = JSONObject.fromObject(jsonMap);//格式化result   一定要是JSONObject 
        // System.out.println(result);
        return SUCCESS;
	}
	/**
	 * 编辑用户信息
	 * @return
	 */
	public String edit(){
		int flag = UserImpl.updateUser(user.getId(), user);
		if(flag==1){
			//添加成功
			success = true;
			message = "用户信息编辑成功！";
		}else{
			//添加不成功
			success = false;
			message = "用户信息编辑失败，请检查！";
		}
		Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
		jsonMap.put("success", success);
        jsonMap.put("message", message);
        result = JSONObject.fromObject(jsonMap);//格式化result   一定要是JSONObject 
        //System.out.println(result);
        return SUCCESS;
	}
	
	public String delete(){
		int flag = UserImpl.removeUser(Integer.parseInt(uid));
		if(flag==1){
			//添加成功
			success = true;
			message = "编号为"+uid+"的用户信息删除成功！";
		}else{
			//添加不成功
			success = false;
			message = "编号为"+uid+"的用户信息删除失败，请检查！";
		}
		Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
		jsonMap.put("success", success);
        jsonMap.put("message", message);
        result = JSONObject.fromObject(jsonMap);//格式化result   一定要是JSONObject 
        //System.out.println(result);
        return SUCCESS;
	}
	
	public String reset(){
		int flag = UserImpl.resetUser(Integer.parseInt(uid));
		if(flag==1){
			//添加成功
			success = true;
			message = "用户密码已重置成功,默认密码为123456，请及时修改密码！";
		}else{
			//添加不成功
			success = false;
			message = "用户密码重置失败，请检查！";
		}
		Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
		jsonMap.put("success", success);
        jsonMap.put("message", message);
        result = JSONObject.fromObject(jsonMap);//格式化result   一定要是JSONObject 
        //System.out.println(result);
        return SUCCESS;
	}
	
	public User getModel() {
		// TODO Auto-generated method stub
		return user;
	}
	
	
	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getOldPass() {
		return oldPass;
	}

	public void setOldPass(String oldPass) {
		this.oldPass = oldPass;
	}

	public String getNewPass() {
		return newPass;
	}

	public void setNewPass(String newPass) {
		this.newPass = newPass;
	}
}
