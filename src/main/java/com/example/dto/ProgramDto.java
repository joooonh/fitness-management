package com.example.dto;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.example.vo.ProgramDay;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Alias("ProgramDto")
@Getter
@Setter
public class ProgramDto {

	// 프로그램 정보
	private String no;
	private String name;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	private String startHour;
	private String endHour;
	private String quota;
	private String requestCount;
	@JsonFormat(pattern = "#,###")
	private String price;
	private String status;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date createdDate;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date updatedDate;
	private String empId;
	private String categoryNo;	
	
	// 직원 정보
	private String empName;
	
	// 분류 정보
	private String categoryName;
	
	// 수업요일 정보
	private List<ProgramDay> days;
}
