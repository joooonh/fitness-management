package com.example.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EmployeeAttController {
	
	@GetMapping("/employeeList")
	public String employeeList() {
		return "attendance/employee-list";
	}
	
	@GetMapping("/employeeCalendar")
	public String employeeCalendar() {
		return "attendance/employee-calendar";
	}
	
}
