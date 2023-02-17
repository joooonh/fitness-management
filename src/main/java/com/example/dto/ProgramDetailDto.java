package com.example.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("ProgramDetailDto")
@Getter
@Setter
public class ProgramDetailDto {
	
	private int programNo;
	private String programName;
	private Date startDate;
	private Date endDate;
	private int quota;
	private int requestCount;
	private String programStatus;
	private	String employeeId;
	private int categoryNo;
	private String openDay;
}
