package com.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.MemberDTO;
import com.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	private MemberService service;
	
	//회원 가입 화면
	@RequestMapping(value = "/join")
	public String memberForm() {
		return "memberForm";
	}
	
	//회원 가입 데이터 중복 확인
	@RequestMapping(value = "/join/data", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String checkData(String type, String data) {
		//System.out.println("checkData====="+type+" : "+data);
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("type", type);
		map.put("data", data);
		MemberDTO member=service.checkData(map);
		//System.out.println("member===="+member);
		
		String mesg="사용 가능합니다.";//dto null
		
		if (data=="") {
			mesg="내용을 입력해주세요.";
		} else if (member!=null) {
			mesg="이미 사용 중입니다.";
		}
		return mesg;
	}
	
	//회원 가입
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(@RequestParam Map<String, String> map, RedirectAttributes m) {//MemberDTO dto로 받았을 때 데이터 잘 가져오는 건 이해가 되는데,, map은 어떻게 key=value로 가져오는 걸까? 신기한데,,
		//System.out.println("회원 가입 : "+map);
		String nextPage="";
		int num=0;
		
		try {
			num=service.joinMember(map);
			System.out.println(num+"명 회원 가입 완료");
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
		} finally {
			if (num>0) {
				m.addFlashAttribute("mesg", map.get("id")+"님 회원가입이 완료되었습니다.");
				nextPage="redirect:/login";
			} else {
				m.addFlashAttribute("mesg", "다시 시도해 주시기 바랍니다.");
				nextPage="redirect:/join";
			}
		}
		return nextPage;
	}
	
}
