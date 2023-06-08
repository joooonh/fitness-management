package com.example.security.vo;

import com.example.vo.User;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginUser {

	private String id;
	private String nickname;
	private String providerType;
	private String email;
	
	public LoginUser() {}
	
	public LoginUser(User user) {
		this.id = user.getId();
		this.nickname = user.getName();
		this.providerType = user.getProviderType();
		this.email = user.getEmail();
	}
	
}
