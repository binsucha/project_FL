package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.MemberDAO;
import com.dao.ShopDAO;
import com.dto.CategoryDTO;
import com.dto.MemberDTO;
import com.dto.ShopDTO;

@Service
public class ShopService {
	@Autowired
	private ShopDAO dao;

	//가게 데이터 중복 확인
	public String checkData(Map<String, String> map) {
		return dao.checkData(map);
	}

	public List<CategoryDTO> category() {
		return dao.category();
	}

	//가게 등록
	public int insertShop(Map<String, String> map) {
		return dao.insertShop(map);
	}

	//가게 번호 가져오기
	public int selectShopNo(Map<String, String> map) {
		return dao.selectShopNo(map);
	}
	
	//가게 이미지 등록
	public int insertShopImg(Map<String, String> map) {
		return dao.insertShopImg(map);
	}


}
