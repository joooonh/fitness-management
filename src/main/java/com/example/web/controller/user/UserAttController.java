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
import com.example.service.admin.UserAttService;
import com.example.vo.FitnessProgramCategory;
import com.example.web.request.UserAttRegisterForm;
import com.example.web.request.UserClassAttRegisterForm;

@Controller
public class UserAttController {

	@Autowired
	private UserAttService userAttService;
	
	
	@ModelAttribute("FitnessProgramCategories")
	public List<FitnessProgramCategory> FitnessProgramCategories(Model model) {
		
		return userAttService.getPrograms();
	}
	

	@GetMapping("/emp/userAttList")
	public String userAttList(@RequestParam(name = "page" , required = false , defaultValue ="1") int page, 
			@RequestParam(name = "opt", required = false, defaultValue = "") String opt, 
			@RequestParam(name = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(name = "programInfo" , required = false, defaultValue = "")String programInfo, Model model) {

		
		Map<String,Object> result = userAttService.getUserList(page, opt ,keyword, programInfo);
		model.addAttribute("userAtts", result.get("userAtts"));
		model.addAttribute("pagination", result.get("pagination"));
		
		return "attendance/user-list";
	}
	
	// 회원출석등록
	@PostMapping("/emp/userRegisterAtt")
	public String insertUserAtt(UserAttRegisterForm form) throws IOException {
		userAttService.insertUserAtt(form);
		
		return "redirect:/emp/userAttList";
	}
	
	// 프로그램출석등록
	@PostMapping("/classAttRegister")
	public String insertUserClassAtt(UserClassAttRegisterForm form) throws IOException {
	
		userAttService.insertUserClassAtt(form);
		
		return "redirect:userList";
	}
	
	// 프로그램 요일 조회
	public ProgramDetailDto programDays(@RequestParam("programNo") String programNo) {
		ProgramDetailDto dto = userAttService.getProgramDay(programNo);
		
		return dto;
	}
	
	
	
	@GetMapping("/emp/userDay")
	public String userDay() {
		return "attendance/user-day";
	}
	
	@GetMapping("/emp/userCalendar")
	public String userCalendar() {
		return "attendance/user-calendar";
	}
	
	
}
