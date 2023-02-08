package com.example.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("User")
@Getter
@Setter
public class User {

	private int no;
	private String id; 
	private String encryptPassword;
	private String name; 
	private String gender; 
	private Date birth;
	private String email;
	private String photo; 
	private String zipcode;
	private String basicAddr;
	private String detailAddr;
	private String tel;
	private String deleted;
	private Date createdDate;
	private Date updatedDate;

}
