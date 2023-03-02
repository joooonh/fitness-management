package com.example.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Alias("EmployeeAttDto")
@Getter
@Setter
public class EmployeeAttDto {
	
	private String id;
	private String name;
	private String email;
	private String tel;
	private String photo;
	private int ziocode;
	private String basicAddress;
	private String detailAddress;
	private String empStatus;
	private String progName;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date progAttDate;
	private int progNo;
}
