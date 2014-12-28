package com.sydenycode.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;

import com.sydenycode.po.Photo;
import com.sydenycode.util.MyDbPool;

public class PhotoImpl {
	
	static Logger logger = Logger.getLogger(PhotoImpl.class.getName());
	
	//添加图片
    public static int addPhoto(Photo photo){
        String sql = "insert into photos (" +
                "category_id," +
                "shop_id," +
                "name," +
                "filename," +
                "intro," +
                "source," +
                "status," +
                "author_name," +
                "author_ip," +
                "add_time," +
                "order_id)"+" values(?,?,?,?,?,?,?,?,?,?,?);";
        //System.out.println(sql);
        Object[] params = {photo.getCategory_id(),photo.getShop_id(),photo.getName(),photo.getFilename(),photo.getIntro()
        		,photo.getSource(),photo.getStatus(),photo.getAuthor_name(),photo.getAuthor_ip(),photo.getAdd_time(),photo.getOrder_id()};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        int flag = 0;
        try {
            flag = qr.update(conn,sql, params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("PhotoImpl-addPhoto()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("PhotoImpl-addPhoto()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        //System.out.println(flag);
        return flag;
    }
    
    @SuppressWarnings("unchecked")
	public static List<Photo> getPhotosByShopIdAndCategoryId(String shop_id,String category_id){
    	String sql = "";
    	List<Photo> photos = new ArrayList<Photo>();
        sql = "select * from photos where shop_id = ? and category_id=? ORDER BY order_id desc ";
        //System.out.println(sql);
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        Object[] params = {shop_id,category_id};
        try {
        	photos = (List<Photo>) qr.query(conn, sql, new BeanListHandler(Photo.class),params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("PhotoImpl-getPhotosByShopIdAndCategoryId()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("PhotoImpl-getPhotosByShopIdAndCategoryId()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return photos;
    }
}
