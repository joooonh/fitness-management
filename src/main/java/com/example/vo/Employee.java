package com.example.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("Employee")
@Getter
@Setter
public class Employee {

	private String id;
	private String name;
	private String password;
	private String email;
	private String tel;
	private String photo;
	private String zipcode;
	private String basicAddress;
	private String detailAddress;
	private Date createdDate;
	private Date updatedDate;
  
	private String status;
	private int fitnessNo;


}
