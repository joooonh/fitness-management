package com.example.web.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.ProgramCalendarDto;
import com.example.dto.ProgramDto;
import com.example.dto.ProgramScheduleDto;
import com.example.service.admin.ProgramScheduleService;
import com.example.vo.Employee;
import com.example.vo.Program;
@Controller
@RequestMapping("/emp/schedule")
public class ProgramScheduleController {

	@Autowired
	private ProgramScheduleService programScheduleService;

	
	//program 페이지로 이동
	@GetMapping("/program")
	public String program(Model model) {
		List<Program> programs = programScheduleService.getAllPrograms();
		model.addAttribute("programs", programs);
		
		return "/schedule/program";
	}
	
	
	@GetMapping("/programs")
	@ResponseBody
	public List<ProgramCalendarDto> programs(@RequestParam(name = "progNo", required = false, defaultValue = "0") int progNo, 
			@RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
			@RequestParam("endDate") @DateTimeFormat(pattern =  "yyyy-MM-dd") Date endDate) {

		Map<String, Object> param = new HashMap<>();
		if (progNo != 0) {
			param.put("progNo", progNo);
		}
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		
		return programScheduleService.getEvents(param);
	}

	
}
