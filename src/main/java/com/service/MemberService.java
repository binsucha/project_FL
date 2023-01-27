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

	public int joinMember(Map<String, String> map) {
		return dao.joinMember(map);
	}

	public MemberDTO checkId(Map<String, String> map) {
		return dao.checkId(map);
	}

	public MemberDTO login(Map<String, String> map) {
		return dao.login(map);
	}

}
