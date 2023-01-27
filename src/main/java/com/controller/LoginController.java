package com.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.MemberDTO;
import com.service.MemberService;

@Controller
public class LoginController {
	@Autowired
	MemberService service;
	
	//로그인 화면
	@RequestMapping(value = "/login")
	public String loginForm() {
		return "loginForm";
	}
	
	//로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@RequestParam Map<String, String> map, HttpSession session, RedirectAttributes m) {
		//System.out.println("login===="+map);
		MemberDTO idDTO=null;
		String mesg="";
		String nextPage="redirect:/login";
		idDTO=service.checkId(map);//아이디 있는지 확인
		
		if (idDTO!=null) {//해당 아이디의 회원이 있다면
			MemberDTO member=service.login(map);//아이디, 비밀번호 매칭
			if (member!=null) {
				//System.out.println("아이디, 비밀번호 일치 : 로그인");
				mesg=member.getMember_name()+"님 안녕하세요 :)";
				session.setAttribute("login", member);
				session.setMaxInactiveInterval(60*60);
				nextPage="redirect:/";
			} else {
				//System.out.println("비밀번호 오류");
				mesg="비밀번호가 틀렸습니다.";
			}
		} else {
			//System.out.println("아이디 오류");
			mesg="존재하지 않는 아이디입니다.";
		}
		m.addFlashAttribute("mesg", mesg);
		return nextPage;
	}
}
