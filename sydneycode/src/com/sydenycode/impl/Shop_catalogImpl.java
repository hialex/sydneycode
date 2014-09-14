package com.sydenycode.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ArrayListHandler;
import org.apache.log4j.Logger;

import com.sydenycode.util.MyDbPool;

public class Shop_catalogImpl {
	
	static Logger logger = Logger.getLogger(Shop_catalogImpl.class.getName());
	
	//在数据库插入商户-所属分类对应关系
	public static void addShop_catalogs(int shop_id,int[] catalog_ids){
		String sql = "insert into shop_catalog(shop_id,catalog_id) values(?,?);";
		
		Connection conn = new MyDbPool().getConnection();
		QueryRunner qr = new QueryRunner();
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement(sql);
			//System.out.println(catalog_ids.length);
			for(int i=0;i<catalog_ids.length;i++) {
				//System.out.println("shop_id-->"+shop_id+"<--catalog_id-->"+catalog_ids[i]);
				Object[] param = {shop_id,catalog_ids[i]};
				qr.fillStatement(ps, param);
				ps.addBatch();
			}
			ps.executeBatch();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error("Shop_catalogImpl-addShop_catalogs()-数据库操作失败！");
			e.printStackTrace();
		}finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("Shop_catalogImpl-addShop_catalogs()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
		
	}
	
	/**
	 * 根据shop_id获取catalog names
	 * <p>Title: getCatalogNames</p>
	 * <p>Description: </p>
	 * @param shop_id
	 * @return
	 */
	
	public static List<Object[]> getCatalogNames(String shop_id) {
        
        List<Object[]> result = new ArrayList<Object[]>();
        String sql = "select name from shop_catalog,catalogs where shop_catalog.catalog_id=catalogs.id and shop_id=?";
        //System.out.println(sql);
        Object[] params = {shop_id};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        
        try {
        	result =  qr.query(conn, sql, new ArrayListHandler(),params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            logger.error("Shop_catalogImpl-getCatalogNames()-数据库操作失败！");
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("Shop_catalogImpl-getCatalogNames()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return result;
    }
	
	//删除商铺-分类
    public static int delete(String shop_id){
    	int flag = 0;
        
		String sql = "delete from shop_catalog where shop_id=?;";
	    //System.out.println(sql);
	    Object[] params = {shop_id};
	    Connection conn = new MyDbPool().getConnection();
	    QueryRunner qr = new QueryRunner();
	    try {
	        flag = qr.update(conn,sql, params);
	    } catch (SQLException e) {
	        // TODO Auto-generated catch block
	        logger.error("Shop_catalogImpl-delete()-数据库操作失败！");
	        e.printStackTrace();
	    }finally{
	        try {
	            conn.close();
	        } catch (SQLException e) {
	            logger.error("Shop_catalogImpl-delete()-连接关闭失败");
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
