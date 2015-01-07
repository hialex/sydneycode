package com.sydenycode.impl;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;

import com.sydenycode.po.Photo;
import com.sydenycode.util.CONSTANT;
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
                "order_id,type)"+" values(?,?,?,?,?,?,?,?,?,?,?,?);";
        //System.out.println(sql);
        Object[] params = {photo.getCategory_id(),photo.getShop_id(),photo.getName(),photo.getFilename(),photo.getIntro()
        		,photo.getSource(),photo.getStatus(),photo.getAuthor_name(),photo.getAuthor_ip(),photo.getAdd_time(),photo.getOrder_id(),photo.getType()};
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
	public static List<Photo> getPhotosByShopIdAndCategoryId(String shop_id,String category_id,String type){
    	String sql = "";
    	List<Photo> photos = new ArrayList<Photo>();
    	if(CONSTANT.FANSUPLOADPHOTOS.equals(type)){
    		//网友传图
    		sql = "select * from photos where shop_id = ? and category_id=? and type='"+CONSTANT.FANSUPLOADPHOTOS+"' ORDER BY order_id desc ";
    	}else if(CONSTANT.OFFICIALPHOTOS.equals(type)){
    		//官方图
    		sql = "select * from photos where shop_id = ? and category_id=? and type='"+CONSTANT.OFFICIALPHOTOS+"' ORDER BY order_id desc ";
    	}else{
    		sql = "select * from photos where shop_id = ? and category_id=? ORDER BY order_id desc ";
    	}
        
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
    
    public static int deletePhoto(HttpServletRequest request,String id,String filename){
    	int flag = 0;
        
		String sql = "delete from photos where id=?;";
	    //System.out.println(sql);
	    Object[] params = {id};
	    Connection conn = new MyDbPool().getConnection();
	    QueryRunner qr = new QueryRunner();
	    try {
	        flag = qr.update(conn,sql, params);
	    } catch (SQLException e) {
	        // TODO Auto-generated catch block
	        logger.error("PhotoImpl-deletePhoto()-数据库操作失败！");
	        e.printStackTrace();
	    }finally{
	        try {
	            conn.close();
	        } catch (SQLException e) {
	            logger.error("PhotoImpl-deletePhoto()-连接关闭失败");
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	    }
	    //删除图片及缩略图文件
	    String save_path = request.getSession().getServletContext().getRealPath(CONSTANT.SAVEPATH);
	    String thumb_path = request.getSession().getServletContext().getRealPath(CONSTANT.THUMBPATH);
	    
	    File file = new File(save_path+"//"+filename);
	    if(file.isFile()&&file.exists()){
	    	file.delete();
	    }
	    File file2 = new File(thumb_path+"//"+filename);
	    if(file2.isFile()&&file2.exists()){
	    	file2.delete();
	    }
		return flag;
    }
    
    /**
	 * 根据分类查询图片LIST
	 * <p>Title: getShopBySuburbId</p>
	 * <p>Description: </p>
	 * @param suburb_id
	 * @return
	 */
	@SuppressWarnings("unchecked")
    public static List<Photo> getPhotoByCategoryId(String category_id) {
        
		List<Photo> tmp = new ArrayList<Photo>();
        String sql = "select * from photos where category_id = ?";
        //System.out.println(sql);
        Object[] params = {category_id};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        
        try {
        	tmp = (List<Photo>) qr.query(conn, sql, new BeanListHandler(Photo.class),params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            logger.error("PhotoImpl-getPhotoByCategoryId()-数据库操作失败！");
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("PhotoImpl-getPhotoByCategoryId()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return tmp;
    }
	/*
    * 根据shop_id查询图片列表，拼接url
    * <p>Title: getPicsById</p>
    * <p>Description: </p>
    * @param shop_id
    * @return
    */
   
   @SuppressWarnings("unchecked")
	public static List<Photo> getPhotosById(String shop_id) {
       
       ArrayList<Photo> result = new ArrayList<Photo>();
       String sql = "select * from photos where status=1 and shop_id = ? and type='"+CONSTANT.OFFICIALPHOTOS+"' ORDER BY order_id desc";
       //System.out.println(sql);
       Object[] params = {shop_id};
       Connection conn = new MyDbPool().getConnection();
       QueryRunner qr = new QueryRunner();
       
       try {
    	   result = (ArrayList<Photo>) qr.query(conn, sql, new BeanListHandler(Photo.class),params);
       } catch (SQLException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
           logger.error("PhotoImpl-getPhotoByCategoryId()-数据库操作失败！");
       }finally{
           try {
               conn.close();
           } catch (SQLException e) {
               logger.error("PhotoImpl-getPhotoByCategoryId()-连接关闭失败");
               // TODO Auto-generated catch block
               e.printStackTrace();
           }
       }
       return result;
   }
   
   
 //根据ID查询照片信息
   @SuppressWarnings("unchecked")
	public static Photo getPhotoById(String id){
       String sql = "";
       Photo photo = new Photo();
       sql = "select * from photos where id=?";
       Connection conn = new MyDbPool().getConnection();
       QueryRunner qr = new QueryRunner();
       Object[] params = {id};
       try {
    	   photo = (Photo) qr.query(conn, sql, new BeanHandler(Photo.class),params);
       } catch (SQLException e) {
           // TODO Auto-generated catch block
           logger.error("PhotoImpl-getPhotoById()-数据库操作失败！");
           e.printStackTrace();
       }finally{
           try {
               conn.close();
           } catch (SQLException e) {
               logger.error("PhotoImpl-getPhotoById()-连接关闭失败！");
               // TODO Auto-generated catch block
               e.printStackTrace();
           }
       }
       return photo;
   }

 //编辑图片
   public static int editPhoto(Photo photo){
       String sql = "update photos set " +
       		   "category_id=?," +
               "name=?," +
               "intro=?," +
               "order_id=?"+" where id=?;";
       //System.out.println(sql);
       Object[] params = {photo.getCategory_id(),photo.getName(),photo.getIntro(),photo.getOrder_id(),photo.getId()};
       Connection conn = new MyDbPool().getConnection();
       QueryRunner qr = new QueryRunner();
       int flag = 0;
       try {
           flag = qr.update(conn,sql, params);
       } catch (SQLException e) {
           // TODO Auto-generated catch block
           logger.error("PhotoImpl-editPhoto()-数据库操作失败！");
           e.printStackTrace();
       }finally{
           try {
               conn.close();
           } catch (SQLException e) {
               logger.error("PhotoImpl-editPhoto()-连接关闭失败");
               // TODO Auto-generated catch block
               e.printStackTrace();
           }
       }
       //System.out.println(flag);
       return flag;
   }
   
   /**
    * 设置图片类别，小编精选/网友晒图
    * <p>Title: setType</p>
    * <p>Description: </p>
    * @param id
    * @param type
    * @return
    */
   public static int setType(String id,String type){
       String sql = "update photos set " +
       		   "type=? where id=?;";
       //System.out.println(sql);
       Object[] params = {type,id};
       Connection conn = new MyDbPool().getConnection();
       QueryRunner qr = new QueryRunner();
       int flag = 0;
       try {
           flag = qr.update(conn,sql, params);
       } catch (SQLException e) {
           // TODO Auto-generated catch block
           logger.error("PhotoImpl-setType()-数据库操作失败！");
           e.printStackTrace();
       }finally{
           try {
               conn.close();
           } catch (SQLException e) {
               logger.error("PhotoImpl-setType()-连接关闭失败");
               // TODO Auto-generated catch block
               e.printStackTrace();
           }
       }
       //System.out.println(flag);
       return flag;
   }
   /**
    * 图片审核
    * <p>Title: approve</p>
    * <p>Description: </p>
    * @param id
    * @param type
    * @param category_id
    * @return
    */
   public static int approve(String id,String type,String category_id){
       String sql = "update photos set " +
       		   "type=?,category_id=?,status=1 where id=?;";
       //System.out.println(sql);
       Object[] params = {type,category_id,id};
       Connection conn = new MyDbPool().getConnection();
       QueryRunner qr = new QueryRunner();
       int flag = 0;
       try {
           flag = qr.update(conn,sql, params);
       } catch (SQLException e) {
           // TODO Auto-generated catch block
           logger.error("PhotoImpl-approve()-数据库操作失败！");
           e.printStackTrace();
       }finally{
           try {
               conn.close();
           } catch (SQLException e) {
               logger.error("PhotoImpl-approve()-连接关闭失败");
               // TODO Auto-generated catch block
               e.printStackTrace();
           }
       }
       //System.out.println(flag);
       return flag;
   }
}
