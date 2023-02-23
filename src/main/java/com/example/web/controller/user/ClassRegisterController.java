package com.example.web.controller.user;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.ScheduleCheckDto;
import com.example.security.AuthenticatedUser;
import com.example.security.vo.LoginUser;
import com.example.service.admin.ClubService;
import com.example.service.user.ClassRegisterService;
import com.example.vo.Club;
import com.example.vo.Program;
import com.example.vo.ProgramDay;

@Controller
@RequestMapping("/user")
public class ClassRegisterController {

	@Autowired
	private ClassRegisterService classRegisterService;
	@Autowired
	private ClubService clubService;
	
	// 프로그램 신청 페이지
	@GetMapping("/classReg")
	public String classRegisterForm(Model model) {
		
		// 매장정보 조회
		Club club = clubService.getClub();
		// 프로그램 조회
		List<Program> programList = classRegisterService.getAllPrograms();
		
		model.addAttribute("club", club);
		model.addAttribute("programList", programList);
		
		return "user/class-register";
	}
	
	// 달력에 모든일정 표시 ajax
	@GetMapping("/events")
	@ResponseBody
	public List<ScheduleCheckDto> getEvents(
			@RequestParam("startDate") String startDate,
			@RequestParam("endDate") String endDate){
		
		return classRegisterService.getAllSchedules(startDate, endDate);
	}
	
	// 프로그램 시작시간, 가격 ajax로 응답보내기
	@GetMapping("/classInfo")
	@ResponseBody
	public Program getProgram(@RequestParam("no") int programNo) {
		return classRegisterService.getProgramByProgNo(programNo);
	}
	
	// 프로그램 신청 
	@PostMapping("/classReg")
	public String registerClass(@AuthenticatedUser LoginUser loginUser,
			@RequestParam("programNo") int programNo,
			@RequestParam(name= "memStartDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date memStartDate,
			@RequestParam(name = "memEndDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date memEndDate,
			@RequestParam(name = "memPeriod", required = false, defaultValue = "0") int memPeriod,
			@RequestParam(name = "memPrice", required = false, defaultValue = "0") int memPrice) {
		
		String userId = loginUser.getId();
		
		Map<String, Object> param = new HashMap<>();
		param.put("progNo", programNo);
		param.put("memStartDate", memStartDate);
		param.put("memEndDate", memEndDate);
		param.put("memPeriod", memPeriod);
		param.put("memPrice", memPrice);
		
		classRegisterService.registerClass(userId, param);
		
		return "redirect:classRegistered";
	}
	// 프로그램 신청완료 페이지
	@GetMapping("/classRegistered")
	public String classRegistered() {
		return "user/classReg-success";
	}
}
