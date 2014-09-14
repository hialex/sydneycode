package com.sydenycode.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;

import com.sydenycode.po.Catalog;
import com.sydenycode.util.MyDbPool;

public class CatalogImpl {
	
	static Logger logger = Logger.getLogger(CatalogImpl.class.getName());
	
	
	//添加分类
    public static int addCatalog(Catalog catalog){
        
        String sql = "insert into catalogs (" +
                "name," +
                "parent_id)"+" values(?,?);";
        //System.out.println(sql);
        Object[] params = {catalog.getName(),catalog.getParent_id()};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        int flag = 0;
        try {
            flag = qr.update(conn,sql, params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("CatalogImpl-addCatalog()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("CatalogImpl-addCatalog()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        //System.out.println(flag);
        return flag;
    }
    
    //编辑分类
    public static int editCatalog(Catalog catalog){
        
        String sql = "update catalogs set name=?,parent_id=? where id=?";
        //System.out.println(sql);
        Object[] params = {catalog.getName(),catalog.getParent_id(),catalog.getId()};
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        int flag = 0;
        try {
            flag = qr.update(conn,sql, params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("CatalogImpl-editCatalog()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("CatalogImpl-editCatalog()-连接关闭失败");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        //System.out.println(flag);
        return flag;
    }
    
    @SuppressWarnings("unchecked")
	public static List<Catalog> getCatalogListByParentId(String parent_id){
        String sql = "";
        List<Catalog> allCatalogs = new ArrayList<Catalog>();
        if("-1".equals(parent_id)) {
        	//获取所有分类
            sql = "select * from catalogs order by id";
        }else {
            sql = "select * from catalogs where parent_id = '"+parent_id+"'";
        }
        //System.out.println(sql);
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        //Object[] params = {area};
        try {
        	allCatalogs = (List<Catalog>) qr.query(conn, sql, new BeanListHandler(Catalog.class));
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("CatalogImpl-getCatalogListByParentId()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("CatalogImpl-getCatalogListByParentId()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return allCatalogs;
    }
    
    //解析前台传过来的字符串，解析成catalog_id数组
    public int[] getCatalogsFromJSON(String jsonString){
    	JSONArray array = JSONArray.fromObject(jsonString);
    	int[] catalog_ids = new int[array.size()];
		for (int i = 0; i < array.size(); i++) {
			//System.err.println(array.get(i).toString());
			catalog_ids[i] = array.getInt(i);
		}
    	
		return catalog_ids;
    }
    
    //删除分类
    public static int deleteCatalog(String id){
    	int flag = 0;
        //有下级分类不能删除
    	if(getCatalogListByParentId(id).size()>0){
    		flag = -1;
    	}else if(ShopImpl.getShopByCatalogId(id).size()>0){
    		//有对应商家不能删除
    		flag = -2;
    	}else{
    		String sql = "delete from catalogs where id=?;";
		    //System.out.println(sql);
		    Object[] params = {id};
		    Connection conn = new MyDbPool().getConnection();
		    QueryRunner qr = new QueryRunner();
		    try {
		        flag = qr.update(conn,sql, params);
		    } catch (SQLException e) {
		        // TODO Auto-generated catch block
		        logger.error("CatalogImpl-deleteCatalog()-数据库操作失败！");
		        e.printStackTrace();
		    }finally{
		        try {
		            conn.close();
		        } catch (SQLException e) {
		            logger.error("CatalogImpl-deleteCatalog()-连接关闭失败");
		            // TODO Auto-generated catch block
		            e.printStackTrace();
		        }
		    }
    	}
    	if(flag==1){
	    	logger.info("编号为"+id+"的分类被删除！");
	    }
        return flag;
    }
}
