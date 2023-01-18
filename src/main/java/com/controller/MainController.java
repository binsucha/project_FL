package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dto.MemberDTO;
import com.service.MainService;

@Controller
public class MainController {
	@Autowired
	MainService service;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main(Model model) {
		MemberDTO member=service.selectMember();
		model.addAttribute("member", member);
		return "main";
	}
}