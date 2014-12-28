package com.sydenycode.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.log4j.Logger;

import com.sydenycode.po.PhotoCategory;
import com.sydenycode.util.MyDbPool;

public class PhotoCategoryImpl {
	
	static Logger logger = Logger.getLogger(PhotoCategoryImpl.class.getName());
	
	//添加地区
    public static int addPhotoCategory(PhotoCategory category){
        String sql = "insert into photo_category (" +
                "catalog_id," +
                "catalog_name," +
                "name," +
                "order_id)"+" values(?,?,?,?);";
        //System.out.println(sql);
        Object[] params = {category.getCatalog_id(),category.getCatalog_name(),category.getName(),category.getOrder_id()};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        int flag = 0;
        try {
            flag = qr.update(conn,sql, params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("PhotoCategoryImpl-addPhotoCategory()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("PhotoCategoryImpl-addPhotoCategory()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        //System.out.println(flag);
        return flag;
    }
    
    
  //获取图片分类总量
    public static int getTotal(){
    	String sql = "";
        int total = -1;
        sql = "select count(*) total from photo_category ;";
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        //Object[] params = {area};
        try {
            Map<String,Object> map = (Map<String,Object>) qr.query(conn, sql, new MapHandler());
            total = Integer.parseInt(map.get("total").toString());
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("PhotoCategoryImpl-getTotal()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("PhotoCategoryImpl-getTotal()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return total;
    }
    
  //查询所有图片分类信息
    @SuppressWarnings("unchecked")
	public static List<PhotoCategory> queryAll(){
        String sql = "";
        List<PhotoCategory> all = new ArrayList<PhotoCategory>();
        sql = "select * from photo_category";
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        //Object[] params = {area};
        try {
        	
        	all = (List<PhotoCategory>) qr.query(conn, sql, new BeanListHandler(PhotoCategory.class));
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("PhotoCategoryImpl-queryAll()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("PhotoCategoryImpl-queryAll()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return all;
    }
  //编辑图片分类
    public static int setDefaultDisplay(String id,String catalog_id){
        //清除原信息
        String sql1 = "update photo_category set default_display=null where catalog_id=?";
        String sql2 = "update photo_category set default_display=1 where id=?;";
        //System.out.println(sql);
        Object[] params = {catalog_id};
        Object[] params1 = {id};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        int flag = 0;
        try {
            qr.update(conn,sql1, params);
            flag = qr.update(conn,sql2, params1);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("PhotoCategoryImpl-setDefaultDisplay()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("PhotoCategoryImpl-setDefaultDisplay()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        //System.out.println(flag);
        return flag;
    }
   //编辑图片分类
    public static int editCategory(PhotoCategory category){
        
        String sql = "update photo_category set name=?,catalog_id=?,catalog_name=?,order_id=? where id=?";
        //System.out.println(sql);
        Object[] params = {category.getName(),category.getCatalog_id(),category.getCatalog_name(),category.getOrder_id(),category.getId()};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        int flag = 0;
        try {
            flag = qr.update(conn,sql, params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("PhotoCategoryImpl-editCategory()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("CatalogImpl-editCategory()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        //System.out.println(flag);
        return flag;
    }
  //根据ID查询图片分类
    @SuppressWarnings("unchecked")
	public static PhotoCategory queryPhotoCategoryById(String id){
        String sql = "";
        PhotoCategory category = new PhotoCategory();
        sql = "select * from photo_category where id=?";
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        Object[] params = {id};
        try {
        	category = (PhotoCategory) qr.query(conn, sql, new BeanHandler(PhotoCategory.class),params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("PhotoCategoryImpl-queryPhotoCategoryById()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("PhotoCategoryImpl-queryPhotoCategoryById()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return category;
    }
    
  //根据root_catalog_ID查询图片分类
    @SuppressWarnings("unchecked")
	public static List<PhotoCategory> queryPhotoCategoryByCatalogId(String root_catalog_id){
        String sql = "";
        List<PhotoCategory> allCategories = new ArrayList<PhotoCategory>();
        sql = "select * from photo_category where catalog_id=? order by order_id desc";
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        Object[] params = {root_catalog_id};
        try {
        	allCategories = (List<PhotoCategory>) qr.query(conn, sql, new BeanListHandler(PhotoCategory.class),params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("PhotoCategoryImpl-queryPhotoCategoryByCatalogId()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("PhotoCategoryImpl-queryPhotoCategoryByCatalogId()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return allCategories;
    }
    //删除图片分类
    /*
    public static int deleteSuburb(String id){
    	int flag = 0;
        //有下级地区不能删除
    	if(getSuburbListByParentId(id,"web",null).size()>0){
    		flag = -1;
    	}else if(ShopImpl.getShopBySuburbId(id).size()>0){
    		//有对应商家不能删除
    		flag = -2;
    	}else{
    		String sql = "delete from suburbs where id=?;";
		    //System.out.println(sql);
		    Object[] params = {id};
		    Connection conn = new MyDbPool().getConnection();
		    QueryRunner qr = new QueryRunner();
		    try {
		        flag = qr.update(conn,sql, params);
		    } catch (SQLException e) {
		        // TODO Auto-generated catch block
		        logger.error("SururbImpl-deleteSuburb()-数据库操作失败！");
		        e.printStackTrace();
		    }finally{
		        try {
		            conn.close();
		        } catch (SQLException e) {
		            logger.error("SururbImpl-deleteSuburb()-连接关闭失败");
		            // TODO Auto-generated catch block
		            e.printStackTrace();
		        }
		    }
    	}
    	if(flag==1){
	    	logger.info("编号为"+id+"的Suburb被删除！");
	    }
        return flag;
    }
    
  
    
  
    */
}
