package com.example.web.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/emp")
public class EmployeeAttListController {

		
		// 강사 출석 조회
		@GetMapping("/empAttList")
		public String employeeAttList() {
			return "attendance/employee-list";
		}
}
