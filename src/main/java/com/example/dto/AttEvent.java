package com.example.dto;

import java.util.Date;

import com.example.utils.DateUtils;
import com.fasterxml.jackson.annotation.JsonIgnore;

public class AttEvent {
	
	// 응답으로 내려가지 않게 한다.
	@JsonIgnore
	private UserListAttDto userListAttDto;
	
	public String getId() {
		return String.valueOf(userListAttDto.getUserNo());
	}
	public Date getStart() {
		return DateUtils.textToDate(userListAttDto.getUserAttDate(), userListAttDto.getStartTime()); 
	}
	
	
	public boolean getAllDay() {
		return "Y".equals(userListAttDto.getMembership()); 
	}
	
	/*
	public String getClassStatus() {
		return userListAttDto.getClassStatus();
	}
	*/
}
