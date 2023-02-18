package com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dto.Category2DTO;
import com.dto.CategoryDTO;
import com.dto.PageDTO;
import com.dto.ShopDTO;
import com.dto.ShopImgDTO;
import com.service.ReviewService;
import com.service.ShopService;

@Controller
public class ReviewController {
	@Autowired
	private ReviewService service;
	@Autowired
	private ShopService shopService;
	
	//후기 게시판 메인
	@RequestMapping(value = "/reviewBoard", method = RequestMethod.GET)
	public ModelAndView reviewBoard(@RequestParam HashMap<String, String> map) {
		System.out.println("reviewBoard==== map : "+map);
		//카테고리 데이터 출력
		List<CategoryDTO> categoryList=shopService.category();
		List<Category2DTO> category2List=shopService.category2();
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("categoryList", categoryList);
		mav.addObject("category2List", category2List);
		
		//검색, 정렬, 카테고리 데이터
		mav.addObject("searchName", map.get("searchName"));
		mav.addObject("searchValue", map.get("searchValue"));
		mav.addObject("sortBy", map.get("sortBy"));
		mav.addObject("category", map.get("categoryNo"));
		
		//페이징 처리된 데이터
		PageDTO paging=service.selectAllShop(map);
		System.out.println("paging : "+paging);//가게 목록은 toString 제외, 하단에 for문으로 출력
		for (int i = 0; i < paging.getList().size(); i++) {
			System.out.println("가게"+(i+1)+"\t"+paging.getList().get(i));
		};
		
		//회원이 스크랩한 가게 표시
		
		mav.addObject("paging", paging);
		mav.setViewName("reviewBoard");
		return mav;
	}
	
	//가게 이미지 변경
	@RequestMapping(value = "/reviewBoard/img", method = RequestMethod.GET)
	@ResponseBody
	public List<ShopImgDTO> shopImg(@RequestParam HashMap<String, String> map) {
		System.out.println("shopImg====");
		System.out.println(map);
		
		List<ShopImgDTO> imgList=shopService.selectShopImg(map);
		System.out.println(imgList);
		
		return imgList;
	}
	
}
