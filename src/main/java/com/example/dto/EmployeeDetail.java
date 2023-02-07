package com.example.dto;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.example.vo.EmployeeRole;

import lombok.Getter;
import lombok.Setter;

@Alias("EmployeeDetail")
@Getter
@Setter
public class EmployeeDetail {

	// 직원 정보
	private String id;
	private String name;
	private String password;
	private String email;
	private String tel;
	private String photo;
	private String zipcode;
	private String basicAddress;
	private String detailAddress;
	private String status;
	private Date createdDate;
	private Date updatedDate;
	private int fitnessNo;
	// 직원 권한
	private List<EmployeeRole> employeeRole;
}
