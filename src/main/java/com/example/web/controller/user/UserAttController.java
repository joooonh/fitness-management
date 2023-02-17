package com.example.web.controller.user;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dto.ProgramDetailDto;
import com.example.service.user.UserService;
import com.example.vo.FitnessProgramCategory;
import com.example.web.request.UserAttRegisterForm;
import com.example.web.request.UserClassAttRegisterForm;

@Controller
public class UserAttController {

	@Autowired
	private UserService userService;
	
	
	@ModelAttribute("FitnessProgramCategories")
	public List<FitnessProgramCategory> FitnessProgramCategories(Model model) {
		
		return userService.getPrograms();
	}
	

	
	@GetMapping("/userList")
	public String userList(@RequestParam(name = "page" , required = false , defaultValue ="1") int page, 
			@RequestParam(name = "opt", required = false, defaultValue = "") String opt, 
			@RequestParam(name = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(name = "programInfo" , required = false, defaultValue = "")String programInfo, Model model) {

		
		Map<String,Object> result = userService.getUserList(page, opt ,keyword, programInfo);
		model.addAttribute("userAtts", result.get("userAtts"));
		model.addAttribute("pagination", result.get("pagination"));
		
		return "attendance/user-list";
	}
	
	// 회원출석등록
	@PostMapping("/userAttRegister")
	public String insertUserAtt(UserAttRegisterForm form) throws IOException {
		userService.insertUserAtt(form);
		
		return "redirect:userList";
	}
	// 프로그램출석등록
	@PostMapping("/classAttRegister")
	public String insertUserClassAtt(UserClassAttRegisterForm form) throws IOException {
	
		userService.insertUserClassAtt(form);
		
		return "redirect:userList";
	}
	
	// 프로그램 요일 조회
	public ProgramDetailDto programDays(@RequestParam("programNo") String programNo) {
		ProgramDetailDto dto = userService.getProgramDay(programNo);
		
		return dto;
	}
	
	
	
	@GetMapping("/userDay")
	public String userDay() {
		return "attendance/user-day";
	}
	
	@GetMapping("/userCalendar")
	public String userCalendar() {
		return "attendance/user-calendar";
	}
	
	
}
