package com.example.web.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/emp")
public class EmployeeHomeController {

	// 관리자 홈
	@GetMapping("/home")
	public String home() {
		return "employee/home";
	}
	
	// 관리자 로그인 요청
	@GetMapping("/login")
	public String loginform() {
		return "employee/login-form";
	}
	
}
