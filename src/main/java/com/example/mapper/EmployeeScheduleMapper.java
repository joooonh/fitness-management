package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.vo.Employee;

@Mapper
public interface EmployeeScheduleMapper {

	Employee getEmployeeById(String employeeId);
	List<Employee> getAllEmployees();
}
