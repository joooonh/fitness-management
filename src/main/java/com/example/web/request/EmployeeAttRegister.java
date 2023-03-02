package com.example.web.request;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EmployeeAttRegister {
	
	private String empId;
	private String empName;
	private String empTel;
	private String progName;
	private String startTime;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private String startDate;
}
