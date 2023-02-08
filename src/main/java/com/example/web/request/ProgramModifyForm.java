package com.example.web.request;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.example.vo.ProgramDay;

import lombok.Getter;
import lombok.Setter;

@Alias("ProgramModifyForm")
@Getter
@Setter
public class ProgramModifyForm {

	private int programNo;
	private String name;
	private int categoryNo;
	private String employeeName;
	private Date startDate;
	private Date endDate;
	private String startHour;
	private String endHour;
	private String day;
}
