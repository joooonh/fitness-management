package com.example.web.controller.admin;

import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.service.admin.EmployeeService;
import com.example.vo.Employee;

@Controller
@RequestMapping("/admin/employee")
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	// 직원 조회
	@GetMapping("/list")
	public String list(@RequestParam(name = "page", required = false, defaultValue = "1") int page, 
			@RequestParam(name = "status", required = false, defaultValue = "") String status,
			@RequestParam(name = "keyword", required = false, defaultValue = "") String keyword, Model model) {
		Map<String, Object> result = employeeService.getAllEmployee(page,status,keyword);
		// 직원 목록 정보
		model.addAttribute("employees", result.get("employees"));
		// 페이징처리에 필요한 정보
		model.addAttribute("pagination", result.get("pagination"));
		
		return "admin/employee/list";
	}
	
	// 아이디로 직원 정보 조회
	@GetMapping("/detail.json")
	@ResponseBody
	public Employee detail(@RequestParam(name = "empId") String empId) {
		return employeeService.getEmployeeById(empId);
	}
}
