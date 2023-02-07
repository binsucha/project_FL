package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.CategoryDTO;
import com.dto.MemberDTO;
import com.dto.ShopDTO;

@Repository
public class ShopDAO {
	@Autowired
	private SqlSessionTemplate session;

	//가게 데이터 중복 확인
	public String checkData(Map<String, String> map) {
		return session.selectOne("ShopMapper.checkData", map);
	}

	public List<CategoryDTO> category() {
		return session.selectList("ShopMapper.category");
	}
	
	//가게 등록
	public int insertShop(Map<String, String> map) {
		return session.insert("ShopMapper.insertShop", map);
	}

	//가게 번호 가져오기
	public int selectShopNo(Map<String, String> map) {
		return session.selectOne("ShopMapper.selectShopNo", map);
	}
	
	//가게 이미지 등록
	public int insertShopImg(Map<String, String> map) {
		return session.insert("ShopMapper.insertShopImg", map);
	}

	
}
