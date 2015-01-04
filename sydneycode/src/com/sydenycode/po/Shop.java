package com.sydenycode.po;

import java.sql.Timestamp;

public class Shop {
	private int id;
	private int suburb_id;
	private String suburb_name;
	private String addr;
	private String name;
	private String mobile;
	private String tel;
	private String weixin;
	private String weibo;
	private String weibo_link;
	private String momo;
	private String email;
	private String website;
	private String facebook;
	private String facebook_link;
	private String instagram;
	private String instagram_link;
	private String qq;
	private String twitter;
	private String twitter_link;
	private String youtube;
	private String youtube_link;
	private String intro;
	private int score;
	private Timestamp add_time;
	private boolean is_takeout;
	private String takeout_time;
	private String takeout_route;
	private int top_id;
	private int root_catalog_id;
	
	public int getRoot_catalog_id() {
		return root_catalog_id;
	}
	public void setRoot_catalog_id(int rootCatalogId) {
		root_catalog_id = rootCatalogId;
	}
	public int getTop_id() {
		return top_id;
	}
	public void setTop_id(int topId) {
		top_id = topId;
	}
	public String getTakeout_route() {
		return takeout_route;
	}
	public void setTakeout_route(String takeoutRoute) {
		takeout_route = takeoutRoute;
	}
	public boolean isIs_takeout() {
		return is_takeout;
	}
	public void setIs_takeout(boolean isTakeout) {
		is_takeout = isTakeout;
	}
	public String getTakeout_time() {
		return takeout_time;
	}
	public void setTakeout_time(String takeoutTime) {
		takeout_time = takeoutTime;
	}
	public String getFacebook_link() {
		return facebook_link;
	}
	public void setFacebook_link(String facebookLink) {
		facebook_link = facebookLink;
	}
	public String getInstagram_link() {
		return instagram_link;
	}
	public void setInstagram_link(String instagramLink) {
		instagram_link = instagramLink;
	}
	public String getTwitter_link() {
		return twitter_link;
	}
	public void setTwitter_link(String twitterLink) {
		twitter_link = twitterLink;
	}
	public String getYoutube_link() {
		return youtube_link;
	}
	public void setYoutube_link(String youtubeLink) {
		youtube_link = youtubeLink;
	}
	public String getInstagram() {
		return instagram;
	}
	public void setInstagram(String instagram) {
		this.instagram = instagram;
	}
	public String getWeibo_link() {
		return weibo_link;
	}
	public void setWeibo_link(String weiboLink) {
		weibo_link = weiboLink;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSuburb_id() {
		return suburb_id;
	}
	public void setSuburb_id(int suburbId) {
		suburb_id = suburbId;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getWeixin() {
		return weixin;
	}
	public void setWeixin(String weixin) {
		this.weixin = weixin;
	}
	public String getWeibo() {
		return weibo;
	}
	public void setWeibo(String weibo) {
		this.weibo = weibo;
	}
	public String getMomo() {
		return momo;
	}
	public void setMomo(String momo) {
		this.momo = momo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getFacebook() {
		return facebook;
	}
	public void setFacebook(String facebook) {
		this.facebook = facebook;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public Timestamp getAdd_time() {
		return add_time;
	}
	public void setAdd_time(Timestamp addTime) {
		add_time = addTime;
	}

	public String getSuburb_name() {
		return suburb_name;
	}
	public void setSuburb_name(String suburbName) {
		suburb_name = suburbName;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getTwitter() {
		return twitter;
	}
	public void setTwitter(String twitter) {
		this.twitter = twitter;
	}
	public String getYoutube() {
		return youtube;
	}
	public void setYoutube(String youtube) {
		this.youtube = youtube;
	}
	
}
