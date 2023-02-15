package com.example.security.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.mapper.EmployeeMapper;
import com.example.mapper.EmployeeRoleMapper;
import com.example.security.vo.CustomUserDetails;
import com.example.vo.Employee;
import com.example.vo.EmployeeRole;

@Service
public class CustomEmployeeDetailsService implements UserDetailsService{

	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	EmployeeRoleMapper employeeRoleMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		// 로그인하면서 전달받은 직원 아이디로 직원 정보 조회
		Employee employee = employeeMapper.getEmployeeById(userId);
		if(employee == null) {
			throw new UsernameNotFoundException("직원 정보가 존재하지 않습니다.");
		}
		// 직원의 권한정보 조회 
		List<EmployeeRole> empRoles = employeeRoleMapper.getEmployeeRolesByEmployeeId(employee.getId());
		
		// 직원의 권한정보 목록을 전달받아서 GrantedAutority 객체의 집합으로 반환
		List<SimpleGrantedAuthority> authorities = new ArrayList<>();
		
		for(EmployeeRole empRole : empRoles) {
			authorities.add(new SimpleGrantedAuthority(empRole.getRoleName()));
		}
		
		return new CustomUserDetails(
				employee.getId(),
				employee.getPassword(),
				employee.getName(), 
				authorities);
	}
}
