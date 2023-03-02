package com.example.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Alias("UserAttDetailDto")
@Getter
@Setter
public class UserAttDetailDto {
	
	private String userId;
	private String userName;
	private int userNo;
	private String userTel;
	private String userEmail;
	private String userGender;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date userAttDate;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date classAttDate;
	private String empName;
	private int programNo;
	private String membership;
	private String programName;

}
