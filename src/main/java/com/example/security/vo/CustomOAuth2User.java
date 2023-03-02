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
	
	public CustomOAuth2User(User user, Collection<GrantedAuthority> authorites, Map<String, Object> attributes) {
		super(user);
		this.providerType = user.getProviderType();
		this.authorites = authorites;
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
