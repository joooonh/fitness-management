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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.AttEvent;
import com.example.dto.UserAttDetailDto;
import com.example.dto.UserListAttDto;
import com.example.service.admin.UserAttCalendarService;
import com.example.vo.FitnessProgramCategory;

@Controller
@RequestMapping("/emp")
public class UserAttCalendarController {
	
	@Autowired
	UserAttCalendarService userAttCalendarService;
	
	

	// 회원리스트 및 검색
	@GetMapping("/userCalendar")
	public String userAttList(@RequestParam(name = "page" , required = false , defaultValue ="1") int page, 
								@RequestParam(name = "opt", required = false, defaultValue = "") String opt, 
								@RequestParam(name = "keyword", required = false, defaultValue = "") String keyword,
								@RequestParam(name = "programInfo" , required = false, defaultValue = "")String programInfo, Model model) {

		
		Map<String,Object> result = userAttCalendarService.getUserList(page, opt ,keyword, programInfo);
		model.addAttribute("userAtts", result.get("userAtts"));
		model.addAttribute("pagination", result.get("pagination"));
		
		return "attendance/user-calendar";
	}
	
	// 프로그램 조회
	@ModelAttribute("FitnessProgramCategories")
	public List<FitnessProgramCategory> FitnessProgramCategories(Model model) {
		
		return userAttCalendarService.getPrograms();
	}
	
	@GetMapping("/events")
	@ResponseBody
	public List<AttEvent> getEvents(@RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
			@RequestParam("endDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate,
			@RequestParam(name = "userNo", required = false, defaultValue = "0" ) int userNo) {
		
		
		Map<String, Object> param = new HashMap<>();
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		if (userNo != 0) {
			param.put("userNo", userNo);
		}
		
		return userAttCalendarService.getEvents(param);
	}

	@GetMapping("/detail.json")
	@ResponseBody
	public UserAttDetailDto userDetail(@RequestParam("userNo") String userNo) {
		UserAttDetailDto dto = userAttCalendarService.getUserDetail(userNo);
		
		return dto;
	}
	
	@ResponseBody
	public Map<String,Object> getPerson(){
		
		// 회원정보 갖고 오기
		 UserListAttDto userInfo = userAttCalendarService.getUserInfo();
		 List<AttEvent> attEvent = userAttCalendarService.getAttInfo();
		
		Map<String,Object> map = new HashMap<>();
		map.put("attDto", userInfo);
		map.put("attEvent", attEvent);
		
		return map;
	}

}