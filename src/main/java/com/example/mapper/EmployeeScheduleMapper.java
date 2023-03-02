package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.EmployeeScheduleDto;
import com.example.dto.ProgramCalendarDto;
import com.example.vo.Employee;

@Mapper
public interface EmployeeScheduleMapper {

	EmployeeScheduleDto getEmployeeById(String employeeId);
	List<Employee> getAllEmployees();
	
	List<EmployeeScheduleDto> getEmployeeEvents(Map<String, Object> param);
	EmployeeScheduleDto getEmployeeEventsById(String employeeId);
}
