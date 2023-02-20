package com.example.web.request;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserClassAttRegisterForm {
		
	private int userNo;
	private String programName;
	private Date classAttDate;
}
