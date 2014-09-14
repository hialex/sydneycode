package com.sydenycode.util;

import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class TimeUtils {
	
	public static Time getTime(String s){
		Date d ;
		Time time = new Time(System.currentTimeMillis());
		SimpleDateFormat sdFormat = new SimpleDateFormat("h:mm a",Locale.US);
		try {
			d = (Date) sdFormat.parse(s);
			time = new Time(d.getTime());
			//System.out.println(time);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return time;
	}
}
