package com.example.web.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.ProgramDto;
import com.example.service.admin.EmployeeService;
import com.example.service.admin.ProgramService;
import com.example.vo.Employee;
import com.example.vo.ProgramCategory;
import com.example.vo.User;
import com.example.web.request.ProgramModifyForm;

@Controller
@RequestMapping("/admin/program")
public class ProgramController {

	@Autowired
	ProgramService programService;
	@Autowired
	EmployeeService employeeService; 
	
	@GetMapping("list")
	public String list(@RequestParam(name="page", required = false, defaultValue = "1") int page, 
			@RequestParam(name="sort", required = false) String sort, 
			@RequestParam(name="keyword", required = false) String keyword, Model model) {
		Map<String , Object> result = programService.getAllgrograms(page, sort, keyword);
		model.addAttribute("programs", result.get("programs"));
		model.addAttribute("pagination", result.get("pagination"));
		model.addAttribute("sort", sort);
		model.addAttribute("keyword", keyword);
		 
		return "admin/program/list";
	}
	
	@GetMapping("/modify")
	public String modifyForm(@RequestParam(name="programNo") int programNo, Model model) {
		List<ProgramCategory> categories = programService.getProgramCategory();
		model.addAttribute("categories", categories);
		
		return null; 
	}
	
	@GetMapping("/detail.json")
	@ResponseBody
	public Map<String, Object> detail(@RequestParam(name="programNo") int programNo) {
		// 프로그램 상세정보
		ProgramDto programDetail = programService.getProgramDetail(programNo);
		// 프로그램 신청자 목록
		List<User> users = programService.getProgramUser(programNo);
		
		Map<String, Object> detailInfo = new HashMap<>();
		detailInfo.put("programDetail", programDetail);
		detailInfo.put("users", users);
		
		return detailInfo;
	}
	
	@GetMapping("/insert")
	public String insertForm(Model model) {
		// 프로그램 분류 목록
		List<ProgramCategory> categories = programService.getProgramCategory();
		// 재직중인 직원 정보 목록
		List<Employee> employeeList = employeeService.getEmployeeByStatus();
		
		model.addAttribute("categories", categories);
		model.addAttribute("employeeList", employeeList);
		
		return "admin/program/insert";
	}
	
	@PostMapping("/insert")
	public String insert(ProgramModifyForm form) {
		programService.insertProgram(form);
		return "redirect:list";
	}
}
