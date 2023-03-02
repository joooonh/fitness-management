package com.example.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {


	private static SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	private static SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");

	public static Date textToDate(Date date) {
		return textToDate(date, "00:00");
	}


	public static Date textToDate(Date date, String time) {
		try {
			if (time == null) {
				return sdf1.parse(sdf2.format(date) + " 00:00");
			}
			return sdf1.parse(sdf2.format(date) + " " + time);
		} catch (ParseException ex) {
			throw new RuntimeException(ex);
		}
	}
}
