package com.example.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import com.example.vo.Program;
import com.fasterxml.jackson.annotation.JsonIgnore;

/*
 * 달력에 표시할 정보를 제공하는 객체 
 */
@Alias("ScheduleCheckDto")
public class ScheduleCheckDto {

	@JsonIgnore
	private Program program;
	
	public String getId() {
		return String.valueOf(program.getNo());
	}
	public void setId(String id) {
		
	}
	public Date getStart() {
		return program.getStartDate();
	}
	public void setStart(Date start) {
		program.setStartDate(start);
	}
	public Date getEnd() {
		return program.getEndDate();
	}
	public void setEnd(Date end) {
		program.setEndDate(end);
	}
	public String getTitle() {
		return program.getName();
	}
	public void setTitle(String title) {
		program.setName(title);
	}
}
