package com.example.security.vo;

import java.io.Serializable;

import com.example.vo.User;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SessionUser implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String name;
	private String email;
	private String photo;
	
	public SessionUser() {}
	
	public SessionUser(User user) {
		this.name = user.getName();
		this.email = user.getEmail();
		this.photo = user.getPhoto();
	}
	
	
}
