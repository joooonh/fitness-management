package com.example.web.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.service.admin.UserManagementService;
import com.example.service.user.UserService;
import com.example.vo.MembershipHistory;
import com.example.vo.User;

@Controller
@RequestMapping("/emp")
public class UserManagementController {
	
	@Autowired
	UserManagementService userManagementService;
	@Autowired
	UserService userService;

	// 회원 목록 조회
	@GetMapping("/userList")
	public String getUserList(Model model) {
		
		Map<String, Object> map = userManagementService.getUserList();
		model.addAttribute("userList", map.get("userList"));
		model.addAttribute("totalRows", map.get("totalRows"));
		
		return "management/user-management";
	}
	
	// 회원 상세 조회 - ajax
	@GetMapping("/userDetail")
	@ResponseBody
	public Map<String, Object> getUserDetail(@RequestParam("userId") String userId) {
		// 아이디로 유저 조회
		User user = userService.getUserinfo(userId);
		// 아이디로 회원권 조회
		List<MembershipHistory> membershipList = userService.getMembershipHistory(userId);
		
		Map<String, Object> map = new HashMap<>();
		map.put("user", user);
		map.put("membershipList", membershipList);
		
		return map;
	}
}
