package com.example.vo;

import org.apache.ibatis.type.Alias;

import lombok.Setter;
import lombok.ToString;
import lombok.Getter;

@Alias("ProgramDay")
@Getter
@Setter
public class ProgramDay { 

	private int programNo;
	private String day;
}
