package com.example.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Alias("ConsultingHistoryDto")
@Getter
@Setter
public class ConsultingHistoryDto {

	private String no;				// visitant
	private String empName;			// employees
	private String programName;		// programs
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date reservationDate;
	private String reservationTime;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date createdDate;
	private Date updatedDate;
	private String status;
	
}
