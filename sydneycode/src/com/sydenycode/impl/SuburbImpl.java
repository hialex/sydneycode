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

import com.sydenycode.po.Suburb;
import com.sydenycode.util.MyDbPool;

public class SuburbImpl {
	
	static Logger logger = Logger.getLogger(SuburbImpl.class.getName());
	
	//添加地区
    public static int addSuburb(Suburb suburb){
        String sql = "insert into suburbs (" +
                "name," +
                "parent_id,is_hot)"+" values(?,?,?);";
        //System.out.println(sql);
        Object[] params = {suburb.getName(),suburb.getParent_id(),suburb.isIs_hot()};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        int flag = 0;
        try {
            flag = qr.update(conn,sql, params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("SururbImpl-addSuburb()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("SururbImpl-addSuburb()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        //System.out.println(flag);
        return flag;
    }
    
    //根据父节点id获取地区列表
    @SuppressWarnings("unchecked")
	public static List<Suburb> getSuburbListByParentId(String parent_id,String from,String rootId){
        String sql = "";
        List<Suburb> allSuburbs = new ArrayList<Suburb>();
        if("-1".equals(parent_id)) {
        	//获取所有地区
            sql = "select * from suburbs  order by name asc;";
        }else {
        	if(from.equals("mobile")){
        		sql = "select distinct suburbs.id,suburbs.name " +
        				"from suburbs,shops,shop_catalog,(SELECT * FROM catalogs WHERE FIND_IN_SET(id, getChildList("+rootId+")) )c "  +
        				"where suburbs.id=shops.suburb_id " +
        				"and shops.id=shop_catalog.shop_id "+
        				"and shop_catalog.catalog_id=c.id "+
        				"and suburbs.parent_id = '"+parent_id+"' " +
        				"order by suburbs.name asc;";
        	}else{
        		sql = "select * from suburbs where parent_id = '"+parent_id+"' order by name asc;";
        	}
        }
        //System.out.println(sql);
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        //Object[] params = {area};
        try {
        	allSuburbs = (List<Suburb>) qr.query(conn, sql, new BeanListHandler(Suburb.class));
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("SururbImpl-getSuburbListByParentId()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("SururbImpl-getSuburbListByParentId()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return allSuburbs;
    }
    
    //获取热门地区
    @SuppressWarnings("unchecked")
	public static List<Suburb> getHotSuburbList(String parent_id,String from,String rootId){
        String sql = "";
        List<Suburb> allHotSuburbs = new ArrayList<Suburb>();
        if(from.equals("mobile")){
    		sql = "select distinct suburbs.id,suburbs.name " +
	    				"from suburbs,shops,shop_catalog,(SELECT * FROM catalogs WHERE FIND_IN_SET(id, getChildList("+rootId+")) )c " +
    				"where suburbs.id=shops.suburb_id " +
    				"and shops.id=shop_catalog.shop_id "+
    				"and shop_catalog.catalog_id=c.id "+
    				"and suburbs.is_hot=1 " +
    				"order by suburbs.name asc";
    	}else{
    		sql = "select * from suburbs where is_hot=1  order by name asc";
    	}
        //System.out.println(sql);
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        //Object[] params = {area};
        try {
        	allHotSuburbs = (List<Suburb>) qr.query(conn, sql, new BeanListHandler(Suburb.class));
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("SururbImpl-getHotSuburbList()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("SururbImpl-getHotSuburbList()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return allHotSuburbs;
    }
    
  //获取地区总量
    public static int getTotal(){
    	String sql = "";
        int total = -1;
        sql = "select count(*) total from suburbs a where a.parent_id<>0;";
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        //Object[] params = {area};
        try {
            Map<String,Object> map = (Map<String,Object>) qr.query(conn, sql, new MapHandler());
            total = Integer.parseInt(map.get("total").toString());
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("SururbImpl-getTotal()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("SururbImpl-getTotal()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return total;
    }
    
  //查询所有地区信息
    @SuppressWarnings("unchecked")
	public static List<Suburb> queryAllSuburbs(){
        String sql = "";
        List<Suburb> allSuburbs = new ArrayList<Suburb>();
        sql = "select * from suburbs a where a.parent_id<>0 order by name asc";
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        //Object[] params = {area};
        try {
        	
        	allSuburbs = (List<Suburb>) qr.query(conn, sql, new BeanListHandler(Suburb.class));
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("SururbImpl-queryAllSuburbs()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("SururbImpl-queryAllSuburbs()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return allSuburbs;
    }
    
    //删除地区
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
    
  //根据ID查询地区信息
    @SuppressWarnings("unchecked")
	public static Suburb querySuburbById(String id){
        String sql = "";
        Suburb suburb = new Suburb();
        sql = "select * from suburbs where id=?";
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        Object[] params = {id};
        try {
        	suburb = (Suburb) qr.query(conn, sql, new BeanHandler(Suburb.class),params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("CatalogDTOImpl-querySuburbById()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("CatalogDTOImpl-querySuburbById()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return suburb;
    }
    
  //编辑地区
    public static int editSuburb(Suburb suburb){
        
        String sql = "update suburbs set name=?,parent_id=?,is_hot=? where id=?";
        //System.out.println(sql);
        Object[] params = {suburb.getName(),suburb.getParent_id(),suburb.isIs_hot(),suburb.getId()};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        int flag = 0;
        try {
            flag = qr.update(conn,sql, params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("CatalogImpl-editSuburb()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("CatalogImpl-editSuburb()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        //System.out.println(flag);
        return flag;
    }
}
