package com.example.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("UserListAttDto")
public class UserListAttDto {
	
	private int userNo;
	private String userId;
	private String userName;
	private String userGender;
	private String userBirthday;
	private String userEmail;
	private String userTel;
	private Date createdDate;
	private String StartTime;
	private String EndTime;
	private Date classAttDate;
	private int programNo;
	private String programName;
	
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public String getUserBirthday() {
		return userBirthday;
	}
	public void setUserBirthday(String userBirthday) {
		this.userBirthday = userBirthday;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserTel() {
		return userTel;
	}
	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	public String getStartTime() {
		return StartTime;
	}
	public void setStartTime(String startTime) {
		StartTime = startTime;
	}
	public String getEndTime() {
		return EndTime;
	}
	public void setEndTime(String endTime) {
		EndTime = endTime;
	}
	public Date getClassAttDate() {
		return classAttDate;
	}
	public void setClassAttDate(Date classAttDate) {
		this.classAttDate = classAttDate;
	}
	public int getProgramNo() {
		return programNo;
	}
	public void setProgramNo(int programNo) {
		this.programNo = programNo;
	}
	public String getProgramName() {
		return programName;
	}
	public void setProgramName(String programName) {
		this.programName = programName;
	}
	
	
	
}
