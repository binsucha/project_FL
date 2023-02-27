package com.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dto.Category2DTO;
import com.dto.CategoryDTO;
import com.dto.CommentDTO;
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
	
	//가게 리뷰 등록
	@RequestMapping(value = "/review/{shopNo}", method = RequestMethod.POST)
	public String insertReview(@PathVariable("shopNo") int shopNo, @RequestParam Map<String, Object> map,
			@RequestParam("imgFile") MultipartFile uploadFile) {
		System.out.println("insertReview===="+shopNo+"\t"+map+"\t"+uploadFile);
		map.put("shopNo", shopNo);
		
		//업로드 파일 저장 location
		String location = "C://eclipse//spring_project_FL//workspace//FoodieLeague//src//main//webapp//resources//review";
		try {
			//이미지가 있으면 map에 put && 파일 업로드
			//업로드 한 파일명//업로드 안 하면 이름 공백
			String fileName=uploadFile.getOriginalFilename();
			System.out.println("업로드 파일명 : "+fileName);
			
			if (!fileName.equals("")) {//업로드 했을 때만
				System.out.println("업로드 할 파일이  있습니다.");
				
				//폴더 위치
				File folder=new File(location);
				if (!folder.exists()) folder.mkdirs();
				
				//파일의 확장자 추출
				String ext=fileName.substring(fileName.indexOf("."));
				System.out.println("파일 확장자 : "+ext);
				
				//reName 규칙 설정
				SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rdv=(int)(Math.random()*1000);
				String reName=sdf.format(System.currentTimeMillis())+"_"+rdv+ext;
				System.out.println("파일 reName : "+reName);
				
				//파일명 저장
				map.put("reviewImgRoute", reName);
				System.out.println("이미지 있는 map : "+map);
				
				//이미지 포함 후기 데이터 저장
				service.insertReview(map);
				
				//파일 업로드
				File destination=new File(location+File.separator+reName);
				uploadFile.transferTo(destination);
			} else {
				System.out.println("업로드 할 파일이 없습니다.");
				System.out.println("이미지 없는 map : "+map);
				
				//이미지 없는 후기 데이터 저장
				service.insertReview(map);
			}
		} catch (Exception e) {
			e.getMessage();
		}
		return "redirect:/shop/"+shopNo;
	}
	
	//가게 후기 삭제
	@RequestMapping(value = "/review/{shopNo}/{reviewNo}", method = RequestMethod.DELETE)
	@ResponseBody
	public double deleteReview(@PathVariable("shopNo") int shopNo, @PathVariable("reviewNo") int reviewNo) {
		System.out.println("deleteReview===="+shopNo+"\t"+reviewNo);
		
		//후기의 이미지 데이터 select
		String reviewImg=service.selectReviewImg(reviewNo);
		System.out.println("리뷰 이미지 select : "+reviewImg);
		
		if (reviewImg!=null) {//리뷰에 이미지가 있으면
			deleteReviewImg(reviewImg);
		}
		
		//후기 삭제
		service.deleteReview(reviewNo);
		//삭제 후 가게 평점 select
		double rating=shopService.selectRating(shopNo);
		System.out.println(shopNo+"번 가게의 평점 : "+rating);
		
		return rating;
	}
	
	//리뷰 폴더 이미지 삭제
	private void deleteReviewImg(String reviewImg) {
		//서버에서 이미지 삭제
		//파일 경로 지정
		String filePath="C://eclipse//spring_project_FL//workspace//FoodieLeague//src//main//webapp//resources//review";
		//경로와 이름 추가한 파일 객체를 만듦
		File file=new File(filePath+"\\"+reviewImg);
		if(file.exists()) {//파일이 존재하면
			System.out.println("파일 존재====");
			file.delete();//파일 삭제
			System.out.println("삭제 완료====");
		}
	}
	
	//가게 후기 수정
	@RequestMapping(value = "/review/{shopNo}/{reviewNo}", method = RequestMethod.POST)
	public String updateReview(@PathVariable("shopNo") int shopNo, @PathVariable("reviewNo") int reviewNo,
			@RequestParam Map<String, Object> map,
			@RequestParam("updateImgFile") MultipartFile uploadFile) {
		System.out.println("updateReview===="+reviewNo+"\t"+map+"\t"+uploadFile);
		map.put("reviewNo", reviewNo);
		
		//기존 파일명//없으면 공백
		String oldFileName=(String) map.get("oldImgFile");
		System.out.println("기존 파일명 : "+oldFileName);
		
		//업로드 파일 저장 location
		String location = "C://eclipse//spring_project_FL//workspace//FoodieLeague//src//main//webapp//resources//review";
		try {
			//업로드 한 파일명//업로드 안 하면 이름 공백
			String fileName=uploadFile.getOriginalFilename();
			System.out.println("업로드 파일명 : "+fileName);
			
			if (!fileName.equals("")) {//업로드 이미지가 있으면 map에 put && 파일 업로드
				//파일의 확장자 추출
				String ext=fileName.substring(fileName.indexOf("."));
				System.out.println("파일 확장자 : "+ext);
				
				//reName 규칙 설정
				SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rdv=(int)(Math.random()*1000);
				String reName=sdf.format(System.currentTimeMillis())+"_"+rdv+ext;
				System.out.println("파일 reName : "+reName);
				
				//파일명 저장
				map.put("reviewImgRoute", reName);
				System.out.println("이미지 있는 map : "+map);
				
				//후기 수정
				service.updateReview(map);
				if (oldFileName.equals("")) {
					System.out.println("기존 이미지 X, 업로드 이미지 O : 이미지 추가");
					//후기 이미지 추가
					service.insertReviewImg(map);
				} else {
					System.out.println("기존 이미지 O, 업로드 이미지 O : 이미지 수정");
					//기존 이미지 삭제
					deleteReviewImg(oldFileName);
					//후기 이미지 수정
					service.updateReviewImg(map);
				}
				
				//파일 업로드
				File destination=new File(location+File.separator+reName);
				uploadFile.transferTo(destination);
			} else if (oldFileName.equals("") && fileName.equals("")) {
				System.out.println("기존 이미지 X, 업로드 이미지 X : 이미지 삭제");
				//후기 수정
				service.updateReview(map);
				
				//후기의 이미지 데이터 select
				String reviewImg=service.selectReviewImg(reviewNo);//기존 이미지 없으면 null
				System.out.println("리뷰 이미지 select : "+reviewImg);
				if (reviewImg!=null) {
					System.out.println("기존 이미지 있음---삭제하기");
					//후기 이미지 삭제
					service.deleteReviewImg(reviewNo);
					//이미지 파일 삭제
					deleteReviewImg(reviewImg);
				}
			} else {
				System.out.println("기존 이미지 O, 업로드 이미지 X : 기존 이미지 유지");
				//후기 수정
				service.updateReview(map);
			}
		} catch (Exception e) {
			e.getMessage();
		}
		return "redirect:/shop/"+shopNo;
	}
	
	//후기 댓글 등록
	@RequestMapping(value = "/review/{reviewNo}/comment", method = RequestMethod.POST)
	@ResponseBody
	public void insertComment(@RequestParam Map<String, String> map) {
		System.out.println("insertComment===="+map);
		int num=service.insertComment(map);
		System.out.println(num+"개 댓글 등록 완료");
	}
	
	//후기 댓글 출력
