package com.example.web.request;


import java.util.Date;

import javax.validation.constraints.NotBlank;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserAttRegisterForm {
	
	private String userTel;
	private int userNo;
	private String userName;
	private String startTime;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date userAttDate;
}
