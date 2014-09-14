package com.sydenycode.impl;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;

import com.sydenycode.po.Pic;
import com.sydenycode.util.CONSTANT;
import com.sydenycode.util.MyDbPool;

public class PicImpl {
	
	static Logger logger = Logger.getLogger(PicImpl.class.getName());
	
	
	
	//解析前台传过来的字符串，解析成pic name数组
    public String[] getPicNamesFromJSON(String jsonString){
    	
    	JSONArray array = JSONArray.fromObject(jsonString);
    	String[] pic_names = new String[array.size()];
		for (int i = 0; i < array.size(); i++) {
			//System.err.println(array.get(i).toString());
			pic_names[i] = array.get(i).toString();
		}
    	
		return pic_names;
    }
    
    //在数据库插入商户-图片名称对应关系
    public static void addPics(int shop_id,String[] pic_names){
		String sql = "insert into pics(shop_id,name,upload_time) values(?,?,?)";
		
		Connection conn = new MyDbPool().getConnection();
		QueryRunner qr = new QueryRunner();
		PreparedStatement ps;
		Timestamp upload_time = new Timestamp(System.currentTimeMillis());
		try {
			ps = conn.prepareStatement(sql);
			for (String i : pic_names) {
				Object[] param = {String.valueOf(shop_id),i,upload_time.toString()};
				qr.fillStatement(ps, param);
				ps.addBatch();
			}
			ps.executeBatch();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error("PicImpl-addPics()-数据库操作失败！");
			e.printStackTrace();
		}finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("PicImpl-addPics()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
		
	}
    
    /**
     * 根据shop_id查询图片列表，拼接url
     * <p>Title: getPicsById</p>
     * <p>Description: </p>
     * @param shop_id
     * @return
     */
    
    @SuppressWarnings("unchecked")
	public static List<Pic> getPicsById(String shop_id) {
        
        ArrayList<Pic> result = new ArrayList<Pic>();
        ArrayList<Pic> tmpResult = new ArrayList<Pic>();
        String sql = "select * from pics where shop_id = ?";
        //System.out.println(sql);
        Object[] params = {shop_id};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        
        try {
        	tmpResult = (ArrayList<Pic>) qr.query(conn, sql, new BeanListHandler(Pic.class),params);
            for (Pic p : tmpResult) {
				p.setName(CONSTANT.WEB_URL+p.getName());
				result.add(p);
			}
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            logger.error("PicImpl-getPicsById()-数据库操作失败！");
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("PicImpl-getPicsById()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return result;
    }
    
    /**
     * 根据PIC_ID获取PIC对象
     * <p>Title: getPicsByPicId</p>
     * <p>Description: </p>
     * @param pic_id
     * @return
     */
    @SuppressWarnings("unchecked")
	public static Pic getPicByPicId(String pic_id) {
        
        Pic pic = new Pic();
        String sql = "select * from pics where id = ?";
        //System.out.println(sql);
        Object[] params = {pic_id};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        
        try {
        	pic = (Pic) qr.query(conn, sql, new BeanHandler(Pic.class),params);
            
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            logger.error("PicImpl-getPicsById()-数据库操作失败！");
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("PicImpl-getPicsById()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return pic;
    }
    
    /**
     * 根据shop_id查询图片列表，不拼接url
     * <p>Title: getPicsById</p>
     * <p>Description: </p>
     * @param shop_id
     * @return
     */
    
    @SuppressWarnings("unchecked")
	public static List<Pic> getRealNamesPicsById(String shop_id) {
        
        ArrayList<Pic> tmpResult = new ArrayList<Pic>();
        String sql = "select * from pics where shop_id = ?";
        //System.out.println(sql);
        Object[] params = {shop_id};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        
        try {
        	tmpResult = (ArrayList<Pic>) qr.query(conn, sql, new BeanListHandler(Pic.class),params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            logger.error("PicImpl-getRealNamesPicsById()-数据库操作失败！");
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("PicImpl-getRealNamesPicsById()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return tmpResult;
    }
    
    //删除商铺所有图片
    public static int delete(String url,String shop_id){
    	int flag = 0;
        //删除已上传图片
    	List<Pic> existPics = getRealNamesPicsById(shop_id);
        if(existPics!=null){
        	//System.out.println(existPics.size());
        	for(Pic p: existPics){
        		String  fullpath = url+"\\"+p.getName();
        		//System.out.println(fullpath);
        		new File(fullpath).delete();
        	}
        }
		String sql = "delete from pics where shop_id=?;";
	    //System.out.println(sql);
	    Object[] params = {shop_id};
	    Connection conn = new MyDbPool().getConnection();
	    QueryRunner qr = new QueryRunner();
	    try {
	        flag = qr.update(conn,sql, params);
	    } catch (SQLException e) {
	        // TODO Auto-generated catch block
	        logger.error("PicImpl-delete()-数据库操作失败！");
	        e.printStackTrace();
	    }finally{
	        try {
	            conn.close();
	        } catch (SQLException e) {
	            logger.error("PicImpl-delete()-连接关闭失败");
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	    }
	    if(flag!=0){
	    	logger.info("编号为"+shop_id+"的商铺图片被删除！");
	    }
	    
        return flag;
    }
    
    //删除商铺指定图片
    public static int deletePicById(String url,String pic_id){
    	int flag = 0;
        //删除已上传图片
    	Pic pic = PicImpl.getPicByPicId(pic_id);
		String  fullpath = url+"\\"+pic.getName();
		//System.out.println(fullpath);
		new File(fullpath).delete();
		//删除数据库记录
		String sql = "delete from pics where id=?;";
	    //System.out.println(sql);
	    Object[] params = {pic_id};
	    Connection conn = new MyDbPool().getConnection();
	    QueryRunner qr = new QueryRunner();
	    try {
	        flag = qr.update(conn,sql, params);
	    } catch (SQLException e) {
	        // TODO Auto-generated catch block
	        logger.error("PicImpl-deletePicById()-数据库操作失败！");
	        e.printStackTrace();
	    }finally{
	        try {
	            conn.close();
	        } catch (SQLException e) {
	            logger.error("PicImpl-deletePicById()-连接关闭失败");
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	    }
	    if(flag!=0){
	    	logger.info("编号为"+pic_id+"的商铺图片被删除！");
	    }
	    
        return flag;
    }
}
