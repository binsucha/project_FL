package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ReviewDAO;
import com.dto.CommentDTO;
import com.dto.PageDTO;
import com.dto.ReviewDTO;
import com.dto.ScrapDTO;
import com.dto.ShopDTO;

@Service
public class ReviewService {
	@Autowired
	private ReviewDAO dao;

	//전체 가게 목록
	public PageDTO selectAllShop(HashMap<String, String> map) {
		return dao.selectAllShop(map);
	}

	//후기 데이터 저장
	public void insertReview(Map<String, Object> map) {
		dao.insertReview(map);
	}

	//가게 후기 목록
	public List<ReviewDTO> selectShopReviews(int shopNo) {
		return dao.selectShopReviews(shopNo);
	}

	//후기 댓글 등록
	public int insertComment(Map<String, String> map) {
		return dao.insertComment(map);
	}

	//후기의 댓글
	public List<CommentDTO> selectComments(Map<String, String> map) {
		return dao.selectComments(map);
	}

	//후기 댓글 삭제
	public void deleteComment(int commentNo) {
		dao.deleteComment(commentNo);
	}

	//후기 댓글 수정
	public void updateComment(Map<String, String> map) {
		dao.updateComment(map);
	}

	//가게 후기 삭제
	public void deleteReview(int reviewNo) {
		dao.deleteReview(reviewNo);
	}

	//후기 이미지 select
	public String selectReviewImg(int reviewNo) {
		return dao.selectReviewImg(reviewNo);
	}

	//후기 수정
	public void updateReview(Map<String, Object> map) {
		dao.updateReview(map);
	}
	public void insertReviewImg(Map<String, Object> map) {
		dao.insertReviewImg(map);
	}
	public void updateReviewImg(Map<String, Object> map) {
		dao.updateReviewImg(map);
	}
	public void deleteReviewImg(int reviewNo) {
		dao.deleteReviewImg(reviewNo);
	}

	//스크랩 목록
	public List<Integer> scrapList(String id) {
		return dao.scrapList(id);
	}
	
}
