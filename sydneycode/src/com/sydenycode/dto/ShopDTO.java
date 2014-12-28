package com.sydenycode.dto;

import java.sql.Timestamp;

import org.apache.struts2.json.annotations.JSON;

public class ShopDTO {
	private int shop_id;
	private String suburb_name;
	private String shop_name;
	private String[] catalog_names;
	//id
	private String root_catalog_name;
	private String root_catalog_id;
	//private String address;
	//private String tel;

	private Timestamp add_time;
	
	
	
	public String getRoot_catalog_id() {
		return root_catalog_id;
	}

	public void setRoot_catalog_id(String rootCatalogId) {
		root_catalog_id = rootCatalogId;
	}

	public String getRoot_catalog_name() {
		return root_catalog_name;
	}

	public void setRoot_catalog_name(String rootCatalogName) {
		root_catalog_name = rootCatalogName;
	}

	public int getShop_id() {
		return shop_id;
	}

	public void setShop_id(int shopId) {
		shop_id = shopId;
	}

	public String getSuburb_name() {
		return suburb_name;
	}

	public void setSuburb_name(String suburbName) {
		suburb_name = suburbName;
	}

	public String getShop_name() {
		return shop_name;
	}

	public void setShop_name(String shopName) {
		shop_name = shopName;
	}

	public String[] getCatalog_names() {
		return catalog_names;
	}

	public void setCatalog_names(String[] catalogNames) {
		catalog_names = catalogNames;
	}
	/**
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}
	*/
	@JSON(format="yyyy-MM-dd HH:mm:ss")
	public Timestamp getAdd_time() {
		return add_time;
	}

	public void setAdd_time(Timestamp addTime) {
		add_time = addTime;
	}

	
	
}
