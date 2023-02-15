package com.example.web.controller.admin;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.example.dto.EmployeeDetail;
import com.example.security.AuthenticatedUser;
import com.example.security.vo.LoginUser;
import com.example.service.admin.EmployeeService;
import com.example.web.request.EmployeeModifyForm;

@Controller
@RequestMapping("/emp")
public class EmployeeController {

	private final String directory = "C:\\app\\eGovFrameDev-4.0.0-64bit\\workspace\\fitness-management\\src\\main\\webapp\\resources\\images";
	
	@Autowired
	EmployeeService employeeService;
	
	// 내 정보 조회
	@GetMapping("/mypage")
	public String mypage(@AuthenticatedUser LoginUser loginUser, Model model) {
		EmployeeDetail employeeDetail = employeeService.getEmployeeDetail(loginUser.getId());
		model.addAttribute("employee", employeeDetail);
		
		return "/employee/mypage";
	}
	
	// 내 정보 수정페이지
	@GetMapping("/modify")
	public String modifyForm(@AuthenticatedUser LoginUser loginUser, Model model) {
		EmployeeDetail employeeDetail = employeeService.getEmployeeDetail(loginUser.getId());
		model.addAttribute("employee", employeeDetail);
		
		return "/employee/modify";
	}
	
	// 내 정보 수정
	@PostMapping("/modify")
	public String modify(EmployeeModifyForm form) throws IOException {
		MultipartFile upfile = form.getUpfile();
		if (!upfile.isEmpty()) {
			String filename = upfile.getOriginalFilename();
			form.setPhoto(filename);
			
			FileCopyUtils.copy(upfile.getInputStream(), new FileOutputStream(new File(directory, filename)));
		}
		
		employeeService.updateEmployee(form);
		
		return "redirect:mypage?empId=" + form.getId();
	}
}
