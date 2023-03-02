package com.example.web.controller.user;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.exception.AlreadyRegisteredUserIdException;
import com.example.service.admin.UserAttService;
import com.example.vo.FitnessProgramCategory;
import com.example.web.request.UserAttRegisterForm;
import com.example.web.request.UserClassAttRegisterForm;

@Controller
@RequestMapping("/emp")
public class UserAttController {

	@Autowired
	private UserAttService userAttService;
	
	
	// 프로그램 조회
	@ModelAttribute("FitnessProgramCategories")
	public List<FitnessProgramCategory> FitnessProgramCategories(Model model) {
		
		return userAttService.getPrograms();
	}
	
	// 프로그램 요일 조회
	@GetMapping("/ProgramDays")
	@ResponseBody
	public List<String> programDays(@RequestParam("programNo") int programNo) {					
		return userAttService.getProgramDays(programNo);
	}
	

	@GetMapping("/userAttList")
	public String userAttList(@RequestParam(name = "page" , required = false , defaultValue ="1") int page, 
							  @RequestParam(name = "opt", required = false, defaultValue = "") String opt, 
							  @RequestParam(name = "keyword", required = false, defaultValue = "") String keyword,
							  @RequestParam(name = "programInfo" , required = false, defaultValue = "")String programInfo,
							  @RequestParam(name = "onlyMembership" , required = false, defaultValue = "")String onlyMembership, 
							  @RequestParam(name = "attDate" , required = false, defaultValue = "")String attDate,
							  @RequestParam(name = "classDate", required = false, defaultValue = "")String classDate, Model model) {
		
		Map<String,Object> param = new HashMap<String,Object>();
		
		param.put("page", page);
		
		if (!programInfo.isBlank()) {
			param.put("programInfo", programInfo);
			if (!keyword.isBlank()) {
				param.put("keyword", keyword);			
			}
		}
		if (!opt.isBlank() && !keyword.isBlank()) {
			param.put("opt", opt);
			param.put("keyword", keyword);			
		}
		if(!onlyMembership.isBlank()) {
			param.put("onlyMembership", onlyMembership);
			if(!keyword.isBlank()) {
				param.put("keyword", keyword);
			}
			// 의미가 없는거 같음
			if (!programInfo.isBlank()) {
				param.put("programInfo", programInfo);
				if (!keyword.isBlank()) {
					param.put("keyword", keyword);			
				}
			}
		}
		if(!attDate.isBlank()) {
			param.put("attDate", attDate);
			if (!programInfo.isBlank()) {
				param.put("programInfo", programInfo);
				if (!keyword.isBlank()) {
					param.put("keyword", keyword);			
				}
			}
		}
		if(!attDate.isBlank() && !keyword.isBlank()) {
			param.put("attDate", attDate);
			param.put("keyword", keyword);			
			
		}
		
		if(!classDate.isBlank()) {
			param.put("classDate", classDate);
		}
		
		Map<String,Object> result = userAttService.getUserList(param);
		model.addAttribute("userAtts", result.get("userAtts"));
		model.addAttribute("pagination", result.get("pagination"));
		model.addAttribute("totalRows", result.get("totalRows"));
		
		return "attendance/user-list";
	}
	
	// 회원출석등록
	@PostMapping("/userRegisterAtt")
	public String insertUserAtt(UserAttRegisterForm form) throws IOException {
		
		userAttService.insertUserAtt(form);
		
		return "redirect:/emp/userAttList";
	}
	
	// 프로그램출석등록
	@PostMapping("/classAttRegister")
	public String insertUserClassAtt(UserClassAttRegisterForm form) throws IOException {
	
		userAttService.insertUserClassAtt(form);
		
		return "redirect:/emp/userAttList";
	}
	
	
	// 회원출석 삭제
	// ?value=100-P&value=101-M
	@GetMapping("/delete-userAtt")
	public String modifyForm( @RequestParam(name="value" , required = false,  defaultValue = "") List<String> values) {
	
		userAttService.deleteAtt(values);
		
		
		return "redirect:/emp/userAttList";
	}
	
	
	@GetMapping("/userDay")
	public String userDay() {
		return "attendance/user-day";
	}
	
	
	
	
	
	
}
