package com.example.web.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserHomeController {

	@GetMapping("/userhome")
	public String home() {
		return "userhome";
	}
}
