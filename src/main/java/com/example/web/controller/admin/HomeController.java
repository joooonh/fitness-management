package com.example.web.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class HomeController {

	// 관리자 홈
	@GetMapping("/")
	public String home() {
		return "home";
	}
	
	// 관리자 로그인 요청
	@GetMapping("/login")
	public String loginform() {
		return "admin/login-form";
	}
	
}
