package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.vo.EmployeeRole;

@Mapper
public interface EmployeeRoleMapper {

	public List<EmployeeRole> getEmployeeRoles(String empId);
}