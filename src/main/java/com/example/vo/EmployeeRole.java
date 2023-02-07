package com.example.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Alias("EmployeeRole")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class EmployeeRole {

	private String id;
	private String roleName;
  
}
