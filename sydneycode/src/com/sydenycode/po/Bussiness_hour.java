package com.sydenycode.po;


public class Bussiness_hour {
	private int id;
	private int shop_id;
	private int weekday;
	private boolean is_open;
	private boolean is_need_book;
	private java.sql.Time start_time;
	private java.sql.Time end_time;
	
	
	
	public boolean isIs_need_book() {
		return is_need_book;
	}
	public void setIs_need_book(boolean isNeedBook) {
		is_need_book = isNeedBook;
	}
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
	public int getWeekday() {
		return weekday;
	}
	public void setWeekday(int weekday) {
		this.weekday = weekday;
	}
	public boolean isIs_open() {
		return is_open;
	}
	public void setIs_open(boolean isOpen) {
		is_open = isOpen;
	}
	public java.sql.Time getStart_time() {
		return start_time;
	}
	public void setStart_time(java.sql.Time startTime) {
		start_time = startTime;
	}
	public java.sql.Time getEnd_time() {
		return end_time;
	}
	public void setEnd_time(java.sql.Time endTime) {
		end_time = endTime;
	}
	
	
}
