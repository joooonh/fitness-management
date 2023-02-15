package com.example.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("FitnessVisitant")
@Getter
@Setter
public class FitnessVisitant {

	private String no;
	private Date reservationDate;
	private String reservationTime;
	private String purpose;
	private String content;
	private String status;
	private Date createdDate;
	private Date updatedDate;
	private int userNo;
	private int programNo;
	private String empId;
	
}
