package com.example.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("Membership")
@Getter
@Setter
public class Membership {
	
	private int userNo;
}
