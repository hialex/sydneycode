package com.sydenycode.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.log4j.Logger;

import com.sydenycode.po.User;
import com.sydenycode.util.MD5Util;
import com.sydenycode.util.MyDbPool;




public class UserImpl {	

	static Logger logger = Logger.getLogger(UserImpl.class.getName());
	
	/**
	 * 根据帐号密码判断用户是否合法
	 * @param username
	 * @param password
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static boolean isLeagal(String username,String password){
		boolean result = false;
		
		String sql = "select * from users where username =? and password =?;";
		Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
		Object[] params = {username,password};
		try {
			User tempUser = (User) qr.query(conn, sql, new BeanHandler(User.class),params);
			
			if(tempUser!=null){
				//合法用户
				result = true;
			}
		}  catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error("UserImpl.class-isLeagal()-数据库操作失败！");
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				logger.error("UserImpl.class-isLeagal()-连接关闭失败！");
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result;		
	}
	
	
	/**
	 * 根据帐号密码获取用户
	 * @param username
	 * @param password
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static User getUser(String username,String password){
		User retUser = null;
		String sql = "select * from users where username=? and password=?";
		Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
		Object[] params = {username,password};		
		try {
			retUser = (User) qr.query(conn, sql, new BeanHandler(User.class), params);			
		}  catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error("UserImpl.class-getUser()-数据库操作失败！");
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				logger.error("UserImpl.class-getUser()-连接关闭失败�?");
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return retUser;		
	}
	
	@SuppressWarnings("unchecked")
	public static User getUserById(String id){
		User retUser = null;
		String sql = "select * from users where id=?";
		Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
		Object[] params = {id};		
		try {
			retUser = (User) qr.query(conn, sql, new BeanHandler(User.class), params);			
		}  catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error("UserImpl.class-getUserById()-数据库操作失败！");
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				logger.error("UserImpl.class-getUserById()-连接关闭失败！");
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return retUser;		
	}
	
	
	/**
	 * 更新指定id的用户信息
	 * @param id
	 * @param ryxx
	 * @return
	 */
	public static int updateUserPass(String id,String newPass){
		String sql = "update users set " +
				"password=?" +
				"where id=?;";
		Object[] params = {MD5Util.MD5(newPass),id};
		Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
		
		int flag = 0;
		try {
			flag = qr.update(conn,sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error("UserImpl.class-updateUserPass()-数据库操作失败！");
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				logger.error("UserImpl.class-updateUserPass()-连接关闭失败！");
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return flag;
	}
	
	/**
	 * 更新登录信息
	 * <p>Title: updateLogInfo</p>
	 * <p>Description: </p>
	 * @param user
	 */
	public static void updateLogInfo(User user){
		String sql = "update users set " +
				"last_login_time=?," +
				"last_login_ip=?" +
				" where id=?;";
		Object[] params = {user.getLast_login_time(),user.getLast_login_ip(),user.getId()};
		Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
		try {
			qr.update(conn,sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error("UserImpl.class-updateLogInfo()-数据库操作失败！");
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				logger.error("UserImpl.class-updateLogInfo()-连接关闭失败！");
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	
	//获取用户总量
    public static int getTotal(){
    	String sql = "";
        int total = -1;
        sql = "select count(*) total from users ;";
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        //Object[] params = {area};
        try {
            Map<String,Object> map = (Map<String,Object>) qr.query(conn, sql, new MapHandler());
            total = Integer.parseInt(map.get("total").toString());
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("UserImpl.class-getTotal()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("UserImpl.class-getTotal()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return total;
    }
	
	/**
	 * 添加用户信息
	 * @param user
	 * @return
	 */
	public static int addUser(User user){
				
		Connection conn = new MyDbPool().getConnection();
		Statement stmt;
		ResultSet rs;
		int keyValue = -1;  
		String sql = "insert into users (" +
		"username," +
		"password," +
		"nickname," +
		"role," +
		"add_time" +
		") values('"+user.getUsername()+"','"+MD5Util.MD5("123456")+"','"+user.getNickname()+"','"+user.getRole()
		+"','"+user.getAdd_time()
		+"');";
		//System.out.println(sql);
		
		try {
			stmt = conn.createStatement();
			stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
			rs = stmt.getGeneratedKeys();
			if (rs.next()) {				  
			    keyValue = rs.getInt(1);		  
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int flag = 0;
		if(keyValue!=-1){
			flag = 1;
		}
		return flag;
	}
	/**
	 * 更新指定id的用户信息
	 * @param id
	 * @param ryxx
	 * @return
	 */
	public static int updateUser(int id,User user){
		String sql = "update users set " +
			"username=?," +
			"nickname=?," +
			"role=?" +
				" where id=?;";
		Object[] params = {user.getUsername(),user.getNickname(),user.getRole(),id};
		Connection conn = new MyDbPool().getConnection();
		QueryRunner qr = new QueryRunner();
		
		int flag = 0;
		try {
			flag = qr.update(conn,sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error("UserImpl.class-updateUser()-数据库操作失败！");
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				logger.error("UserImpl.class-updateUser()-连接关闭失败！");
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		//System.out.println(flag);
		return flag;
	}
	
	/**
	 * 根据id删除用户信息
	 * @param id
	 * @return
	 */
	public static int removeUser(int id){
		String sql = "delete from users where id=?";
		Object[] params = {id};
		Connection conn = new MyDbPool().getConnection();
		QueryRunner qr = new QueryRunner();
		
		int flag = 0;
		try {
			flag = qr.update(conn,sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error("UserImpl.class-removeUser()-数据库操作失败！");
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				logger.error("UserImpl.class-removeUser()-连接关闭失败！");
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return flag;
	}
	
	/**
	 * 根据id重置用户密码
	 * @param id
	 * @return
	 */
	public static int resetUser(int id){
		String sql = "update users set password = ? where id=?";
		Object[] params = {MD5Util.MD5("123456"),id};
		Connection conn = new MyDbPool().getConnection();
		QueryRunner qr = new QueryRunner();
		
		int flag = 0;
		try {
			flag = qr.update(conn,sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error("UserImpl.class-resetUser()-数据库操作失败！");
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				logger.error("UserImpl.class-resetUser()-连接关闭失败");
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return flag;
	}
	
	//查询所有地区信息
    @SuppressWarnings("unchecked")
	public static List<User> queryAllUsers(){
        String sql = "";
        List<User> allUsers = new ArrayList<User>();
        sql = "select * from users ";
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        //Object[] params = {area};
        try {
        	
        	allUsers = (List<User>) qr.query(conn, sql, new BeanListHandler(User.class));
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("UserImpl.class-queryAllUsers()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("UserImpl.class-queryAllUsers()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return allUsers;
    }
	
}
