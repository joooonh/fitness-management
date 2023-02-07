package com.example.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Alias("UserRole")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class UserRole {

	private int userNo;
	private String roleName;
}
