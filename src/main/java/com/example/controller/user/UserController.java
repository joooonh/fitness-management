package com.example.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {
	
	@GetMapping("/list")
	public String userList() {
		return "attendance/user-list";
	}
	
	@GetMapping("/day")
	public String userDay() {
		return "attendance/user-day";
	}
	
	@GetMapping("/calendar")
	public String userCalendar() {
		return "attendance/user-calendar";
	}
}
