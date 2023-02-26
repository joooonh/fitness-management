package com.example.web.request;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserClassAttRegisterForm {
		
	private int userNo;
	private int programNo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date classAttDate;
}
