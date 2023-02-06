package com.example.web.request;

import java.util.Date;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EmployeeModifyForm {

	private String id;
	private String name;
	private String password;
	private String email;
	private String tel;
	private String zipcode;
	private String basicAddress;
	private String detailAddress;
	private String status;
	private Date updatedDate;
	private int fitnessNo;
	

}
