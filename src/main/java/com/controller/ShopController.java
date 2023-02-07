package com.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dto.CategoryDTO;
import com.service.ShopService;

@Controller
public class ShopController {
	@Autowired
	private ShopService service;
	
	@RequestMapping(value = "/location", method = RequestMethod.GET)
	public String searchLocation() {
		System.out.println("searchLocation====");
		return "searchLocation";
	}
	
	//가게 등록 폼 출력
	@RequestMapping(value = "/shop", method = RequestMethod.GET)
	public ModelAndView shopForm() {
		System.out.println("shopForm====");
		//카테고리 데이터 출력
		List<CategoryDTO> categoryList=service.category();
		//System.out.println(categoryList);
		ModelAndView mav=new ModelAndView();
		mav.addObject("categoryList", categoryList);
		mav.setViewName("shopForm");
		return mav;
	}
	
	//네이버에서 가게 이름 검색 결과
	@RequestMapping(value = "/shop/{shopName}", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, String> shopInfo(@PathVariable("shopName") String shopName) throws Exception {
		String url="https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query="+shopName;//네이버에서 가게 이름 검색한 url로 지정--& 주의
		System.out.println("shopInfo===="+shopName);
		//System.out.println("url : "+url);
		
		Document doc=Jsoup.connect(url).get();
		//System.out.println("doc : "+doc);
		
		//가게의 상세 정보 가져오기
		String name=doc.getElementsByAttributeValue("class", "Fc1rA").text();
		String category=doc.getElementsByAttributeValue("class", "DJJvD").text();
		String shopLocation=doc.getElementsByAttributeValue("class", "LDgIH").text();
		String status=doc.select(".A_cdD em:first-child").text();
		String shopHoursInfo=doc.select(".U7pYf .place_blind").text();
		String shopContact=doc.getElementsByAttributeValue("class", "xlx7Q").text();
		
		//System.out.println("가게명 : "+name);
/*		System.out.println("카테고리 : "+category);
		System.out.println("가게 위치 : "+shopLocation);
		System.out.println("영업 상태 : "+status);
		System.out.println("영업시간 안내 : "+shopHoursInfo);
		System.out.println("연락처 : "+shopContact);	*/
		//요일별 영업시간이랑 이미지는 파싱 실패
		
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("shopName", name);
		map.put("shopLocation", shopLocation);
		map.put("status", status);
		map.put("shopHoursInfo", shopHoursInfo);
		map.put("shopContact", shopContact);
		System.out.println(map);

		return map;
	}
	
	//가게 중복 확인
	@RequestMapping(value = "/shop/data", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String checkData(@RequestParam Map<String, String> map) {
		//System.out.println("shop/checkData===="+map);//입력된 가게 이름, 연락처 데이터(공백 없음)
		String shopName=service.checkData(map);//DB에서 연락처로 가게 이름 검색
		//System.out.println("shopName : "+shopName);//DB에 저장된 가게 이름
		String mesg="";
		
		if (shopName==null) {//입력된 연락처로 저장된 가게 없음
			mesg="등록 가능한 가게입니다.";
		} else {//입력된 연락처로 저장된 가게 있음
			String name=shopName.replaceAll(" ", "");//가게 이름 공백 제거 후 저장
			if (name.equals(map.get("shopName"))) {//입력된 가게 이름과 저장된 가게 이름이 같음
				mesg="이미 존재하는 가게 정보입니다.";
			} else {//저장된 가게 이름과 다름
				mesg="다른 가게의 연락처로 등록된 번호입니다.";
			}
		}
		return mesg;
	}
	
	//가게 등록
	@RequestMapping(value = "/shop/{shopName}", method = RequestMethod.POST)
	@ResponseBody//지우기
	public String insertShop(@PathVariable("shopName") String shopName, @RequestParam Map<String, String> map,
			@RequestParam("imgFile") List<MultipartFile> uploadFiles) {
		//System.out.println("insertShop===="+shopName+map);//shopInfo는 데이터 없으면 공백, not null--Nullpointer err 없음
		//System.out.println("이미지===="+uploadFiles);
		
		//연락처 숫자만 저장하도록
		String shopContact=map.get("shopContact").replaceAll("-", "").replaceAll(" ", "");
		//System.out.println("연락처 - 제거, 공백 제거 : "+shopContact);
		map.put("shopContact", shopContact);
		
		int num=service.insertShop(map);
		System.out.println(num+"개 가게 등록");
		
		//등록한 가게 번호 가져오기
		int shopNo=service.selectShopNo(map);
		//System.out.println("등록한 가게 번호 :"+shopNo);
		
		//업로드 파일 저장 location
		String location = "C://eclipse//spring_project_FL//workspace//FoodieLeague//src//main//webapp//resources//upload";
		Map<String, String> imgMap=new HashMap<String, String>();
		imgMap.put("shopNo", Integer.toString(shopNo));
		try {
			int n=0;
			int imgRank=1;
			//for문 돌면서 이미지가 있으면 map에 put && 파일 업로드
			for (MultipartFile uploadFile : uploadFiles) {
				//업로드 한 파일명//업로드 안 하면 이름 공백
				String fileName=uploadFile.getOriginalFilename();
				//System.out.println("업로드 파일명 : "+fileName);
				
				if (!fileName.equals("")) {//업로드 했을 때만
					System.out.println("업로드 할 파일이  있습니다.");
					
					//폴더 위치
					File folder=new File(location);
					if (!folder.exists()) folder.mkdirs();
					
					//파일의 확장자 추출
					String ext=fileName.substring(fileName.indexOf("."));
					//System.out.println("파일 확장자 : "+ext);
					
					//reName 규칙 설정
					SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
					int rdv=(int)(Math.random()*1000);
					String reName=sdf.format(System.currentTimeMillis())+"_"+rdv+ext;
					//System.out.println("파일 reName : "+reName);
					
					//이미지 순서, 파일명 저장
					imgMap.put("imgRank", Integer.toString(imgRank));
					imgMap.put("imgRoute", reName);
					//System.out.println("map 확인 : "+imgMap);
					n+=service.insertShopImg(imgMap);
					imgRank++;
					
					//파일 업로드
					File destination=new File(location+File.separator+reName);
					uploadFile.transferTo(destination);
				} else {
					System.out.println("업로드 할 파일이 없습니다.");
				}
			}//for문 종료, 이미지 데이터 저장 완료
			System.out.println(n+"개 가게 이미지 등록");
		} catch (Exception e) {
			e.getMessage();
		}
		
		return "";
	}
}
