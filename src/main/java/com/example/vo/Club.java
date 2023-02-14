package com.example.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("Club")
@Getter
@Setter
public class Club {

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
	private Date createdDate;
	private Date updatedDate;
}
