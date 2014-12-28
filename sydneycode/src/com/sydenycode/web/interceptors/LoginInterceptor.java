package com.sydenycode.web.interceptors;

import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class LoginInterceptor extends AbstractInterceptor {

	private static final long serialVersionUID = -3402323291215266521L;
	
	 public static final String USER_SESSION_KEY="user";   
	 public static final String GOING_TO_URL_KEY="GOING_TO"; 
	 
	@Override
	public String intercept(ActionInvocation invocation) throws Exception {

		ActionContext actionContext = invocation.getInvocationContext();   
          
        Map<?, ?> session = actionContext.getSession();
		
        if (session != null && session.get(USER_SESSION_KEY) != null){  
            return invocation.invoke();  
        }   
        return "login";
	}
	

}
