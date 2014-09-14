package com.sydenycode.util;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.apache.tomcat.jdbc.pool.PoolProperties;
public class MyDbPool {
	
	private final static String USER = "root";
	private final static String PASSWORD = "t2000vip";
	

	public final Connection getConnection() {
		PoolProperties p = new PoolProperties();
	    p.setUrl("jdbc:mysql://localhost:3306/sydneycode?autoReconnect=true&useUnicode=true");
	    p.setDriverClassName("com.mysql.jdbc.Driver");
	    p.setUsername(USER);
	    p.setPassword(PASSWORD);
	    p.setJmxEnabled(true);
	    p.setTestWhileIdle(false);
	    p.setTestOnBorrow(true);
	    p.setValidationQuery("SELECT 1");
	    p.setTestOnReturn(false);
	    p.setValidationInterval(30000);
	    p.setTimeBetweenEvictionRunsMillis(30000);
	    p.setMaxActive(100);
	    p.setInitialSize(20);
	    p.setMaxWait(10000);
	    p.setRemoveAbandonedTimeout(120);
	    p.setMinEvictableIdleTimeMillis(30000);
	    p.setMinIdle(10);
	    p.setLogAbandoned(false);
	    p.setRemoveAbandoned(true);
	    p.setJdbcInterceptors("org.apache.tomcat.jdbc.pool.interceptor.ConnectionState;"+
	      "org.apache.tomcat.jdbc.pool.interceptor.StatementFinalizer");
	    DataSource datasource = new DataSource();
	    datasource.setPoolProperties(p);
		Connection con = null;
	    try {
	      con = datasource.getConnection();
	    } catch (SQLException e) {
			throw new RuntimeException("无法从数据源获取连接 ", e);
		}
		return con;
	}
	
}
