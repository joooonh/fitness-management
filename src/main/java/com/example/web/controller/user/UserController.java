package com.example.web.controller.user;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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

import com.example.dto.AttEvent;
import com.example.annotation.AuthenticatedUser;
import com.example.exception.AlreadyRegisteredEmailException;
import com.example.exception.AlreadyRegisteredUserIdException;
import com.example.exception.InconsistentPasswordException;
import com.example.security.vo.CustomOAuth2User;
import com.example.security.vo.LoginUser;
import com.example.service.user.UserService;
import com.example.vo.MembershipHistory;
import com.example.vo.User;
import com.example.web.request.UserModifyForm;
import com.example.web.request.UserRegisterForm;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user")
@SessionAttributes({"modifyForm"})
public class UserController {

	private final String directory = "C:\\app\\eGovFrameDev-4.0.0-64bit\\workspace\\fitness-management\\src\\main\\webapp\\resources\\images\\profile";

	@Autowired
	private UserService userService;
	
	// 회원가입 폼 요청 
	@GetMapping("/register")
	public String registerform(Model model) {
		UserRegisterForm form = new UserRegisterForm();
		model.addAttribute("userRegisterForm", form);
		
		return "user/register-form";
	}
	
	// 회원가입 요청 
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("userRegisterForm") UserRegisterForm userRegisterForm, BindingResult errors) throws IOException {

		if(errors.hasErrors()) {
			return "user/register-form";
		}
		
		MultipartFile upfile = userRegisterForm.getUpfile();
		if(!upfile.isEmpty()) {
			String filename = upfile.getOriginalFilename();
			userRegisterForm.setPhoto(filename);
			//FileCopyUtils.copy(upfile.getInputStream(), new FileOutputStream(new File(directory, filename)));
			upfile.transferTo(new File(directory, filename));
		}
		
		try {
			userService.registerUser(userRegisterForm);
		} catch(AlreadyRegisteredUserIdException ex) {
			errors.rejectValue("id", null, "이미 사용중인 아이디입니다.");
			return "user/register-form";
		} catch(AlreadyRegisteredEmailException ex) {
			errors.rejectValue("email", null, "이미 사용중인 이메일입니다.");
			return "user/register-form";
		} catch(InconsistentPasswordException ex) {
			errors.rejectValue("passwordConfirm", null, "비밀번호가 일치하지 않습니다.");
			return "user/register-form";
		}
		return "redirect:registered";
	}
	
	// 회원가입 성공 화면 요청
	@GetMapping("/registered")
	public String success() {
		return "user/register-success";
	}
	
	// 이용자 로그인 화면 요청 
	@GetMapping("/login")
	public String loginform() {
		return "user/login-form";
	}
		
	// 내 정보 조회/수정 폼 요청
	@GetMapping("/info")
	public String getInfo(@AuthenticatedUser LoginUser loginUser, Model model) {
		
		User user = userService.getUserinfo(loginUser.getId());
		if (user == null) {
			return "error/denied";
		}
		
		UserModifyForm modifyForm = new UserModifyForm();
		BeanUtils.copyProperties(user, modifyForm);
		model.addAttribute("modifyForm", modifyForm);
		
		return "user/info";
	}
	
	// 내 정보 수정 요청
	@PostMapping("/modify")
	public String modifyUser(@Valid @ModelAttribute("modifyForm") UserModifyForm userModifyForm, BindingResult errors) throws IOException {
		
		if(errors.hasErrors()) {
			return "redirect:info?complete=n";
		}
		
		MultipartFile upfile = userModifyForm.getUpfile();
		if(!upfile.isEmpty()) {
			String filename = upfile.getOriginalFilename();
			userModifyForm.setPhoto(filename);
			upfile.transferTo(new File(directory, filename)); 
		}
		
		try {
			userService.modifyUser(userModifyForm);
		} catch(InconsistentPasswordException ex) {
			errors.rejectValue("passwordConfirm", null, "비밀번호가 일치하지 않습니다.");
			return "/user/info";
		}
		
		return "redirect:info?complete=y";
	}
	
	// 내 회원권 조회
	@GetMapping("/membership")
	public String getMembership(@AuthenticatedUser LoginUser loginUser, Model model) {
		
		List<MembershipHistory> membershipList = userService.getMembershipHistory(loginUser.getId());
		if (membershipList == null) {
			return "error/denied";
		}
		
		model.addAttribute("membership", membershipList);
		return "user/info-membership";
	}
	
	// 내 예약 조회 (수업신청내역, 상담예약)
	@GetMapping("/reservation")
	public String getReservation(@AuthenticatedUser LoginUser loginUser, Model model) {
		
		Map<String, Object> param = userService.getRegistrationHistory(loginUser.getId());
		if (param == null) {
			return "error/denied";
		}
		
		model.addAttribute("classRegList", param.get("classRegList"));
		model.addAttribute("consultingList", param.get("consultingList"));
		
		return "user/info-reservation";
	}
	
	// 회원 탈퇴 페이지 요청
	@GetMapping("/delete")
	public String getdeleteForm(@AuthenticatedUser LoginUser loginUser, Model model) {
		User user = userService.getUserinfo(loginUser.getId()); 
		if (user == null) {
			return "error/denied";
		}
		model.addAttribute("user", user);
		return "user/info-delete";
	}
		
	// 회원 탈퇴 요청
	@PostMapping("/delete")
	public String deleteUser(@RequestParam String userId, @RequestParam String password) throws IOException {
		
		try {
			userService.deleteUser(userId, password);
			// 탈퇴시 로그아웃 처리
			SecurityContextHolder.clearContext();
		} catch(InconsistentPasswordException ex) {
			return "redirect:delete?error=fail";
		}
		
		return "redirect:deleted";
	}
	
	// 회원 탈퇴 완료 페이지 요청
	@GetMapping("/deleted")
	public String deleteSuccess() {
		return "user/delete-success";
	}
		
	// 내 출석 조회
	@GetMapping("/attendance")
	public String getAttendance() {
		
		return "user/info-attendance";
	}
	
	// 회원 출석달력
	@GetMapping("/userEvents")
	@ResponseBody
	public List<AttEvent> getEvents(@AuthenticatedUser LoginUser loginUser,
			@RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
			@RequestParam("endDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate) {
		
		Map<String, Object> param = new HashMap<>();
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		param.put("loginUser", loginUser);
		
		return userService.getUserEvents(param);
	}
	
}