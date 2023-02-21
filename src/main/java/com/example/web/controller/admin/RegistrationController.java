package com.example.web.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/emp")
public class RegistrationController {

	// 프로그램 신청현황 조회
	@GetMapping("/classRegList")
	public String getClassRegList() {
		return "registration/classReg";
	}
	
	// 멤버십 신청현황 조회
	@GetMapping("/membershipRegList")
	public String getMembershipRegList() {
		return "registration/membershipReg";
	}
	
}
