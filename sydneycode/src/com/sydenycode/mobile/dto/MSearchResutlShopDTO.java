package com.sydenycode.mobile.dto;

import java.util.List;

import com.sydenycode.po.Catalog;

public class MSearchResutlShopDTO {
	
	private int shop_id;
	private String shop_name;
	private String suburb_name;
	private List<Catalog> catalogs;
	
	
	public String getSuburb_name() {
		return suburb_name;
	}
	public void setSuburb_name(String suburbName) {
		suburb_name = suburbName;
	}
	public int getShop_id() {
		return shop_id;
	}
	public void setShop_id(int shopId) {
		shop_id = shopId;
	}
	public String getShop_name() {
		return shop_name;
	}
	public void setShop_name(String shopName) {
		shop_name = shopName;
	}
	public List<Catalog> getCatalogs() {
		return catalogs;
	}
	public void setCatalogs(List<Catalog> catalogs) {
		this.catalogs = catalogs;
	}
	
	
	
}
