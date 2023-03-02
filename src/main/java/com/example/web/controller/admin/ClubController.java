package com.example.web.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.service.admin.ClubService;
import com.example.vo.Club;

@Controller
@RequestMapping("/emp/club")
public class ClubController {

	@Autowired
	ClubService clubService;
	
	@GetMapping("/club")
	public String club(Model model) {
		Club club = clubService.getClub();
		model.addAttribute("club", club);
		
		return "admin/club/club";
	}
}
