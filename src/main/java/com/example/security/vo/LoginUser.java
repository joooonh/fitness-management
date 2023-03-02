package com.example.security.vo;

import com.example.vo.User;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginUser {

	private String id;
	private String name;
	private String userType;
	private String email;
	
	public LoginUser() {}
	public LoginUser(User user) {
		this.id = user.getId();
		this.name = user.getName();
		this.email = user.getEmail();
	}
	public LoginUser(String id, String name, String userType) {
		super();
		this.id = id;
		this.name = name;
		this.userType = userType;
	}
	
}
