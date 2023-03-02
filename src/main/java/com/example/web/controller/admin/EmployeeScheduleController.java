package com.example.web.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.EmployeeScheduleDto;
import com.example.service.admin.EmployeeScheduleService;
import com.example.service.admin.EmployeeService;

import com.example.vo.Employee;

@Controller
@RequestMapping("/emp/schedule")
public class EmployeeScheduleController {
	@Autowired
	private EmployeeScheduleService employeeScheduleService;
	
	//employee 페이지로 이동
	@GetMapping("/employee")
	public String employee(Model model) {
		List<Employee> employees = employeeScheduleService.getAllEmployees();
		model.addAttribute("employees", employees);
		return "/schedule/employee";
	}
	
	//employeesearch 페이지로 이동
	@GetMapping("/employees")
	@ResponseBody
	public List<EmployeeScheduleDto> employees(@RequestParam(name = "empId", required = false) String empId, 
			@RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
			@RequestParam("endDate") @DateTimeFormat(pattern =  "yyyy-MM-dd") Date endDate) {
		
		Map<String, Object> param = new HashMap<>();
		if (empId != null) {
			param.put("empId", empId);
		}
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		
		return employeeScheduleService.getEvents(param);
	}
	
	
}
	