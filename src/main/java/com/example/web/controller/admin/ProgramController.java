package com.example.web.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dto.ProgramDto;
import com.example.service.admin.Programservice;
import com.example.vo.Program;
@Controller
@RequestMapping("/emp/schedule")
public class ProgramController {

	@Autowired
	private Programservice programService;
	
	//program 페이지로 이동
	@GetMapping("/program")
	public String program(Model model) {
		List<Program> programs = programService.getAllPrograms();
		model.addAttribute("programs", programs);
		return "/schedule/program";
	}
	
	//programsearch 페이지로 이동
	@GetMapping("/programsearch")
	public String programsearch(@RequestParam(name = "programName", required = false) String programName, Model model) {
		List<Program> programs = programService.getAllPrograms();
		model.addAttribute("programs", programs);
		
		if (programName != null) {
			ProgramDto program = programService.getProgramByProgramName(programName);
			model.addAttribute("program", program);
		}
		
		return "/schedule/programsearch";
	}
	
}
