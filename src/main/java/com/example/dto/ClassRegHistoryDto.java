package com.example.dto;

import java.sql.Date;
import java.util.List;
import java.util.StringJoiner;

import org.apache.ibatis.type.Alias;

import com.example.vo.ProgramDay;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Alias("ClassRegHistoryDto")
@Getter
@Setter
@ToString
public class ClassRegHistoryDto {

	private String classRegNo;			// class_registration_history 테이블
	private String programCategoryName;	// fitness_program_category 테이블
	private int programNo;				
	private String programName;			// fitness_programs
	private String empName;				// employees
	private List<ProgramDay> openDay;	// fitness_program_days
	private String startHour;			// fitness_programs
	private String endHour;				// fitness_programs
	private int totalPaymentPrice;		// class_registration_history
	private Date paymentCompletedDate;	// class_registration_history
	
	public String getOpenDays() {
		StringJoiner joiner = new StringJoiner(",");
		for (ProgramDay day : openDay) {
			joiner.add(day.getDay());
		}
		return joiner.toString();
	}
}
