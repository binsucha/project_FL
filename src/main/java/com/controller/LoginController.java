package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {
	
	//로그인 화면
	@RequestMapping(value = "/login")
	public String login() {
		return "login";
	}
}
