package com.example.web.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.service.admin.ClubService;
import com.example.vo.Club;
import com.example.web.request.ClubModifyForm;

@Controller
@RequestMapping("/admin/club")
public class ClubController {

	@Autowired
	ClubService clubService;
	
	@GetMapping("/club")
	public String club(Model model) {
		Club club = clubService.getClub();
		model.addAttribute("club", club);
		
		return "admin/club/club";
	}
	
	@GetMapping("/modify")
	public String modifyForm(@RequestParam(name = "no") int no, Model model) {
		Club club = clubService.getClub();
		model.addAttribute("club", club);
		
		return "admin/club/modify";
	}
	
	@PostMapping("/modify")
	public String modify(ClubModifyForm form) {
		clubService.updateClub(form);
		
		return "redirect:club";
	}
}
