package com.example.web.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.EmployeeAttDto;
import com.example.service.admin.EmployeeAttService;
import com.example.vo.Employee;
import com.example.vo.FitnessProgram;
import com.example.web.request.EmployeeAttRegister;

@Controller
@RequestMapping("/emp")
public class EmployeeAttListController {

	@Autowired
	EmployeeAttService empAttService;
	
	// 강사 출석 조회
	@GetMapping("/empAttList")
	public String employeeAttList(@RequestParam(name="page", required = false, defaultValue="1")int page, 
								  @RequestParam(name="opt", required = false, defaultValue="") String opt,
								  @RequestParam(name="keyword", required =false, defaultValue="")String keyword ,Model model) {
			
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("page",page);
		
		if(!opt.isBlank() && !keyword.isBlank()) {
			param.put("opt", opt);
			param.put("keyword", keyword);
			
		}
		
		Map<String,Object> result = empAttService.getEmpList(param);
		model.addAttribute("empAtts" , result.get("empAtts"));
		model.addAttribute("pagination" , result.get("pagination"));
		
		
		return "attendance/employee-list";
	}
	
	// 강사 출석 등록
	@PostMapping("/empAttRegister")
	public String insertEmpAtt(EmployeeAttRegister form) throws IOException {
		
		empAttService.insertEmpAttList(form);
		
		
		return "redirect:/emp/empAttList";
	}
	
	// 프로그램 조회
	@ModelAttribute("programs")
	public List<FitnessProgram> getPrograms(Model model){
		
		return empAttService.getPrograms();
	}
	// 강사 아이디 조회
	@ModelAttribute("EmpId")
	public List<Employee> empId(Model model) {
			
		return empAttService.getEmpId();
	}
	
	// 강사 정보 조회해서 모달창에 나타내기
	@GetMapping("/EmployeeInfo")
	@ResponseBody
	public EmployeeAttDto getEmpInfo(@RequestParam(name = "empId", required = false ,defaultValue = "") String empId) {
		return empAttService.getEmpById(empId);
	}
	
}

