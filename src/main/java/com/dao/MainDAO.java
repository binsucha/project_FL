package com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.MemberDTO;

@Repository
public class MainDAO {
	@Autowired
	private SqlSessionTemplate session;

	public List<MemberDTO> selectAllMember() {
		return session.selectList("MemberMapper.selectAllMember");
	}

}