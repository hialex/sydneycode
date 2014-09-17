package com.sydenycode.mobile.dto;

public class MSuburbShop {
	//用于移动端显示suburb-shop数量
	//例如：Sydney  20
	private int suburb_id;
	private String suburb_name;
	private int catalog_id;
	private String catalog_name;
	private int total;
	public int getSuburb_id() {
		return suburb_id;
	}
	public void setSuburb_id(int suburbId) {
		suburb_id = suburbId;
	}
	public String getSuburb_name() {
		return suburb_name;
	}
	public void setSuburb_name(String suburbName) {
		suburb_name = suburbName;
	}
	public int getCatalog_id() {
		return catalog_id;
	}
	public void setCatalog_id(int catalogId) {
		catalog_id = catalogId;
	}
	public String getCatalog_name() {
		return catalog_name;
	}
	public void setCatalog_name(String catalogName) {
		catalog_name = catalogName;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
	
}
