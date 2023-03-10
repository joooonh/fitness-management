package com.example.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Alias("ClassRegistrationDto")
@Getter
@Setter
public class ClassRegistrationDto {

	// 수업등록이력 정보
	private int programNo;
	private int classNo;
	private int userNo;
	private String paymentStatus;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date completedDate;
	
	// fitness_programs
	private String programName;	// ahin 추가
	
	// 사용자 정보
	private String userName;
	private String userTel;
	private String userId;	// ahin 추가
	private String deleted; // ahin 추가
}
