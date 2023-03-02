package com.example.web.controller.home;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ChatController {

	@GetMapping("/user/chat")
	public String userChat() {
		return "/chat/userChat";
	}
	
	@GetMapping("/emp/chat")
	public String employeeChat() {
		return "/chat/empChat";
	}
	
}
