package com.controller;

import java.util.List;

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
	private MainService service;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main(Model model) {
		List<MemberDTO> list=service.selectAllMember();
		model.addAttribute("member", list);
		return "main";
	}
}