package com.example.web.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.ClassRegistrationDto;
import com.example.dto.MembershipDto;
import com.example.dto.ProgramDto;
import com.example.service.admin.ProgramService;
import com.example.service.admin.RegistrationService;

@Controller
@RequestMapping("/emp")
public class RegistrationController {

	@Autowired
	RegistrationService registrationService;
	@Autowired
	ProgramService programService;
	
	// 프로그램 신청현황 조회
	@GetMapping("/classRegList")
	public String getClassRegList(Model model) {
		List<ProgramDto> programList = programService.getAllProgramList();
		
		model.addAttribute("programList",programList);
		
		return "registration/classReg";
	}
	
	// 프로그램을 신청한 신청자 목록 요청
	@GetMapping("/userRequest")
	@ResponseBody
	public List<ClassRegistrationDto> getUserList(int programNo) {
		List<ClassRegistrationDto> userList = registrationService.getCclassRegistrationUserListByNo(programNo);
		return userList;
	}
	
	// 멤버십 신청현황 조회
	@GetMapping("/membershipRegList")
	public String getMembershipRegList(Model model) {
		List<MembershipDto> membershipList = registrationService.getAllMembership();
		
		model.addAttribute("membershipList", membershipList);
		
		return "registration/membershipReg";
	}
	
}
