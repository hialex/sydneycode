package com.sydenycode.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.opensymphony.xwork2.ActionSupport;

public class UploadFileAction extends ActionSupport implements ServletRequestAware{
	private static final long serialVersionUID = -4916835788291064269L;

	private HttpServletRequest request;
	public void setServletRequest(HttpServletRequest req) {
		this.request=req;
	}
	
	private JSONObject result;//返回的json
    Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
	
	private List<File> fileName;//这里的"fileName"一定要与表单中的文件域名相同
	private List<String> fileNameContentType;//格式同上"fileName"+ContentType
	private List<String> fileNameFileName;//格式同上"fileName"+FileName
	private String savePath;//文件上传后保存的路径
	
	String newsuffix = "";
	Random r = new Random();
	String nowTimeStr = ""; //保存当前时间
	
	public JSONObject getResult() {
		return result;
	}

	public void setResult(JSONObject result) {
		this.result = result;
	}
	
	public Map<String, Object> getJsonMap() {
		return jsonMap;
	}
	
	public List<File> getFileName() {
		return fileName;
	}

	public void setFileName(List<File> fileName) {
		this.fileName = fileName;
	}

	public List<String> getFileNameContentType() {
		return fileNameContentType;
	}

	public void setFileNameContentType(List<String> fileNameContentType) {
		this.fileNameContentType = fileNameContentType;
	}

	public List<String> getFileNameFileName() {
		return fileNameFileName;
	}

	public void setFileNameFileName(List<String> fileNameFileName) {
		this.fileNameFileName = fileNameFileName;
	}

	
	public String getSavePath() {
		//System.out.println(request.getSession().getServletContext().getRealPath("/images"));
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
		List<File> files=getFileName();
		for(int i=0;i<files.size();i++){
			String oldFileName = getFileNameFileName().get(i);
			
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
	        String newFileName = nowTimeStr + rannum + "." + newsuffix;
			FileOutputStream fos=new FileOutputStream(getSavePath()+"//"+newFileName);
			
			FileInputStream fis=new FileInputStream(getFileName().get(i));
			byte []buffers=new byte[1024];
			int len=0;
			while((len=fis.read(buffers))!=-1){
				fos.write(buffers,0,len);
			}
			tempMap.put("photo", newFileName);
			
		}
		result = JSONObject.fromObject(tempMap);//格式化result   一定要是JSONObject 
    	return SUCCESS;
	}
	
}
