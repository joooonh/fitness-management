package com.example.security.vo;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class CustomUserDetails extends LoginUser implements UserDetails{

	private static final long serialVersionUID = -692518506074118282L;
	
	// db에서 조회한 비밀번호
	private final String encryptPassword;
	private final Collection<? extends GrantedAuthority> authorities;
	
	// 로그인한 id로 사용자/직원 정보를 조회해서 UserDetails 객체에 로그인한 사용자의 아이디, 비밀번호, 이름, 권한정보를 저장
	public CustomUserDetails(String id, String encryptPassword, String name, Collection<? extends GrantedAuthority> authorities) {
		setId(id);
		setName(name);
		this.encryptPassword = encryptPassword;
		this.authorities = authorities;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Override
	public String getPassword() {
		return encryptPassword;
	}

	@Override
	public String getUsername() {
		return getId();
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

	
}
