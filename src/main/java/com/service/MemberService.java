package com.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.MemberDAO;
import com.dto.MemberDTO;

@Service
public class MemberService {
	@Autowired
	private MemberDAO dao;

	//회원 가입 데이터 중복 확인
	public MemberDTO checkData(HashMap<String, String> map) {
		return dao.checkData(map);
	}

	//회원 가입
	public int joinMember(Map<String, String> map) {
		return dao.joinMember(map);
	}

	//아이디로 회원 찾기
	public MemberDTO selectMember(Map<String, String> map) {
		return dao.selectMember(map);
	}

	//로그인 : 아이디-비밀번호 매칭
	public MemberDTO login(Map<String, String> map) {
		return dao.login(map);
	}

	//비밀번호 수정
	public int changePassword(HashMap<String, String> accountMap) {
		return dao.changePassword(accountMap);
	}
	
	//이름 수정
	public int changeName(HashMap<String, String> accountMap) {
		return dao.changeName(accountMap);
	}
	
	//연락처 수정
	public int changePhone(HashMap<String, String> accountMap) {
		return dao.changePhone(accountMap);
	}
	
	//이메일 수정
	public int changeEmail(HashMap<String, String> accountMap) {
		return dao.changeEmail(accountMap);
	}

	//회원 탈퇴
	public int deleteMember(String id) {
		return dao.deleteMember(id);
	}

}
