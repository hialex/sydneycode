package com.sydenycode.po;

import java.sql.Timestamp;

public class Photo {
	//图片编号
	private int id;
	//图片分类编号
	private int category_id;
	
	//店铺id
	private int shop_id;
	
	//图片名称
	private String name;
	//文件名称
	private String filename;
	//图片说明
	private String intro;
	
	//图片来源
	//mobile.手机上传
	//web.后台上传
	private String source;
	
	//图片类型
	//网友晒图
	//
	private String type;
	
	//图片状态
	//0.未审核（默认）
	//1.已审核
	private int status;
	//上传者姓名
	private String author_name;
	//上传者ip
	private String author_ip;
	//上传时间
	private Timestamp add_time;
	//照片排序
	private int order_id;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCategory_id() {
		return category_id;
	}
	public void setCategory_id(int categoryId) {
		category_id = categoryId;
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
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
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
	public String getAuthor_name() {
		return author_name;
	}
	public void setAuthor_name(String authorName) {
		author_name = authorName;
	}
	public String getAuthor_ip() {
		return author_ip;
	}
	public void setAuthor_ip(String authorIp) {
		author_ip = authorIp;
	}
	public Timestamp getAdd_time() {
		return add_time;
	}
	public void setAdd_time(Timestamp addTime) {
		add_time = addTime;
	}
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int orderId) {
		order_id = orderId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	
	
}
