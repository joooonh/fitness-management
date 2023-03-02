package com.example.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;

import com.example.vo.Program;

@Alias("ProgramScheduleDto")
public class ProgramScheduleDto {
	
	private String id;
	private String employeeName;
	private String programName;
	private String programNo;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getProgramName() {
		return programName;
	}
	public void setProgramName(String programName) {
		this.programName = programName;
	}
	public String getProgramNo() {
		return programNo;
	}
	public void setProgramNo(String programNo) {
		this.programNo = programNo;
	}
	
	
	
}
