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
import com.example.web.request.ProgramForm;

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
		// 프로그램 목록 정보
		model.addAttribute("programs", result.get("programs"));
		// 페이징처리에 필요한 정보
		model.addAttribute("pagination", result.get("pagination"));
		 
		return "admin/program/list";
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
	
	@GetMapping("/searchEmployees")
	@ResponseBody
	public List<Employee> employeeList(@RequestParam(name = "employeeName", required = false) String employeeName) {
		List<Employee> employeeList = employeeService.getSearchEmployees(employeeName);
		return employeeList;
	}
	
	@GetMapping("/modify")
	public String modifyForm(@RequestParam(name="programNo") int programNo, Model model) {
		// 프로그램 상세 정보
		ProgramDto programDetail = programService.getProgramDetail(programNo);
		// 프로그램 분류 목록
		List<ProgramCategory> categories = programService.getProgramCategory();
		// 재직중인 직원 정보 목록
		List<Employee> employeeList = employeeService.getEmployeeByStatus();
		
		model.addAttribute("programDetail", programDetail);
		model.addAttribute("categories", categories);
		model.addAttribute("employeeList", employeeList);
		
		return "admin/program/modify";
	}
	
	@PostMapping("/modify")
	public String modify(ProgramForm form) {
		programService.updateProgram(form);
		
		return "redirect:list";
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
	public String insert(ProgramForm form) {
		programService.insertProgram(form);
		return "redirect:list";
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam(name="programNo") String programNo) {
		programService.deleteProgram(programNo);
		return "redirect:list";
	}
}
