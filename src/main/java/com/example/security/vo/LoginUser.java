package com.example.security.vo;

import com.example.vo.User;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginUser {

	private String id;
	private String nickname;
	private String userType;
	private String providerType;
	private String email;
	
	public LoginUser() {}
	public LoginUser(User user) {
		user.setProviderType(user.getProviderType());
		this.providerType = user.getProviderType();
		this.id = user.getId();
		this.nickname = user.getName();
		this.email = user.getEmail();
	}
	public LoginUser(String id, String name, String userType) {
		super();
		this.id = id;
		this.nickname = name;
		this.userType = userType;
	}
	
}
