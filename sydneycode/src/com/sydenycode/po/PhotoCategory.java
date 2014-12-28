package com.sydenycode.po;

public class PhotoCategory {
	private int id;
	private int catalog_id;
	private String catalog_name;
	private String name;
	private int order_id;
	private boolean default_display;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int orderId) {
		order_id = orderId;
	}
	public boolean isDefault_display() {
		return default_display;
	}
	public void setDefault_display(boolean defaultDisplay) {
		default_display = defaultDisplay;
	}
	
	
	
}
