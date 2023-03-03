package com.example.security.vo;

import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

import com.example.vo.User;

public class CustomOAuth2User extends LoginUser implements OAuth2User{

	private String providerType;
	private Collection<GrantedAuthority> authorites; 
	private Map<String, Object> attributes;
	
<<<<<<< HEAD
	public CustomOAuth2User(User user, Collection<GrantedAuthority> authorities, Map<String, Object> attributes) {
		super(user);
		this.providerType = user.getProviderType();
		this.authorites = authorities;
=======
	public CustomOAuth2User(User user, Collection<GrantedAuthority> authorites, Map<String, Object> attributes) {
		super(user);
		this.providerType = user.getProviderType();
		this.authorites = authorites;
>>>>>>> b8735a79c3060a0f5d3bf4d8c3a33dddb9b4e242
		this.attributes = attributes;
	}

	@Override
	public Map<String, Object> getAttributes() {
		return attributes;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorites;
	}
	
	@Override
	public String getName() {
		return getId();
	}
	
	public String getProviderType() {
		return providerType;
	}
}
