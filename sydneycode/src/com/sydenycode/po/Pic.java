package com.sydenycode.po;

import java.sql.Timestamp;

public class Pic {
	private int id;
	private int shop_id;
	private String name;
	private Timestamp upload_time;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getShop_id() {
		return shop_id;
	}
	public void setShop_id(int shopId) {
		shop_id = shopId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getUpload_time() {
		return upload_time;
	}
	public void setUpload_time(Timestamp uploadTime) {
		upload_time = uploadTime;
	}
	
}
