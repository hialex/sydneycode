package com.sydenycode.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.log4j.Logger;

import com.sydenycode.po.Shop;
import com.sydenycode.util.MyDbPool;

public class ShopImpl {
	
	static Logger logger = Logger.getLogger(ShopImpl.class.getName());
	
	/**
	 * 添加shop
	 * <p>Title: addShop</p>
	 * <p>Description: </p>
	 * @param shop
	 * @return
	 */
	
	public static int  addShop(Shop shop){
		int last_id = 0;
		String sql = "insert into shops (" +
		        "suburb_id," +
		        "addr," +
		        "name," +
		        "tel," +
		        "mobile," +
		        "weixin," +
		        "weibo," +
		        "weibo_link," +
		        "momo," +
		        "email," +
		        "website," +
		        "facebook," +
		        "facebook_link," +
		        "instagram," +
		        "instagram_link," +
		        "qq," +
		        "twitter," +
		        "twitter_link," +
		        "youtube," +
		        "youtube_link," +
		        "intro," +
		        "score," +
		        "add_time)"+" values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
		//System.out.println(sql);
		Date date = new Date();
		Timestamp add_time = new Timestamp(date.getTime());
		Object[] params = {shop.getSuburb_id(),shop.getAddr(),shop.getName(),shop.getTel()
				,shop.getMobile(),shop.getWeixin(),shop.getWeibo(),shop.getWeibo_link(),shop.getMomo()
				,shop.getEmail(),shop.getWebsite(),shop.getFacebook(),shop.getFacebook_link(),shop.getInstagram(),shop.getInstagram_link()
				,shop.getQq(),shop.getTwitter(),shop.getTwitter_link(),shop.getYoutube(),shop.getYoutube_link(),shop.getIntro()
				,shop.getScore(),add_time};
		Connection conn = new MyDbPool().getConnection();
		QueryRunner qr = new QueryRunner();
		int flag = 0;
		try {
		    flag = qr.update(conn,sql, params);
		} catch (SQLException e) {
		    // TODO Auto-generated catch block
		    logger.error("ShopImpl-addShop()-数据库操作失败！");
		    e.printStackTrace();
		}
		if(flag==1){
			//插入成功返回id
			String query_id = "SELECT LAST_INSERT_ID() last_id;";
			try {
	            Map<String,Object> map = (Map<String,Object>) qr.query(conn, query_id, new MapHandler());
	            last_id = Integer.parseInt(map.get("last_id").toString());
	        } catch (SQLException e) {
	            // TODO Auto-generated catch block
	            logger.error("ShopImpl-addShop()-返回ID-数据库操作失败！");
	            e.printStackTrace();
	        }finally{
			    try {
			        conn.close();
			    } catch (SQLException e) {
			        logger.error("ShopImpl-addShop()-返回ID-连接关闭失败");
			        // TODO Auto-generated catch block
			        e.printStackTrace();
			    }
			}
		}else{
			try {
		        conn.close();
		    } catch (SQLException e) {
		        logger.error("ShopImpl-addShop()-连接关闭失败");
		        // TODO Auto-generated catch block
		        e.printStackTrace();
		    }
		}
		return last_id;
	}
	
