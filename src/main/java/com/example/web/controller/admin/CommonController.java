package com.example.web.controller.admin;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.example.dto.EmployeeDetail;
import com.example.security.AuthenticatedUser;
import com.example.security.vo.LoginUser;
import com.example.service.admin.EmployeeService;
import com.example.web.request.EmployeeModifyForm;

@Controller
@RequestMapping("/emp")
@SessionAttributes({"form"})
public class CommonController {

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
		// 직원 아이디로 직원 상세 정보 조회
		EmployeeDetail employeeDetail = employeeService.getEmployeeDetail(loginUser.getId());
		// 수정폼 객체 생성
		EmployeeModifyForm form = new EmployeeModifyForm();
		// 수정폼 객체에 직원 상세정보 대입(수정폼에 직원정보 담아서 화면에 표현)
		BeanUtils.copyProperties(employeeDetail, form);
		
		model.addAttribute("form", form);
		
		return "employee/mypage-modify";
	}
	
	// 내 정보 수정
	@PostMapping("/modify")
	public String mypageModify(@Valid @ModelAttribute("form") EmployeeModifyForm form, BindingResult errors) throws IOException {
		if (errors.hasErrors()) {			
			return "employee/mypage-modify";
		}
		
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