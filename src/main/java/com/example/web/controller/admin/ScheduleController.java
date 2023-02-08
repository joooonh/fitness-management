package com.example.web.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ScheduleController {

		@GetMapping("/schedule/employee")
		public String employee() {
			return "/schedule/employee";
		}
		
		@GetMapping("/schedule/program")
		public String program() {
			return "/schedule/program";
		}
		
}
