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

import com.sydenycode.dto.CatalogDTO;
import com.sydenycode.util.MyDbPool;

public class CatalogDTOImpl {
	
	static Logger logger = Logger.getLogger(CatalogDTOImpl.class.getName());
	
	//获取分类总量
    public static int getTotal(){
    	String sql = "";
        int total = -1;
        sql = "select count(*) total from catalogs a,catalogs b where a.parent_id=b.id ;";
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        //Object[] params = {area};
        try {
            Map<String,Object> map = (Map<String,Object>) qr.query(conn, sql, new MapHandler());
            total = Integer.parseInt(map.get("total").toString());
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("CatalogDTOImpl-getTotal()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("CatalogDTOImpl-getTotal()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return total;
    }
    
    //查询所有分类信息
    @SuppressWarnings("unchecked")
	public static List<CatalogDTO> queryAllCatalogs(){
        String sql = "";
        List<CatalogDTO> allCatalogs = new ArrayList<CatalogDTO>();
        sql = "select a.id ,a.name name,a.parent_id parentId,b.name parentName,a.order_id orderId from catalogs a,catalogs b where a.parent_id=b.id order by a.parent_id asc,a.id asc";
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        //Object[] params = {area};
        try {
        	
        	allCatalogs = (List<CatalogDTO>) qr.query(conn, sql, new BeanListHandler(CatalogDTO.class));
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("CatalogDTOImpl-queryAllCatalogs()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("CatalogDTOImpl-queryAllCatalogs()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return allCatalogs;
    }
    
    //根据ID查询分类信息
    @SuppressWarnings("unchecked")
	public static CatalogDTO queryCatalogById(String id){
        String sql = "";
        CatalogDTO catalog = new CatalogDTO();
        sql = "select a.id ,a.name name,a.parent_id parentId,b.name parentName,a.order_id orderId from catalogs a,catalogs b where a.parent_id=b.id and a.id=?";
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        Object[] params = {id};
        try {
        	catalog = (CatalogDTO) qr.query(conn, sql, new BeanHandler(CatalogDTO.class),params);
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
        return catalog;
    }
}
