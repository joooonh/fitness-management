package com.example.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("UserClassAttendance")
@Getter
@Setter
public class UserClassAttendance {

	private int userNo;
	private int programNo;
	private Date classAttDate;
}
