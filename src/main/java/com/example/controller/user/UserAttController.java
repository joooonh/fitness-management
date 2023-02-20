package com.example.controller.user;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.service.user.UserService;
import com.example.vo.FitnessProgramCategory;

@Controller
public class UserAttController {

	@Autowired
	private UserService userService;
	
	
	@ModelAttribute("FitnessProgramCategories")
	public List<FitnessProgramCategory> FitnessProgramCategories(Model model) {
		
		return userService.getPrograms();
	}
	
	@GetMapping("/userList")
	public String userList(@RequestParam(name = "page" , required = false , defaultValue ="1") int page,Model model) {

		Map<String,Object> result = userService.getUserList(page);
		model.addAttribute("userAtts", result.get("userAtts"));
		model.addAttribute("pagination", result.get("pagination"));
		
		return "attendance/user-list";
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
