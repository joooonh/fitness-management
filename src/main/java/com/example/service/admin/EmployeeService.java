package com.example.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.mapper.EmployeeMapper;
import com.example.vo.Employee;

@Service
@Transactional
public class EmployeeService {

	@Autowired
	private EmployeeMapper employeeMapper;
	
	public Employee getEmployeeById(String employeeId) {
		Employee employee = employeeMapper.getEmployeeById(employeeId);
		
		return employeeMapper.getEmployeeById(employeeId); 
	}
	
	public List<Employee> getAllEmployees() {
		return employeeMapper.getAllEmployees();
	}
}
