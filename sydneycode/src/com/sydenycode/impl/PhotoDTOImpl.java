package com.sydenycode.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.log4j.Logger;

import com.sydenycode.dto.PhotoDTO;
import com.sydenycode.util.MyDbPool;

public class PhotoDTOImpl {
	static Logger logger = Logger.getLogger(PhotoDTOImpl.class.getName());
	//获取分类总量
    public static int getTotal(String category_id){
    	String sql = "";
        int total = -1;
        if(Integer.parseInt(category_id)==0){
        sql = "SELECT "+
        		"count(*) total "+
        		"FROM "+
        			"shops a,"+
					"photos b,"+
					"photo_category c "+
				"WHERE "+
					"a.id = b.shop_id "+
				"AND b.category_id = c.id ";
        }else{
        	sql = "SELECT "+
    		"count(*) total "+
    		"FROM "+
    			"shops a,"+
				"photos b,"+
				"photo_category c "+
			"WHERE "+
				"a.id = b.shop_id "+
			"AND b.category_id = c.id " +
			"AND b.category_id="+category_id;
        }
        //System.out.println(sql);
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        //Object[] params = {category_id};
        try {
            Map<String,Object> map = (Map<String,Object>) qr.query(conn, sql, new MapHandler());
            total = Integer.parseInt(map.get("total").toString());
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("PhotoDTOImpl-getTotal()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("PhotoDTOImpl-getTotal()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return total;
    }
    
    //查询所有分类信息
    @SuppressWarnings("unchecked")
	public static List<PhotoDTO> queryAllPhotos(String category_id){
        String sql = "";
        List<PhotoDTO> allPhotos = new ArrayList<PhotoDTO>();
        if(Integer.parseInt(category_id)==0){
	        sql = "SELECT "+
				"b.id,b.filename,b.shop_id,b.type,a.`name` shop_name,c.catalog_id,c.catalog_name,c.`name` category_name,b.source,b.`status`,b.add_time,b.author_name "+
				"FROM "+
					"shops a,"+
					"photos b,"+
					"photo_category c "+
				"WHERE "+
					"a.id = b.shop_id "+
				"AND b.category_id = c.id "+
				"ORDER BY add_time desc";
        }else{
        	sql = "SELECT "+
			"b.id,b.filename,b.shop_id,b.type,a.`name` shop_name,c.catalog_id,c.catalog_name,c.`name` category_name,b.source,b.`status`,b.add_time,b.author_name "+
			"FROM "+
				"shops a,"+
				"photos b,"+
				"photo_category c "+
			"WHERE "+
				"a.id = b.shop_id "+
			"AND b.category_id = c.id " +
			"AND b.category_id="+category_id+
			" ORDER BY add_time desc";
        }
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        //Object[] params = {category_id};
        try {
        	
        	allPhotos = (List<PhotoDTO>) qr.query(conn, sql, new BeanListHandler(PhotoDTO.class));
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("PhotoDTOImpl-queryAllPhotos()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("PhotoDTOImpl-queryAllPhotos()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return allPhotos;
    }
	
	
}
