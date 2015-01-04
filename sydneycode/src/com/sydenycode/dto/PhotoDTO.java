package com.sydenycode.dto;

import java.sql.Timestamp;

import org.apache.struts2.json.annotations.JSON;

public class PhotoDTO {
	private int id;
	private String filename;
	private int shop_id;
	private String shop_name;
	private int catalog_id;
	private String catalog_name;
	private String category_name;
	private String source;
	private int status;
	private Timestamp add_time;
	private String author_name;
	private String type;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
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
	public String getCatalog_name() {
		return catalog_name;
	}
	public void setCatalog_name(String catalogName) {
		catalog_name = catalogName;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String categoryName) {
		category_name = categoryName;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	@JSON(format="yyyy-MM-dd HH:mm:ss")
	public Timestamp getAdd_time() {
		return add_time;
	}
	public void setAdd_time(Timestamp addTime) {
		add_time = addTime;
	}
	public String getAuthor_name() {
		return author_name;
	}
	public void setAuthor_name(String authorName) {
		author_name = authorName;
	}
	public int getCatalog_id() {
		return catalog_id;
	}
	public void setCatalog_id(int catalogId) {
		catalog_id = catalogId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	
	
}
