package com.example.web.controller.user;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
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
								@RequestParam(name = "startDate", required = false, defaultValue = "") String startDate,
								@RequestParam(name = "endDate", required = false, defaultValue = "") String endDate, 
								@RequestParam(name = "opt", required = false, defaultValue = "") String opt, 
								@RequestParam(name = "keyword", required = false, defaultValue = "") String keyword,
								@RequestParam(name = "programInfo" , required = false, defaultValue = "")String programInfo, Model model) {

		if (startDate.isBlank()) {
			startDate = LocalDate.now().with(TemporalAdjusters.firstDayOfMonth()).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
		if (endDate.isBlank()) {
			endDate = LocalDate.now().with(TemporalAdjusters.lastDayOfMonth()).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
		
		Map<String,Object> result = userAttCalendarService.getUserList(page, startDate, endDate, opt ,keyword, programInfo);
		model.addAttribute("userAtts", result.get("userAtts"));
		model.addAttribute("pagination", result.get("pagination"));
		
		return "attendance/user-calendar";
	}
	
	// 프로그램 조회
	@ModelAttribute("FitnessProgramCategories")
	public List<FitnessProgramCategory> FitnessProgramCategories(Model model) {
		
		return userAttCalendarService.getPrograms();
	}
	
	// 달력조회
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
	
	// 상세정보 조회
	@GetMapping("/detail.json")
	@ResponseBody
	public Map<String,Object> userDetail(@RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
			@RequestParam("endDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate,
			@RequestParam("userNo") int userNo,
			@RequestParam(name = "membership", required = false) String membership,
			@RequestParam(name = "programNo", required = false, defaultValue = "0") int programNo) {		
		
		Map<String, Object> param = new HashMap<>();
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		param.put("userNo", userNo);
		if (membership != null) {
			param.put("membership", membership);			
		}
		if (programNo != 0) {
			param.put("programNo", programNo);			
		}
		
		UserAttDetailDto dto = userAttCalendarService.getUserDetail(param);
		List<AttEvent> attEvents = userAttCalendarService.getEvents(param);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user", dto);
		map.put("events", attEvents);
		
		return map;
	}
	
	

}