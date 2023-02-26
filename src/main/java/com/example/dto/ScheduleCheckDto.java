package com.example.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

/*
 * 달력에 표시할 정보를 제공하는 객체 
 */
@Alias("ScheduleCheckDto")
public class ScheduleCheckDto {

	private String id;
	private Date start;
	private Date end;
	private String title;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getStart() {
		return start;
	}
	public void setStart(Date start) {
		this.start = start;
	}
	public Date getEnd() {
		return end;
	}
	public void setEnd(Date end) {
		this.end = end;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
}
