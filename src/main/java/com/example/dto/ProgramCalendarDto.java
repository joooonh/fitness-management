package com.example.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("ProgramCalendarDto")
@Getter
@Setter
public class ProgramCalendarDto {
	private String employeeId;
	private String employeeName;
	private int programNo;
	private String programName;
	private Date startDate;
	private Date endDate;
	private String startHour;
	private String endHour;
	private String openDay;
}
