package com.sydenycode.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ArrayListHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.log4j.Logger;

import com.sydenycode.dto.ShopDTO;
import com.sydenycode.util.MyDbPool;

public class ShopDTOImpl {
	
	static Logger logger = Logger.getLogger(ShopDTOImpl.class.getName());
	
	//获取地区客户总量
    public static int getTotal(){
    	String sql = "";
        int total = -1;
//        sql = "select suburbs.`name`,shops.id,shops.`name`,shops.addr,shops.tel,shops.add_time"+
//        		" from shops,suburbs"+
//        		" where shops.suburb_id = suburbs.id";
        sql = "select count(*)total from shops,suburbs where shops.suburb_id = suburbs.id";
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        //Object[] params = {area};
        try {
            Map<String,Object> map = (Map<String,Object>) qr.query(conn, sql, new MapHandler());
            total = Integer.parseInt(map.get("total").toString());
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("ShopDTOImpl-getTotal()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("ShopDTOImpl-getTotal()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return total;
    }
    
    //查询所有商铺信息
    @SuppressWarnings("unchecked")
	public static List<ShopDTO> queryAllShops(){
        String sql = "";
        List<ShopDTO> allShops = new ArrayList<ShopDTO>();
        sql = "select shops.id shop_id, suburbs.`name` suburb_name,shops.`name` shop_name,shops.add_time"+
		" from shops,suburbs"+
		" where shops.suburb_id = suburbs.id order by shops.add_time desc,shop_id asc";
        /*
         *  sql = "select shops.id shop_id, suburbs.`name` suburb_name,shops.`name` shop_name,shops.addr address,shops.tel,shops.add_time"+
				" from shops,suburbs"+
				" where shops.suburb_id = suburbs.id order by shops.add_time desc,shop_id asc";
         * 
         */
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        //Object[] params = {area};
        try {
        	//获取除分类信息外的其他字段内容
        	allShops = (List<ShopDTO>) qr.query(conn, sql, new BeanListHandler(ShopDTO.class));
        	//获取分类信息并填充
        	for (ShopDTO s : allShops) {
				int id = s.getShop_id();
				String tmpSql = "select b.`name` from shop_catalog a ,catalogs b where a.shop_id='"+ id +"' and a.catalog_id = b.id";
				List<Object[]> catalog_names_list = (qr.query(conn, tmpSql, new ArrayListHandler())); 
				String[] names = new String[catalog_names_list.size()];
				for(int i=0;i<catalog_names_list.size();i++){
					names[i] = (String) (catalog_names_list.get(i))[0];
				}
				s.setCatalog_names(names);
				//System.out.println(s.getAdd_time());
        	}
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("ShopDTOImpl-queryAllShops()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("ShopDTOImpl-queryAllShops()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return allShops;
    }
}
