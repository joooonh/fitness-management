package com.example.dto;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("ProgramDayDto")
@Getter
@Setter
public class ProgramDayDto {

	private String name;
	private String status;
}
