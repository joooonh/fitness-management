package com.example.web.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	@GetMapping("/employeesearch")
	public String employeesearch(@RequestParam(name = "empId", required = false) String employeeId, Model model) {
		List<Employee> employees = employeeScheduleService.getAllEmployees();
		model.addAttribute("employees", employees);
		
		if (employeeId != null) {
			Employee emp = employeeScheduleService.getEmployeeById(employeeId);
			model.addAttribute("employee", emp);
		}
		
		return "/schedule/employeesearch";
	}
}
	