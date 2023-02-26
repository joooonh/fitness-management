package com.example.web.controller.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.service.admin.ClubService;
import com.example.vo.Club;

@Controller
public class HomeController {

	@Autowired
	private ClubService clubService;
	
	// 홈화면 요청
	@GetMapping("/")
	public String home(Model model) {
		
		Club club = clubService.getClub();
		model.addAttribute("club", club);
		
		return "home";
	}
	
	// 권한 접근 제한
	@GetMapping("/access-denied")
	public String accessDenied() {
		return "/error/denied";
	}
}
