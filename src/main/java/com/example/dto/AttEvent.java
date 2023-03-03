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
		/*System.out.println("ATT-DATE: " + userListAttDto.getUserAttDate());
		System.out.println("CLASS-DATE: " + userListAttDto.getClassAttDate());
		System.out.println("START-TIME: " + userListAttDto.getStartTime());*/
		
		if (userListAttDto.getClassAttDate() != null) {
			return DateUtils.textToDate(userListAttDto.getClassAttDate(), userListAttDto.getStartTime());
		} else {
			return DateUtils.textToDate(userListAttDto.getUserAttDate(), userListAttDto.getStartTime());			
		}
		
	}
	
	
	public String getTitle() {
		if(userListAttDto.getProgramName() != null) {
			return userListAttDto.getProgramName();
		}else {
			return userListAttDto.getMembership();
		}
	}
	
}
