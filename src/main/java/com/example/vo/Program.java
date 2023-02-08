package com.example.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("Program")
@Getter
@Setter
public class Program {

	private String no;
	private String name;
	private Date startDate;
	private Date endDate;
	private String startHour;
	private String endHour;
	private String quota;
	private String requestCount;
	private String price;
	private String status;
	private Date createdDate;
	private Date updatedDate;
	private String empId;
	private String categoryNo;	
}
