package com.example.web.controller.admin;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

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
import org.springframework.web.multipart.MultipartFile;

import com.example.dto.ProgramDayDto;
import com.example.dto.ProgramDto;
import com.example.exception.AlreadyRegisteredEmailException;
import com.example.exception.AlreadyRegisteredUserIdException;
import com.example.exception.InconsistentPasswordException;
import com.example.service.admin.ClubService;
import com.example.service.admin.EmployeeService;
import com.example.service.admin.ProgramService;
import com.example.vo.Club;
import com.example.vo.Employee;
import com.example.vo.ProgramCategory;
import com.example.web.request.ClubModifyForm;
import com.example.web.request.EmployeeModifyForm;
import com.example.web.request.EmployeeRegisterForm;
import com.example.web.request.ProgramForm;

@Controller
@RequestMapping("/admin")
public class AdminController {

	private final String directory = "C:\\app\\eGovFrameDev-4.0.0-64bit\\workspace\\fitness-management\\src\\main\\webapp\\resources\\images\\profile";
	
	@Autowired
	ClubService clubService;
	@Autowired
	ProgramService programService;
	@Autowired
	EmployeeService employeeService;
	
	// 피트니스센터 수정 페이지
	@GetMapping("/club/modify")
	public String modifyForm(@RequestParam(name = "no") int no, Model model) {
		Club club = clubService.getClub();
		model.addAttribute("club", club);
		
		return "admin/club/modify";
	}
	
	// 피트니스센터 수정 요청
	@PostMapping("/club/modify")
	public String modify(ClubModifyForm form) {
		clubService.updateClub(form);
		
		return "redirect:/emp/club/club";
	}
	
	// 직원 검색
	@GetMapping("/program/searchEmployees")
	@ResponseBody
	public List<Employee> employeeList(@RequestParam(name = "employeeName", required = false) String employeeName) {
		List<Employee> employeeList = employeeService.getSearchEmployees(employeeName);
		return employeeList;
	}
	
	// 프로그램 수정 페이지
	@GetMapping("/program/modify")
	public String programModifyForm(@RequestParam(name="programNo") int programNo, Model model) {
		// 프로그램 상세 정보
		ProgramDto programDetail = programService.getProgramDetail(programNo);
		// 프로그램 분류 목록
		List<ProgramCategory> categories = programService.getProgramCategory();
		// 재직중인 직원 정보 목록
		List<Employee> employeeList = employeeService.getEmployeeByStatus();
		// 프로그램 선택 요일 정보
		List<ProgramDayDto> programDays = programService.getDayStatusByProgramNo(programNo);
		
		model.addAttribute("programDetail", programDetail);
		model.addAttribute("categories", categories);
		model.addAttribute("employeeList", employeeList);
		model.addAttribute("programDays", programDays);
		
		return "admin/program/modify";
	}
	
	// 프로그램 수정 요청
	@PostMapping("/program/modify")
	public String programModify(ProgramForm form) {
		programService.updateProgram(form);
		
		return "redirect:/emp/program/list";
	}
	
	// 프로그램 등록 페이지
	@GetMapping("/program/insert")
	public String programInsertForm(Model model) {
		// 프로그램 분류 목록
		List<ProgramCategory> categories = programService.getProgramCategory();
		// 재직중인 직원 정보 목록
		List<Employee> employeeList = employeeService.getEmployeeByStatus();
		
		model.addAttribute("categories", categories);
		model.addAttribute("employeeList", employeeList);
		
		return "admin/program/insert";
	}
	
	// 프로그램 등록 요청
	@PostMapping("/program/insert")
	public String programInsert(ProgramForm form) {
		programService.insertProgram(form);
		return "redirect:/emp/program/list";
	}
	
	// 프로그램 삭제
	@GetMapping("/program/delete")
	public String programDelete(@RequestParam(name="programNo") String programNo) {
		programService.deleteProgram(programNo);
		return "redirect:/emp/program/list";
	}
	
	// 프로그램 분류 페이지
	@GetMapping("/program/category")
	public String programCategory(Model model) {
		// 프로그램 분류 목록
		List<ProgramCategory> categories = programService.getProgramCategory();
		model.addAttribute("categories",categories);
		
		return "admin/program/category";
	}
	
	// 프로그램 카테고리 수정
	@GetMapping("/program/modify-category")
	public String programModifyCategory(@RequestParam(name = "no") int no, 
			@RequestParam(name = "name") String name) {
		programService.updateCategory(no, name);
		
		return "redirect:category";
	}
	
	// 프로그램 카테고리 삭제
	@GetMapping("/program/delete-category")
	public String programDeleteCategory(@RequestParam(name = "no") int no, 
			@RequestParam(name = "name") String name) {
		programService.deleteCategory(no, name);
		
		return "redirect:category";
	}
	
	// 프로그램 카테고리 등록
	@GetMapping("/program/insert-category")
	public String programInsertCategory(@RequestParam(name = "name") String name) {
		programService.insertCategory(name);
		
		return "redirect:category";
	}
	
	// 직원 등록 페이지
	@GetMapping("/employee/insert")
	public String employeeInsertForm(Model model) {
		EmployeeRegisterForm employeeRegisterForm = new EmployeeRegisterForm();
		model.addAttribute("employeeRegisterForm", employeeRegisterForm);
		
		return "admin/employee/insert";
	}
	
	// 직원 등록 요청
	@PostMapping("/employee/insert")
	public String employeeInsert(@Valid EmployeeRegisterForm employeeRegisterForm, BindingResult errors) throws IOException {
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
		
		return "redirect:/emp/employee/list";
	}
	
	// 직원 정보 수정 페이지
	@GetMapping("/employee/modify-form")
	public String employeeModifyForm(@RequestParam(name = "empId") String empId, Model model) {
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
	@PostMapping("/employee/modify")
	public String employeeModify(@ModelAttribute("form") @Valid EmployeeModifyForm form, BindingResult errors) throws IOException {
		if(errors.hasErrors()) {
			return "admin/employee/modify-form";
		}
		MultipartFile upfile = form.getUpfile();
		if (!upfile.isEmpty()) {
			String filename = upfile.getOriginalFilename();
			form.setPhoto(filename);
			
			FileCopyUtils.copy(upfile.getInputStream(), new FileOutputStream(new File(directory, filename)));
		}

		employeeService.updateEmployee(form);
		
		return "redirect:/emp/employee/list";
	}
	
	// 직원 정보 삭제
	@GetMapping("/employee/delete")
	public String employeeDelete(@RequestParam(name = "empId") String empId) {
		employeeService.deleteEmployee(empId);
		return "redirect:/emp/employee/list";
	}
}
