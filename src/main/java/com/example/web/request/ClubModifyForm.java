package com.example.web.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClubModifyForm {

	private int no;
	private String name;
	private String tel;
	private String zipcode;
	private String basicAddress;
	private String detailAddress;
	private double latitude;
	private double longitude;
	private String description;
	private String weekdaysOpenHours;
	private String weekendsOpenHours;
	private String closedDays;
	
	// 평일 영업시작 시간
	private String weekdaysStartTime;
	// 평일 영업종료 시간
	private String weekdaysEndTime;
	// 주말 영업시작 시간
	private String weekendsStartTime;
	// 주말 영업종료 시간
	private String weekendsEndTime;
}
