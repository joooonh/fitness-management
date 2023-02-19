package com.example.web.controller.admin;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.example.exception.AlreadyRegisteredEmailException;
import com.example.exception.AlreadyRegisteredUserIdException;
import com.example.exception.InconsistentPasswordException;
import com.example.security.AuthenticatedUser;
import com.example.security.vo.LoginUser;
import com.example.service.admin.EmployeeService;
import com.example.vo.Employee;
import com.example.web.request.EmployeeModifyForm;
import com.example.web.request.EmployeeRegisterForm;

@Controller
@RequestMapping("/admin/employee")
@SessionAttributes({"form"})
public class EmployeeController {
	
	private final String directory = "C:\\app\\eGovFrameDev-4.0.0-64bit\\workspace\\fitness-management\\src\\main\\webapp\\resources\\images\\profile";
	
	@Autowired
	EmployeeService employeeService;
	
	// 직원 조회
	@GetMapping("/list")
	public String list(@RequestParam(name = "page", required = false, defaultValue = "1") int page, 
			@RequestParam(name = "status", required = false, defaultValue = "") String status,
			@RequestParam(name = "keyword", required = false, defaultValue = "") String keyword, Model model) {
		Map<String, Object> result = employeeService.getAllEmployee(page,status,keyword);
		// 직원 목록 정보
		model.addAttribute("employees", result.get("employees"));
		// 페이징처리에 필요한 정보
		model.addAttribute("pagination", result.get("pagination"));
		
		return "admin/employee/list";
	}
	
	// 아이디로 직원 정보 조회
	@GetMapping("/detail.json")
	@ResponseBody
	public Employee detail(@RequestParam(name = "empId") String empId) {
		return employeeService.getEmployeeById(empId);
	}
	
	// 직원 등록 페이지
	@GetMapping("/insert")
	public String insertForm(Model model) {
		EmployeeRegisterForm employeeRegisterForm = new EmployeeRegisterForm();
		model.addAttribute("employeeRegisterForm", employeeRegisterForm);
		
		return "admin/employee/insert";
	}
	
	// 직원 등록 요청
	@PostMapping("/insert")
	public String insert(@ModelAttribute("employeeRegisterForm") @Valid EmployeeRegisterForm employeeRegisterForm, BindingResult errors) throws IOException {
		if(errors.hasErrors()) {
			return "admin/employee/insert";
		}
		
		MultipartFile upfile = employeeRegisterForm.getUpfile();
		if (!upfile.isEmpty()) {
			String filename = upfile.getOriginalFilename();
			employeeRegisterForm.setPhoto(filename);
			
			FileCopyUtils.copy(upfile.getInputStream(), new FileOutputStream(new File(directory, filename)));
		}
		
		try {
			employeeService.insertEmployee(employeeRegisterForm);
		} catch (AlreadyRegisteredUserIdException ex) {
			errors.rejectValue("id", null, "이미 사용중인 아이디입니다.");
			return "admin/employee/insert";
		} catch(AlreadyRegisteredEmailException ex) {
			errors.rejectValue("email", null, "이미 사용중인 이메일입니다.");
			return "admin/employee/insert";
		} catch(InconsistentPasswordException ex) {
			errors.rejectValue("passwordConfirm", null, "비밀번호가 일치하지 않습니다.");
			return "admin/employee/insert";
		}
		
		return "redirect:list";
	}
	
	// 직원 정보 수정 페이지
	@GetMapping("/modify-form")
	public String modifyForm(@RequestParam(name = "empId") String empId, Model model) {
		// 직원 아이디로 직원 정보 획득
		Employee employee = employeeService.getEmployeeById(empId);
		// 수정폼 객체 생성
		EmployeeModifyForm form = new EmployeeModifyForm();
		// 수정폼 객체에 직원 상세정보 대입(수정폼에 직원정보 담아서 화면에 표현)
		BeanUtils.copyProperties(employee, form);
		
		model.addAttribute("form", form);
		
		return "admin/employee/modify-form";
	}
	
	// 직원 정보 수정 요청
	@PostMapping("/modify")
	public String modify(@ModelAttribute("form") EmployeeModifyForm form) {
		employeeService.updateEmployee(form);
		
		return "redirect:list";
	}
}
