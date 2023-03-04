package com.example.security.vo;

import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

import com.example.vo.User;

public class CustomOAuth2User extends LoginUser implements OAuth2User{
	
	private Collection<GrantedAuthority> authorites; 
	private Map<String, Object> attributes;
	
	public CustomOAuth2User(User user, Collection<GrantedAuthority> authorities, Map<String, Object> attributes) {
		super(user);
		this.authorites = authorities;
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
	
	@Override
	public String getProviderType() {
		return super.getProviderType();
	}
	
	@Override
	public void setNickname(String nickname) {
		super.setNickname(nickname);
	}
	
	@Override
	public void setProviderType(String providerType) {
		super.setProviderType(providerType);
	}
}