	public static int  editShop(String id,Shop shop){
		
		String sql = "UPDATE shops SET " +
				"suburb_id=?," +
		        "addr=?," +
		        "name=?," +
		        "tel=?," +
		        "mobile=?," +
		        "weixin=?," +
		        "weibo=?," +
		        "weibo_link=?," +
		        "momo=?," +
		        "email=?," +
		        "website=?," +
		        "facebook=?," +
		        "facebook_link=?," +
		        "instagram=?," +
		        "instagram_link=?," +
		        "qq=?," +
		        "twitter=?," +
		        "twitter_link=?," +
		        "youtube=?," +
		        "youtube_link=?," +
		        "intro=?," +
		        "score=?," +
		        "add_time=? where id=?;";
	
		Date date = new Date();
		Timestamp add_time = new Timestamp(date.getTime());
		Object[] params = {shop.getSuburb_id(),shop.getAddr(),shop.getName(),shop.getTel()
				,shop.getMobile(),shop.getWeixin(),shop.getWeibo(),shop.getWeibo_link(),shop.getMomo()
				,shop.getEmail(),shop.getWebsite(),shop.getFacebook(),shop.getFacebook_link(),shop.getInstagram(),shop.getInstagram_link()
				,shop.getQq(),shop.getTwitter(),shop.getTwitter_link(),shop.getYoutube(),shop.getYoutube_link(),shop.getIntro()
				,shop.getScore(),add_time,id};
		Connection conn = new MyDbPool().getConnection();
		QueryRunner qr = new QueryRunner();
		int flag = 0;
		try {
            flag = qr.update(conn,sql, params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("ShopImpl-editShop()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("ShopImpl-editShop()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        //System.out.println(flag);
        return flag;
	}
	
	/**
	 * 根据shop_id获取shop对象
	 * <p>Title: getShopById</p>
	 * <p>Description: </p>
	 * @param shop_id
	 * @return
	 */
	
	@SuppressWarnings("unchecked")
    public static Shop getShopById(String shop_id) {
        
        Shop tmpShop = new Shop();
        String sql = "select shops.*,suburbs.`name` suburb_name from shops,suburbs where shops.suburb_id=suburbs.id and shops.id = ?";
        //System.out.println(sql);
        Object[] params = {shop_id};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        
        try {
        	tmpShop = (Shop) qr.query(conn, sql, new BeanHandler(Shop.class),params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            logger.error("ShopImpl-getShopById()-数据库操作失败！");
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("ShopImpl-getShopById()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return tmpShop;
    }
	
	/**
	 * 根据地区查询商户LIST
	 * <p>Title: getShopBySuburbId</p>
	 * <p>Description: </p>
	 * @param suburb_id
	 * @return
	 */
	@SuppressWarnings("unchecked")
    public static List<Shop> getShopBySuburbId(String suburb_id) {
        
		List<Shop> tmpShop = new ArrayList<Shop>();
        String sql = "select shops.*,suburbs.`name` suburb_name from shops,suburbs where shops.suburb_id=suburbs.id and suburb_id = ?";
        //System.out.println(sql);
        Object[] params = {suburb_id};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        
        try {
        	tmpShop = (List<Shop>) qr.query(conn, sql, new BeanListHandler(Shop.class),params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            logger.error("ShopImpl-getShopBySuburbId()-数据库操作失败！");
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("ShopImpl-getShopBySuburbId()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return tmpShop;
    }
	
	/**
	 * 根据分类id查询查询商户LIST
	 * <p>Title: getShopByCatalogId</p>
	 * <p>Description: </p>
	 * @param catalog_id
	 * @return
	 */
	@SuppressWarnings("unchecked")
    public static List<Shop> getShopByCatalogId(String catalog_id) {
        
		List<Shop> tmpShop = new ArrayList<Shop>();
        String sql = "select a.* from shops a,shop_catalog b where a.id=b.shop_id and b.catalog_id=?";
        //System.out.println(sql);
        Object[] params = {catalog_id};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        
        try {
        	tmpShop = (List<Shop>) qr.query(conn, sql, new BeanListHandler(Shop.class),params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            logger.error("ShopImpl-getShopByCatalogId()-数据库操作失败！");
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("ShopImpl-getShopByCatalogId()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return tmpShop;
    }
	
	//删除商铺
    public static int deleteShop(String id){
    	int flag = 0;
        
		String sql = "delete from shops where id=?;";
	    //System.out.println(sql);
	    Object[] params = {id};
	    Connection conn = new MyDbPool().getConnection();
	    QueryRunner qr = new QueryRunner();
	    try {
	        flag = qr.update(conn,sql, params);
	    } catch (SQLException e) {
	        // TODO Auto-generated catch block
	        logger.error("ShopImpl-deleteShop()-数据库操作失败！");
	        e.printStackTrace();
	    }finally{
	        try {
	            conn.close();
	        } catch (SQLException e) {
	            logger.error("ShopImpl-deleteShop()-连接关闭失败");
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	    }
	    if(flag!=0){
	    	logger.info("编号为"+id+"的商铺信息被删除！");
	    }
        return flag;
    }
    
  //根据ID查询分类信息
    @SuppressWarnings("unchecked")
	public static Shop queryShopById(String id){
        String sql = "";
        Shop shop = new Shop();
        sql = "select a.*,b.name suburb_name from shops a,suburbs b where a.suburb_id=b.id and a.id=?";
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        Object[] params = {id};
        try {
        	shop = (Shop) qr.query(conn, sql, new BeanHandler(Shop.class),params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("CatalogDTOImpl-queryCatalogById()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("CatalogDTOImpl-queryCatalogById()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return shop;
    }
}
