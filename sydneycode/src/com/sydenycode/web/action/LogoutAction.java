package com.sydenycode.web.action;


import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class LogoutAction extends ActionSupport implements SessionAware {
	
	private static final long serialVersionUID = -7594874707059739660L;
	
	private Map<String,Object> session;
	
	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		//User user = (User) session.get("user");
		
		session.remove("user");
		
		return "quit";
	}
	
	public void setSession(Map<String, Object> session) {
		// TODO Auto-generated method stub
		this.session = session;
	}

}
