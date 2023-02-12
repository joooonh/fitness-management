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
	private int no;
	private String name;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	private String startHour;
	private String endHour;
	private int quota;
	private int requestCount;
	private int price;
	private String status;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date createdDate;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date updatedDate;
	private String employeeId;
	private String categoryNo;
	
	// 직원 정보
	private String employeeName;
	
	// 분류 정보
	private String categoryName;
	
	// 수업요일 정보
	private List<ProgramDay> days;
}
