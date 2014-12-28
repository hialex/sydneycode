package com.sydenycode.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;



public class SimpleDateUtil {

	// 短日期格式
	public static String DATE_FORMAT = "yyyy-MM-dd";

	// 长日期格式
	public static String TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";

	/**
	 * 将日期格式的字符串转换为长整型
	 * 
	 * @param date
	 * @param format
	 * @return
	 */
	public static long convert2long(String date, String format) {
		try {
			if (StringUtils.isNotBlank(date)) {
				if (StringUtils.isBlank(format))
					format = SimpleDateUtil.TIME_FORMAT;
				SimpleDateFormat sf = new SimpleDateFormat(format);
				return sf.parse(date).getTime();
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return 0l;
	}

	/**
	 * 将长整型数字转换为日期格式的字符串
	 * 
	 * @param time
	 * @param format
	 * @return
	 */
	public static String convert2String(long time, String format) {
		if (time > 0l) {
			if (StringUtils.isBlank(format))
				format = SimpleDateUtil.TIME_FORMAT;
			SimpleDateFormat sf = new SimpleDateFormat(format);
			Date date = new Date(time);
			return sf.format(date);
		}
		return "";
	}

	/**
	 * 获取当前系统的日期
	 * 
	 * @return
	 */
	public static long curTimeMillis() {
		return System.currentTimeMillis();
	}
	
	public static String getCurTimeString(){
		return convert2String(curTimeMillis(), null);
	}
	
	public static String getTimeVersionString(){
		return convert2String(curTimeMillis(), "yyyyMMddHHmm");
	}
	
	
	public static long getProcessTime(long processTime){
//		long hour = processTime/(60*60*1000);  
//		long minute = (processTime - hour*60*60*1000)/(60*1000);  
//		long second = (processTime - hour*60*60*1000 - minute*60*1000)/1000;
//		//long day = hour/24;
//		String retTimeString = hour+ "时" + minute + "分" + second+"秒";
		long retTime = processTime/1000;
		return retTime;
	}
}
