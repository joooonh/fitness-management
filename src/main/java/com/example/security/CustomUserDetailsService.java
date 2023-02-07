package com.example.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.example.mapper.UserMapper;
import com.example.mapper.UserRoleMapper;
import com.example.vo.User;
import com.example.vo.UserRole;

public class CustomUserDetailsService implements UserDetailsService{

	@Autowired
	private UserMapper userMapper;
	@Autowired
	private UserRoleMapper userRoleMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		
		User user = userMapper.getUserById(userId);
		if(user == null) {
			throw new UsernameNotFoundException("사용자 정보가 존재하지 않습니다.");
		}
		if("Y".equals(user.getDeleted())) {
			throw new UsernameNotFoundException("탈퇴한 사용자입니다.");
		}
		
		UserRole userRole = userRoleMapper.getUserRoleByNo(user.getNo());
		Collection<? extends GrantedAuthority> authorities = this.getAuthorities(userRole);

		return new CustomUserDetails(
					user.getId(), 
					user.getEncryptPassword(), 
					user.getName(), 
					authorities);
	}
	
	private Collection<? extends GrantedAuthority> getAuthorities(UserRole userRole){
		
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>(); 
		SimpleGrantedAuthority authority = new SimpleGrantedAuthority(userRole.getRoleName());
		authorities.add(authority);
		
		return authorities;
	}

	
}
