package com.example.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("ProgramCategory")
@Getter
@Setter
public class ProgramCategory {

	private int no;
	private String name;
}
