package com.example.web.controller.home;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

	// 홈화면 요청
	@GetMapping("/")
	public String home() {
		return "home";
	}
}
