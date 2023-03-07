package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.MemberDAO;
import com.dao.ShopDAO;
import com.dto.Category2DTO;
import com.dto.CategoryDTO;
import com.dto.MemberDTO;
import com.dto.ShopDTO;
import com.dto.ShopImgDTO;

@Service
public class ShopService {
	@Autowired
	private ShopDAO dao;

	//가게 데이터 중복 확인
	public String checkData(Map<String, String> map) {
		return dao.checkData(map);
	}

	//카테고리 출력
	public List<CategoryDTO> category() {
		return dao.category();
	}
	
	//카테고리2 출력
	public List<Category2DTO> category2() {
		return dao.category2();
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

	//가게 이미지 가져오기
	public List<ShopImgDTO> selectShopImg(HashMap<String, String> map) {
		return dao.selectShopImg(map);
	}

	//가게 상세 페이지
	public ShopDTO selectShop(int shopNo) {
		return dao.selectShop(shopNo);
	}

	//가게 평점 출력
	public double selectRating(int shopNo) {
		return dao.selectRating(shopNo);
	}

	//가게 삭제
	public void deleteShop(int shopNo) {
		dao.deleteShop(shopNo);
	}

	//가게 이미지 삭제
	public void deleteShopImg(String shopNo) {
		dao.deleteShopImg(shopNo);
	}

	//스크랩 확인
	public int checkScrap(Map<String, String> map) {
		return dao.checkScrap(map);
	}

	//스크랩 추가
	public void addScrap(Map<String, String> map) {
		dao.addScrap(map);
	}

	//스크랩 취소
	public void deleteScrap(Map<String, String> map) {
		dao.deleteScrap(map);
	}

}
