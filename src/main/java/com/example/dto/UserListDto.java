package com.example.dto;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.example.vo.FitnessProgram;

import lombok.Getter;
import lombok.Setter;

@Alias("UserListDto")
@Getter
@Setter
public class UserListDto {

	private String id;
	private int no;
	private String name;
	private String gender;
	private Date birth;
	private String tel;
	private List<FitnessProgram> programs;
}

