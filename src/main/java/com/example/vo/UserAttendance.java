package com.example.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("UserAttendance")
@Getter
@Setter
public class UserAttendance {
	
	private int userNo;
	private String startTime;
	private int attNo;
	private Date userAttDate;
}
