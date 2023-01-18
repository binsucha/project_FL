package com.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.MemberDTO;

@Repository
public class MainDAO {
	
	@Autowired
	private SqlSessionTemplate session;

	public MemberDTO selectMember() {
		MemberDTO member=session.selectOne("MemberMapper.selectMember");
		return member;
	}

}