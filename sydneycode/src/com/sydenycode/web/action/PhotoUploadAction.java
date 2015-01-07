package com.sydenycode.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;
import net.sf.json.JSONObject;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.sydenycode.impl.PhotoImpl;
import com.sydenycode.po.Photo;
import com.sydenycode.po.User;
import com.sydenycode.util.CONSTANT;
import com.sydenycode.util.Utils;

public class PhotoUploadAction extends ActionSupport implements ServletRequestAware{
	private static final long serialVersionUID = -4916835788291064269L;

	private HttpServletRequest request;
	public void setServletRequest(HttpServletRequest req) {
		this.request=req;
	}
	
	private JSONObject result;//返回的json
    Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
	//上传照片带来的其他参数
    private Photo photo;
    
	private File file;//jsp中input name
	private String fileContentType;//上传文件ContentType
	private String fileFileName;//上传文件名称
	private String savePath;//文件上传后保存的路径
	private String thumbPath;//缩略图上传后保存的路径
	
	String newsuffix = "";
	Random r = new Random();
	String nowTimeStr = ""; //保存当前时间
	

	public Photo getPhoto() {
		return photo;
	}

	public void setPhoto(Photo photo) {
		this.photo = photo;
	}

	public JSONObject getResult() {
		return result;
	}

	public void setResult(JSONObject result) {
		this.result = result;
	}
	
	public Map<String, Object> getJsonMap() {
		return jsonMap;
	}
	
	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}
	
	

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}
	
	
	
	public String getThumbPath() {
		return request.getSession().getServletContext().getRealPath(thumbPath);
	}

	public void setThumbPath(String thumbPath) {
		this.thumbPath = thumbPath;
	}

	public String getSavePath() {
		//System.out.println(request.getSession().getServletContext().getRealPath("D:/Data"));
		return request.getSession().getServletContext().getRealPath(savePath);
//		return "D:/"+savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}
	@Override
	public String execute() throws Exception {
		Map<String, Object> tempMap = new HashMap<String, Object>();//定义map
		
		File dir=new File(getSavePath());
		if(!dir.exists()){
			dir.mkdirs();
		}
		File dir2=new File(getThumbPath());
		if(!dir2.exists()){
			dir2.mkdirs();
		}
		//获取原文件名称
		
		String oldFileName = getFileFileName();
		
		//截取原后缀
		if((oldFileName != null)&&(oldFileName.length()>0))
		{
			int dot = oldFileName.lastIndexOf(".");
			if((dot >-1) && (dot < (oldFileName.length() - 1)))
			{
				 newsuffix = oldFileName.substring(dot + 1);
			}
		}
		//生成随机文件名：当前年月日时分秒+五位随机数（为了在实际项目中防止文件同名而进行的处理）  
        int rannum = (int) (r.nextDouble() * (99999 - 10000 + 1)) + 10000; //获取随机数
        SimpleDateFormat sDateFormat = new SimpleDateFormat("yyyyMMddHHmmss"); //时间格式化的格式
        nowTimeStr = sDateFormat.format(new Date()); //当前时间
        String newFileName = nowTimeStr + rannum + "_"+photo.getShop_id()+"." + newsuffix;
        //写入磁盘文件
		FileOutputStream fos=new FileOutputStream(getSavePath()+"//"+newFileName);
		FileInputStream fis=new FileInputStream(getFile());
		byte []buffers=new byte[1024];
		int len=0;
		while((len=fis.read(buffers))!=-1){
			fos.write(buffers,0,len);
		}
		//System.out.println(request.getSession().getServletContext().getRealPath("images/watermarker.png"));
		//添加水印
		Thumbnails.of(getSavePath()+"//"+newFileName)
		.watermark(Positions.BOTTOM_RIGHT, ImageIO.read(new File(request.getSession().getServletContext().getRealPath("images/watermarker.png"))),0.5f)
		.scale(1.0f)
		.toFile(getSavePath()+"//"+newFileName);
		//生成缩略图
		Thumbnails.of(getSavePath()+"//"+newFileName)
		.size(130, 100)
		.toFile(getThumbPath()+"//"+newFileName);
		
		//补全值
		photo.setFilename(newFileName);
		if("web".equals(photo.getSource())){
			//后台上传，默认已审核
			photo.setStatus(1);
			photo.setType(CONSTANT.OFFICIALPHOTOS);
			//后台上传，补全author信息
			Map<String, Object> session = ActionContext.getContext().getSession();
			User user = (User) session.get("user");
			if(user!=null){
				photo.setAuthor_name(user.getNickname());
			}
		}else{
			photo.setOrder_id(0);
			photo.setType(CONSTANT.FANSUPLOADPHOTOS);
			if("".equals(photo.getAuthor_name())||photo.getAuthor_name()==null){
				photo.setAuthor_name(CONSTANT.ANONYMOUSAUTHOR);
			}
		}
		photo.setAuthor_ip(Utils.getIpAddr(request));
		photo.setAdd_time(new Timestamp(new Date().getTime()));
		//存入数据表
		int flag = PhotoImpl.addPhoto(photo);
		//返回页面信息
		tempMap.put("oldName", oldFileName);
		tempMap.put("newName", newFileName);
		if(flag==1){
			tempMap.put("status", flag);
		}
		
		result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
	}
	
}
