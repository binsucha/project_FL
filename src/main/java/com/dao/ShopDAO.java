package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.Category2DTO;
import com.dto.CategoryDTO;
import com.dto.MemberDTO;
import com.dto.ShopDTO;
import com.dto.ShopImgDTO;

@Repository
public class ShopDAO {
	@Autowired
	private SqlSessionTemplate session;

	//가게 데이터 중복 확인
	public String checkData(Map<String, String> map) {
		return session.selectOne("ShopMapper.checkData", map);
	}

	//카테고리 출력
	public List<CategoryDTO> category() {
		return session.selectList("ShopMapper.category");
	}
	
	//카테고리2 출력
	public List<Category2DTO> category2() {
		return session.selectList("ShopMapper.category2");
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

	//가게 이미지 가져오기
	public List<ShopImgDTO> selectShopImg(HashMap<String, String> map) {
		return session.selectList("ShopMapper.selectShopImg", map);
	}

	//가게 상세 페이지
	public ShopDTO selectShop(int shopNo) {
		return session.selectOne("ShopMapper.selectShop", shopNo);
	}

	//가게 평점 출력
	public double selectRating(int shopNo) {
		return session.selectOne("ShopMapper.selectRating", shopNo);
	}

	//가게 삭제
	public void deleteShop(int shopNo) {
		int num=session.delete("ShopMapper.deleteShop", shopNo);
		System.out.println(num+"개 가게 삭제 완료");
	}

	//가게 이미지 삭제
	public void deleteShopImg(String shopNo) {
		int num=session.delete("ShopMapper.deleteShopImg", shopNo);
		System.out.println(num+"개 가게 이미지 삭제 완료");
	}

	//스크랩 확인
	public int checkScrap(Map<String, String> map) {
		return session.selectOne("ShopMapper.checkScrap", map);
	}

	//스크랩 추가
	public void addScrap(Map<String, String> map) {
		int num=session.insert("ShopMapper.addScrap", map);
		System.out.println(num+"개 스크랩 추가");
	}

	//스크랩 취소
	public void deleteScrap(Map<String, String> map) {
		int num=session.delete("ShopMapper.deleteScrap", map);
		System.out.println(num+"개 스크랩 취소");
	}
	
}
