package com.sydenycode.mobile.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;

import com.sydenycode.mobile.dto.MSuburbShop;
import com.sydenycode.util.MyDbPool;

public class MSuburbShopImpl {
	
	static Logger logger = Logger.getLogger(MSuburbShopImpl.class.getName());
	
	//用于移动端显示suburb-shop数量
	//例如：Sydney  20
	//接受参数：catalog_id
    @SuppressWarnings("unchecked")
	public static List<MSuburbShop> queryAllMSuburbShops(int catalog_id){
        String sql = "";
        List<MSuburbShop> all = new ArrayList<MSuburbShop>();
        sql = "select d.id suburb_id,d.`name` suburb_name,c.id catalog_id,c.`name` catalog_name,count(a.id) total " +
        		"from shops a,shop_catalog b,catalogs c,suburbs d " +
        		"where a.id=b.shop_id " +
        		"and a.suburb_id=d.id " +
        		"and b.catalog_id = c.id " +
        		"and c.id=? " +
        		"GROUP BY d.`name` " +
        		"ORDER BY total desc,suburb_name asc";
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        Object[] params = {catalog_id};
        try {
        	
        	all = (List<MSuburbShop>) qr.query(conn, sql, new BeanListHandler(MSuburbShop.class),params);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("MSuburbImpl-queryAllMSuburbShops()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("MSuburbImpl-queryAllMSuburbShops()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return all;
    }
}
