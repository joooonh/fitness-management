package com.example.web.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.ProgramDayDto;
import com.example.dto.ProgramDto;
import com.example.service.admin.EmployeeService;
import com.example.service.admin.ProgramService;
import com.example.vo.User;

@Controller
@RequestMapping("/emp/program")
public class ProgramController {

	@Autowired
	ProgramService programService;
	@Autowired
	EmployeeService employeeService; 
	
	// 프로그램 목록 요청
	@GetMapping("list")
	public String list(@RequestParam(name="page", required = false, defaultValue = "1") int page, 
			@RequestParam(name="sort", required = false) String sort, 
			@RequestParam(name="keyword", required = false) String keyword, Model model) {
		Map<String , Object> result = programService.getAllgrograms(page, sort, keyword);
		// 프로그램 목록 정보
		model.addAttribute("programs", result.get("programs"));
		// 페이징처리에 필요한 정보
		model.addAttribute("pagination", result.get("pagination"));
		 
		return "admin/program/list";
	}
	
	// 프로그램 상세정보 요청
	@GetMapping("/detail.json")
	@ResponseBody
	public Map<String, Object> detail(@RequestParam(name="programNo") int programNo) {
		// 프로그램 상세정보
		ProgramDto programDetail = programService.getProgramDetail(programNo);
		// 프로그램 선택 요일 정보
		List<ProgramDayDto> programDays = programService.getDaysByProgramNoStatusY(programNo);
		// 프로그램 신청자 목록
		List<User> users = programService.getProgramUser(programNo);
		
		Map<String, Object> detailInfo = new HashMap<>();
		detailInfo.put("programDetail", programDetail);
		detailInfo.put("programDays", programDays);
		detailInfo.put("users", users);
		
		return detailInfo; 
	}
}
