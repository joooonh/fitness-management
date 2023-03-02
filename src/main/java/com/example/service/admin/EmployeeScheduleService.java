package com.example.service.admin;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.EmployeeScheduleDto;
import com.example.mapper.EmployeeMapper;
import com.example.mapper.EmployeeScheduleMapper;
import com.example.vo.Employee;

@Service
@Transactional
public class EmployeeScheduleService {

		@Autowired
		private EmployeeScheduleMapper employeeScheduleMapper;
		
		public EmployeeScheduleDto getEmployeeById(String employeeId) {
			EmployeeScheduleDto employeeScheduleDto = employeeScheduleMapper.getEmployeeById(employeeId);
			
			return employeeScheduleDto; 
		}
		
		public List<Employee> getAllEmployees() {
			return employeeScheduleMapper.getAllEmployees();
		}
		public List<EmployeeScheduleDto> getEvents(Map<String, Object> param) {
			return employeeScheduleMapper.getEmployeeEvents(param);
		}
		
		public EmployeeScheduleDto getEmployeeEventsById(String employeeId) {
			return employeeScheduleMapper.getEmployeeEventsById(employeeId);
		}
}
