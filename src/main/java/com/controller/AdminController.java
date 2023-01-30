package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminController {
	
	//관리자 페이지 메인
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String admingage() {
		System.out.println("admin====");
		return "adminpage";
	}
	
}
