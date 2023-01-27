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

	//회원 가입 아이디 중복 확인
	public MemberDTO checkId(HashMap<String, String> map) {
		return dao.checkId(map);
	}

	public int joinMember(Map<String, String> map) {
		return dao.joinMember(map);
	}

}
