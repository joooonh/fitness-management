package com.example.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Alias("UserListAttDto")
@Getter
@Setter
public class UserListAttDto {
	
	private int userNo;
	private String userId;
	private String userName;
	private String userGender;
	private String userBirthday;
	private String userEmail;
	private String userTel;
	private Date createdDate;
	private String startTime;
	private String endTime;
	private Date userAttDate;
	private Date classAttDate;
	private int programNo;
	private String membership;
	private String programName;
	
	// 검색기능 객체
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date attDate;
	private String onlyMembership;
	private String programInfo;
	private String opt;
	private String keyword;
	
	// 번호 조회
	private String telInfo;
	
}
