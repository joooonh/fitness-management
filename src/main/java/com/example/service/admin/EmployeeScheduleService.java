package com.example.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.mapper.EmployeeMapper;
import com.example.mapper.EmployeeScheduleMapper;
import com.example.vo.Employee;

@Service
@Transactional
public class EmployeeScheduleService {

		@Autowired
		private EmployeeScheduleMapper employeeScheduleMapper;
		
		public Employee getEmployeeById(String employeeId) {
			Employee employee = employeeScheduleMapper.getEmployeeById(employeeId);
			
			return employeeScheduleMapper.getEmployeeById(employeeId); 
		}
		
		public List<Employee> getAllEmployees() {
			return employeeScheduleMapper.getAllEmployees();
		
	}

}
