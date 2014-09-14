package com.sydenycode.po;

public class Suburb {
	//编号
	private int id;
	//地区名称
	private String name;
	//上一级ID
	private int parent_id;
	//是否常用地区
	private boolean is_hot;
	public boolean isIs_hot() {
		return is_hot;
	}
	public void setIs_hot(boolean isHot) {
		is_hot = isHot;
	}
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
	
}
