package com.example.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import com.example.utils.DateUtils;
import com.example.vo.Employee;
import com.example.vo.Program;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Alias("EmployeeScheduleDto")
public class EmployeeScheduleDto {

	@JsonIgnore
	private Employee employee;
	private Program program;
	private String programOpenDays;
	
	public String getId() {
		return String.valueOf(employee.getId());
	}
	
	public Date getStart() {
		return DateUtils.textToDate(program.getStartDate(), program.getStartHour());
	}
	
	public Date getEnd() {
		return DateUtils.textToDate(program.getEndDate(), program.getEndHour());
	}
	
	public String getTitle() {
		return program.getName();
	}

	public String getProgramOpenDays() {
		return programOpenDays;
	}

	public void setProgramOpenDays(String programOpenDays) {
		this.programOpenDays = programOpenDays;
	}

	
	
}
