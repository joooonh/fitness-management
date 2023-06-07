package com.example.web.controller.user;

import java.io.File;
import java.io.IOException;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.example.exception.AlreadyRegisteredEmailException;
import com.example.exception.AlreadyRegisteredUserIdException;
import com.example.exception.InconsistentPasswordException;
import com.example.service.user.UserService;
import com.example.web.request.UserRegisterForm;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user")
public class UserHomeController {

	private final String directory = "C:\\app\\eGovFrameDev-4.0.0-64bit\\workspace\\fitness-management\\src\\main\\webapp\\resources\\images\\profile";
	
	@Autowired
	private UserService userService;
	
	// 이용자 로그인 화면 요청 
	@GetMapping("/login")
	public String loginform() {
		
		return "user/login-form";
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
	public String register(@Valid @ModelAttribute("userRegisterForm") UserRegisterForm userRegisterForm, BindingResult errors) throws IOException {

		log.info("errors={}", errors);
		
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
	
}
