package com.example.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("EmployeeRole")
@Getter
@Setter
public class EmployeeRole {

	private String id;
	private String roleName;
}
