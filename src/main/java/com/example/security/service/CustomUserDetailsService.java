package com.example.security.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.mapper.UserMapper;
import com.example.mapper.UserRoleMapper;
import com.example.security.vo.CustomUserDetails;
import com.example.vo.User;
import com.example.vo.UserRole;

@Service
public class CustomUserDetailsService implements UserDetailsService{

	@Autowired
	UserMapper userMapper;
	@Autowired
	UserRoleMapper userRoleMapper;
	
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
		
		List<SimpleGrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority(userRole.getRoleName()));
		
		return new CustomUserDetails(
					user.getId(), 
					user.getEncryptPassword(), 
					user.getName(), 
					authorities);
	}
	
}
