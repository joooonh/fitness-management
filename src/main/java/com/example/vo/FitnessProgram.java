package com.example.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("FitnessProgram")
@Getter
@Setter
public class FitnessProgram {

	private int no;
	private String name;
	private Date startDate;
	private Date endDate;
	private String startHour;
	private String endHour;
	private int quota;
	private int requestCount;
	private String status;
	private Date createdDate;
	private Date updatedDate;
	private String employeeId;
	private String programCtegoryNo;
}
