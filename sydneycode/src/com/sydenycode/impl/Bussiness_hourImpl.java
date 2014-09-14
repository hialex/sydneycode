package com.sydenycode.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;

import com.sydenycode.po.Bussiness_hour;
import com.sydenycode.util.MyDbPool;
import com.sydenycode.util.TimeUtils;

public class Bussiness_hourImpl {
	static Logger logger = Logger.getLogger(Bussiness_hourImpl.class.getName());
	
	//解析前台传过来的字符串，解析成pic name数组
    public List<Bussiness_hour> getBussinessHoursFromJSON(String jsonString){
    	
    	List<Bussiness_hour> bhList = new ArrayList<Bussiness_hour>();
    	
    	JSONArray array = JSONArray.fromObject(jsonString);
		for (int i = 0; i < array.size(); i++) {
			//System.err.println(array.get(i).toString());
			JSONObject o = JSONObject.fromObject(array.get(i));
			Bussiness_hour bussinessHour = new Bussiness_hour();
			bussinessHour.setIs_open(o.getBoolean("is_open"));
			bussinessHour.setWeekday(o.getInt("weekday"));
			if(bussinessHour.isIs_open()){
				bussinessHour.setIs_need_book(o.getBoolean("is_need_book"));
				if(!bussinessHour.isIs_need_book()){
					bussinessHour.setStart_time(TimeUtils.getTime(o.getString("start_time").toString()));
					bussinessHour.setEnd_time(TimeUtils.getTime(o.getString("end_time").toString()));
				}
			}
			bhList.add(bussinessHour);
		}
    	
		return bhList;
    }
	
  //在数据库插入商户-营业时间对应关系
	public static void addBussiness_hours( int shop_id,List<Bussiness_hour> bussinessHours){
		//String sql = "insert into bussiness_hours(shop_id,weekday,start_time,end_time,is_open) values(?,?,?,?,?)";
		String sql = "insert into bussiness_hours(shop_id,weekday,start_time,end_time,is_open,is_need_book) values(?,?,?,?,?,?)";
		
		Connection conn = new MyDbPool().getConnection();
		QueryRunner qr = new QueryRunner();
		PreparedStatement ps;
		
		try {
			ps = conn.prepareStatement(sql);
			
			for (Bussiness_hour bussinessHour : bussinessHours) {
				if(bussinessHour.isIs_open()){
					Object[] param = {shop_id,bussinessHour.getWeekday(),bussinessHour.getStart_time(),bussinessHour.getEnd_time(),bussinessHour.isIs_open(),bussinessHour.isIs_need_book()};
					qr.fillStatement(ps, param);
				}else{
					Object[] param = {shop_id,bussinessHour.getWeekday(),null,null,bussinessHour.isIs_open(),null};
					qr.fillStatement(ps, param);
				}
				ps.addBatch();
			}
			
			ps.executeBatch();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error("Bussiness_hourImpl-addBussiness_hours()-数据库操作失败！");
			e.printStackTrace();
		}finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("Bussiness_hourImpl-addBussiness_hours()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
		
	}
	
	/**
	 * 根据shop_id查询营业时间
	 * <p>Title: getBussinessHourById</p>
	 * <p>Description: </p>
	 * @param shop_id
	 * @return
	 */
	
	@SuppressWarnings("unchecked")
    public static List<Bussiness_hour> getBussinessHourById(String shop_id) {
        
        ArrayList<Bussiness_hour> result = new ArrayList<Bussiness_hour>();
        String sql = "select * from bussiness_hours where shop_id = ?";
        //System.out.println(sql);
        Object[] params = {shop_id};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        
        try {
        	result = (ArrayList<Bussiness_hour>) qr.query(conn, sql, new BeanListHandler(Bussiness_hour.class),params);
            
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            logger.error("Bussiness_hourImpl-getBussinessHourById()-数据库操作失败！");
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("Bussiness_hourImpl-getBussinessHourById()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return result;
    }
    
  //删除商铺-营业时间
    public static int delete(String shop_id){
    	int flag = 0;
        
		String sql = "delete from bussiness_hours where shop_id=?;";
	    //System.out.println(sql);
	    Object[] params = {shop_id};
	    Connection conn = new MyDbPool().getConnection();
	    QueryRunner qr = new QueryRunner();
	    try {
	        flag = qr.update(conn,sql, params);
	    } catch (SQLException e) {
	        // TODO Auto-generated catch block
	        logger.error("Bussiness_hourImpl-delete()-数据库操作失败！");
	        e.printStackTrace();
	    }finally{
	        try {
	            conn.close();
	        } catch (SQLException e) {
	            logger.error("Bussiness_hourImpl-delete()-连接关闭失败");
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	    }
	    if(flag!=0){
	    	logger.info("编号为"+shop_id+"的商铺营业时间信息被删除！");
	    }
        return flag;
    }
}
