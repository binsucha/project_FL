package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.MainDAO;
import com.dto.MemberDTO;

@Service
public class MainService {
	@Autowired
	MainDAO dao;
	
	public MemberDTO selectMember() {
		MemberDTO member=dao.selectMember();
		return member;
	}
}