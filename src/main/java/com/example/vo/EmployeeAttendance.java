package com.example.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("EmployeeAttendance")
@Getter
@Setter
public class EmployeeAttendance {
	
	private String empId;
	private int progNo;
	private Date progAttDate;
}
