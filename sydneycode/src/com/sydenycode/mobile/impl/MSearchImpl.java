package com.sydenycode.mobile.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;

import com.sydenycode.impl.Shop_catalogImpl;
import com.sydenycode.mobile.dto.MSearchResutlShopDTO;
import com.sydenycode.util.MyDbPool;

public class MSearchImpl {
	
	static Logger logger = Logger.getLogger(MSearchImpl.class.getName());
	
	@SuppressWarnings("unchecked")
	public List<MSearchResutlShopDTO> getSearchResultShops(String catalog1,String catalog2,String suburb,String bh){
		
		String sql = "";
        List<MSearchResutlShopDTO> shops = new ArrayList<MSearchResutlShopDTO>();
        List<MSearchResutlShopDTO> retSearchResutlShops = new ArrayList<MSearchResutlShopDTO>();
        sql = "select distinct shops.id shop_id,shops.`name` shop_name,suburbs.`name` suburb_name " +
        		" from shops,catalogs,shop_catalog,suburbs,bussiness_hours" +
        		" where shops.id=shop_catalog.shop_id" +
        		" and catalogs.id=shop_catalog.catalog_id" +
        		" and shops.suburb_id=suburbs.id" +
        		" and shops.id=bussiness_hours.shop_id"+
        		getCatalogSQL(catalog1, catalog2)+
        		getSuburbSQL(suburb)+
        		getBhSQL(bh)+
        		" limit 10";
        		
        //System.out.println(sql);
        Connection conn = new MyDbPool().getConnection();
        QueryRunner qr = new QueryRunner();
        //Object[] params = {area};
        try {
        	shops = (List<MSearchResutlShopDTO>) qr.query(conn, sql, new BeanListHandler(MSearchResutlShopDTO.class));
        	for (MSearchResutlShopDTO searchResutlShopDTO: shops) {
				int shop_id = searchResutlShopDTO.getShop_id();
				searchResutlShopDTO.setCatalogs(Shop_catalogImpl.getCatalogNames(String.valueOf(shop_id)));
				retSearchResutlShops.add(searchResutlShopDTO);
			}
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            logger.error("MSearchImpl-getSearchResultShops()-数据库操作失败！");
            e.printStackTrace();
        }finally{
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("MSearchImpl-getSearchResultShops()-连接关闭失败！");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return retSearchResutlShops;
	}
	public String getCatalogSQL(String catalog1,String catalog2){
		String catalogWhereClause = "";
		if(catalog1==null||catalog1.equals("")||catalog2==null||catalog2.equals("")||catalog1.equals("all")){
			//一级分类不限
			//商铺分类不限制
			return catalogWhereClause;
		}else if(catalog2.equals("all")){
			//二级分类不限,限制条件为上级分类为一级分类
			catalogWhereClause += " and shop_catalog.catalog_id in (select id from catalogs where catalogs.parent_id="+catalog1+")";
		}else{
			catalogWhereClause += " and shop_catalog.catalog_id="+catalog2+"";
		}
		//System.out.println("catalogWhereClause"+catalogWhereClause);
		return catalogWhereClause;
	}
	public String getSuburbSQL(String suburb){
		String suburbWhereClause = "";
		if(suburb==null||suburb.equals("")||suburb.equals("all")){
			//地区不限制
			return suburbWhereClause;
		}else if(suburb.equals("hot")){
			//热门地区
			suburbWhereClause += " and suburbs.is_hot=1";
		}else if(suburb.equals("others")){
			suburbWhereClause += "suburbs.is_hot=0";
		}else{
			suburbWhereClause += " and suburbs.id="+suburb+"";
		}
		//System.out.println("suburbWhereClause"+suburbWhereClause);
		return suburbWhereClause;
	}
	public String getBhSQL(String bh){
		String bhWhereClause = "";
		if(bh==null||bh.equals("")){
			return bhWhereClause;
		}else{
			String[] arr_bh = bh.split(",");
			String day = arr_bh[0];
			String time = arr_bh[1];
			//设置时间限制标志
			boolean timeFlag = true;
			if(time.startsWith("-")||time.endsWith("-")){
				//时间为-:10或8:-或-:-
				timeFlag = false;
			}
			if(day.equals("不限")&&!timeFlag){
				//日期不限，时间不限
				return bhWhereClause;
			}
			if(day.equals("不限")&&timeFlag){
				//日期不限，时间限制
				bhWhereClause += " and bussiness_hours.start_time<=TIME_FORMAT('"+time+"','%H:%i:%s') and bussiness_hours.end_time>=TIME_FORMAT('"+time+"','%H:%i:%s')";
			}
			if((!day.equals("不限"))&!timeFlag){
				//日期限制，时间不限
				bhWhereClause += " and bussiness_hours.weekday="+convertWeekNum(day)+" and bussiness_hours.is_open=1";
			}
			if((!day.equals("不限"))&&timeFlag){
				//日期限制，时间限制
				bhWhereClause += " and bussiness_hours.weekday="+convertWeekNum(day)+" andbussiness_hours.start_time<=TIME_FORMAT('"+time+"','%H:%i:%s') and bussiness_hours.end_time>=TIME_FORMAT('"+time+"','%H:%i:%s')";
			}
		}
		//System.out.println("bhWhereClause"+bhWhereClause);
		return bhWhereClause;
	}
	public int convertWeekNum(String day){
		int ret = 0;
		if(day.equals("Mon")){
			ret = 1;
		}else if(day.equals("Tues")){
			ret = 2;
		}else if(day.equals("Wed")){
			ret = 3;
		}else if(day.equals("Thur")){
			ret = 4;
		}else if(day.equals("Fri")){
			ret = 5;
		}else if(day.equals("Sat")){
			ret = 6;
		}else if(day.equals("Sun")){
			ret = 7;
		}
		return ret;
	}
	
}