/*	@RequestMapping(value = "/review/{reviewNo}/comment", method = RequestMethod.GET)
	@ResponseBody
	public List<CommentDTO> comment(@PathVariable("reviewNo") int reviewNo) {
		System.out.println("comment===="+reviewNo);
		List<CommentDTO> commentList=service.selectComments(reviewNo);
		for (CommentDTO commentDTO : commentList) {
			System.out.println("후기의 댓글 : "+commentDTO);
		}
		
		return commentList;
	}	*/
	@RequestMapping(value = "/review/{reviewNo}/comment", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView comment(@RequestParam Map<String, String> map) {
		System.out.println("comment===="+map.get("reviewNo")+"의 마지막 댓글 번호 : "+map.get("lastNo"));
		System.out.println("후기 작성자 :"+map.get("reviewWriter"));
		
		List<CommentDTO> commentList=service.selectComments(map);
		for (CommentDTO commentDTO : commentList) {
			System.out.println("후기의 댓글 : "+commentDTO);
		}
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("commentList", commentList);
		mav.addObject("reviewWriter", map.get("reviewWriter"));
		mav.setViewName("comment");
		
		return mav;
	}
	
	//후기 댓글 삭제
	@RequestMapping(value = "/review/comment/{commentNo}", method = RequestMethod.DELETE)
	@ResponseBody
	public void deleteComment(@PathVariable("commentNo") int commentNo) {
		System.out.println("====deleteComment : "+commentNo);
		service.deleteComment(commentNo);
	}
	
	//후기 댓글 수정
	@RequestMapping(value = "/review/comment/{commentNo}", method = RequestMethod.PUT)
	@ResponseBody
	public void updateComment(@RequestBody Map<String, String> map) {
		System.out.println("====updateComment : "+map);
		service.updateComment(map);
	}
	
}
