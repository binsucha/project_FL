package com.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.MemberDTO;

@Repository
public class MemberDAO {
	@Autowired
	private SqlSessionTemplate session;
	
	//회원 가입
	public int join () {
		return 0;
	}

	//회원 가입 데이터 중복 확인
	public MemberDTO checkData(HashMap<String, String> map) {
		return session.selectOne("MemberMapper.checkData", map);
	}

	public int joinMember(Map<String, String> map) {
		return session.insert("MemberMapper.joinMember", map);
	}

	public MemberDTO checkId(Map<String, String> map) {
		return session.selectOne("MemberMapper.checkId", map);
	}

	public MemberDTO login(Map<String, String> map) {
		return session.selectOne("MemberMapper.login", map);
	}

}
