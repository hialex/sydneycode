package com.sydenycode.po;

public class Catalog {
	//编号
	private int id;
	//分类名称
	private String name;
	//上一级地区id
	private int parent_id;
	//排序编号,2014-12-2
	private int order_id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getParent_id() {
		return parent_id;
	}
	public void setParent_id(int parentId) {
		parent_id = parentId;
	}
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int orderId) {
		order_id = orderId;
	}
	
}
