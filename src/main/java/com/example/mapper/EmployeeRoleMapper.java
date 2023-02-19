package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.vo.EmployeeRole;

@Mapper
public interface EmployeeRoleMapper {
	
	// 직원아이디로 직원 권한 조회 
	List<EmployeeRole> getEmployeeRolesByEmployeeId(String empId);
	// 직원 권한 등록
	void insertEmployeeRole(String empId);
}
