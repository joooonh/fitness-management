package com.example.web.controller.user;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.exception.AlreadyRegisteredEmailException;
import com.example.exception.AlreadyRegisteredUserIdException;
import com.example.security.LoginUser;
import com.example.service.user.UserService;
import com.example.web.request.UserRegisterForm;

@Controller
@RequestMapping("/user")
public class UserHomeController {

	@Autowired
	private UserService userService;
	
	// 이용자 홈화면 요청
	@GetMapping("/home")
	public String home() {
		return "user/home";
	}
	
	// 회원가입 폼 요청 
	@GetMapping("/register")
	public String registerform(Model model) {
		UserRegisterForm form = new UserRegisterForm();
		model.addAttribute("userRegisterForm", form);
		
		return "user/register-form";
	}
	
	// 회원가입 요청 
	@PostMapping("/register")
	public String register(@ModelAttribute("userRegisterForm") @Valid UserRegisterForm userRegisterForm, BindingResult errors) {
		
		if(errors.hasErrors()) {
			return "user/register-form";
		}
		
		try {
			userService.registerUser(userRegisterForm);
		} catch(AlreadyRegisteredUserIdException ex) {
			errors.rejectValue("id", null, "이미 사용중인 아이디입니다.");
			return "user/register-form";
		} catch(AlreadyRegisteredEmailException ex) {
			errors.rejectValue("email", null, "이미 사용중인 이메일입니다.");
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
	
	
}
