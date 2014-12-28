package com.sydenycode.web.action;


import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.opensymphony.xwork2.ActionSupport;
import com.sydenycode.impl.UserImpl;
import com.sydenycode.po.User;
import com.sydenycode.util.MD5Util;
import com.sydenycode.util.SimpleDateUtil;
import com.sydenycode.util.Utils;

public class LoginAction extends ActionSupport implements SessionAware{
	
	static Logger logger = Logger.getLogger(LoginAction.class.getName());
	
	private static final long serialVersionUID = -7742020115505257610L;
	private User user;
	private User tempUser = new User();
	
	int status ;
	String message;
	private Map<String,Object> result = new HashMap<String,Object>();
	private Map<String,Object> session;
	@JSON(serialize=false)
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	
	public String login(){
		//根据传来值进行验证
		boolean flag = UserImpl.isLeagal(user.getUsername(), MD5Util.MD5(user.getPassword()));		
		//System.out.println(flag);
		if(flag){
			//用户合法
			logger.warn("["+SimpleDateUtil.getCurTimeString()+"] "+user.getUsername()+"尝试登录系统，登录成功！");
			HttpServletRequest request = ServletActionContext. getRequest(); 
			tempUser = UserImpl.getUser(user.getUsername(), MD5Util.MD5(user.getPassword()));
			//更新登录信息
			tempUser.setLast_login_ip( Utils.getIpAddr(request));
			tempUser.setLast_login_time(new Timestamp(new Date().getTime()));
			UserImpl.updateLogInfo(tempUser);
			session.put("user",tempUser);
			status = 1;
			message = "恭喜，登录成功！";
			result.put("status", status);
			result.put("message", message);
			
		}else{
			status = 0;
			logger.warn("["+SimpleDateUtil.getCurTimeString()+"] "+user.getUsername()+"尝试登录系统，登录失败！");
			message = "登录失败，请检查用户名密码！";
			result.put("status", status);
			result.put("message", message);
			
		}
		return SUCCESS; 
	}

	public void setSession(Map<String, Object> session) {
		// TODO Auto-generated method stub
		this.session = session;
	}

	public Map<String, Object> getResult() {
		return result;
	}

	public void setResult(Map<String, Object> result) {
		this.result = result;
	}
	
}
