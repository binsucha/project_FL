package com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.MemberDTO;
import com.dto.ReviewDTO;
import com.dto.ShopDTO;
import com.service.MemberService;
import com.service.ShopService;

@Controller
public class MypageController {
	@Autowired
	private MemberService service;
	@Autowired
	private ShopService shopService;
	
	//마이페이지 메인
	@RequestMapping(value = "/mypage/{id}", method = RequestMethod.GET)
	public String mypage(@PathVariable("id") String id, Model model) {
		//System.out.println("mypage====");
		
		//회원이 작성한 후기 목록
		List<ReviewDTO> reviewList=service.selectMemberReview(id);
		for (ReviewDTO reviewDTO : reviewList) {
			System.out.println(reviewDTO);
		}
		//회원이 스크랩한 가게 목록
		List<Integer> list=service.selectMemberShop(id);
		List<ShopDTO> scrapList=new ArrayList<ShopDTO>();
		for (Integer shopNo : list) {
			System.out.println(shopNo);
			ShopDTO shop=shopService.selectShop(shopNo);
			scrapList.add(shop);
		}
		for (ShopDTO shopDTO : scrapList) {
			System.out.println(shopDTO);
		}
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("scrapList", scrapList);
		return "mypage";
	}
	
	//마이페이지 비밀번호 인증
	@RequestMapping(value = "/mypage/{id}/check", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String checkPw(@PathVariable("id") String id, @RequestParam Map<String, String> map) {
		//System.out.println("mypage====checkPw "+id+" : "+map);
		String mesg="";
		MemberDTO member=service.login(map);//아이디, 비밀번호 매칭
		
		if (member!=null) {//인증
			//System.out.println("비밀번호 인증");
			mesg="1";
		} else {
			//System.out.println("비밀번호 오류");
			mesg="0";
		}
		return mesg;
	}
	
	//회원 정보 수정 화면
	@RequestMapping(value = "/mypage/{id}/account", method = RequestMethod.GET)
	public String accountForm() {
		//System.out.println("accountForm====");
		return "accountForm";
	}
	
	//회원 정보 수정
	@RequestMapping(value = "/mypage/{id}/account", method = RequestMethod.PUT)
	public String changeAccount(@PathVariable("id") String id, @RequestParam Map<String, String> map,
			HttpSession session, RedirectAttributes m) {
		//System.out.println("changeAccount====");
		//System.out.println(id+"님의 회원 정보 수정"+map);
		
		MemberDTO member=(MemberDTO)session.getAttribute("login");
		System.out.println("회원 정보 : "+member);
		HashMap<String, String> accountMap=new HashMap<String, String>();
		accountMap.put("id", id);
		int num=0;
		String mesg="";
		
		//기존 데이터와 비교해서 다르면 수정
		if (map.get("password")!="") {//비밀번호 데이터 있음
			if (!map.get("password").equals(member.getPassword())) {
				//System.out.println("비밀번호 수정");
				accountMap.put("data", map.get("password"));
				num+=service.changePassword(accountMap);
			}
		}
		if (!map.get("member_name").equals(member.getMember_name())) {
			//System.out.println("이름 수정");
			accountMap.put("data", map.get("member_name"));
			num+=service.changeName(accountMap);
		}
		if (!map.get("phone").equals(member.getPhone())) {
			//System.out.println("연락처 수정");
			accountMap.put("data", map.get("phone"));
			num+=service.changePhone(accountMap);
		}
		if (!map.get("email").equals(member.getEmail())) {
			//System.out.println("이메일 수정");
			accountMap.put("data", map.get("email"));
			num+=service.changeEmail(accountMap);
		}
		System.out.println("변경된 정보 : "+num);
		
		if (num>0) {
			mesg="회원 정보가 수정되었습니다.";
			MemberDTO updateMember=service.selectMember(accountMap);
			System.out.println("업데이트 회원 정보 : "+updateMember);
			session.setAttribute("login", updateMember);
		} else {
			mesg="변경된 회원 정보가 없습니다.";
		}
		m.addFlashAttribute("mesg", mesg);
		
		return "redirect:/mypage/"+id;//마이페이지 메인으로
	}
	
	//회원 탈퇴
	@RequestMapping(value = "/mypage/{id}/account", method = RequestMethod.DELETE)
	public String deleteMember(@PathVariable("id") String id, HttpSession session, RedirectAttributes m) {
		System.out.println("deleteMember===="+id);
		
		int num=service.deleteMember(id);
		System.out.println(num+"명 회원 탈퇴");
		
		session.invalidate();
		m.addFlashAttribute("mesg", "회원 탙퇴가 완료되었습니다.");
		
		return "redirect:/";
	}
	
	//회원 전체 후기
	@RequestMapping(value = "/mypage/{id}/review", method = RequestMethod.GET)
	@ResponseBody//////////
	public void selectMemberReview(@PathVariable("id") String id) {
		System.out.println(id+"====selectMemberReview");
	}
	
	//회원 전체 스크랩
	@RequestMapping(value = "/mypage/{id}/scrap", method = RequestMethod.GET)
	@ResponseBody//////////
	public void selectMemberShop(@PathVariable("id") String id) {
		System.out.println(id+"====selectMemberShop");
	}
}
