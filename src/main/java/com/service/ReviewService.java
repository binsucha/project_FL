package com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ReviewDAO;
import com.dto.PageDTO;
import com.dto.ShopDTO;

@Service
public class ReviewService {
	@Autowired
	private ReviewDAO dao;

	//전체 가게 목록
	public PageDTO selectAllShop(HashMap<String, String> map) {
		return dao.selectAllShop(map);
	}
	
}
