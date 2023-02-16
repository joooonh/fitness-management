package com.example.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("FitnessProgramCategory")
@Getter
@Setter
public class FitnessProgramCategory {
	
	private int CategoryNo;
	private String CategoryName;
	

	
	
}
