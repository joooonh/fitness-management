package com.example.security;

public class LoginUser {

	private String id;
	private String encryptPassword;
	private String name;
	
	public LoginUser(String id, String encryptPassword, String name) {
		super();
		this.id = id;
		this.encryptPassword = encryptPassword;
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public String getEncryptPassword() {
		return encryptPassword;
	}

	public String getName() {
		return name;
	}
}
