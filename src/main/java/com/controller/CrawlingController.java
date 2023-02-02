package com.controller;


import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.CrawlingDTO;

@Controller
public class CrawlingController {
	
	@RequestMapping(value = "/crawl/{locationSearch}", method = RequestMethod.GET)
	public String crawlSelect(@PathVariable("locationSearch") String locationSearch, RedirectAttributes m) throws Exception {
		System.out.println("crawlSelect====지역 검색 : "+locationSearch);
		
		//url 지정
		String url="https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query="+locationSearch+"맛집";
		
		//1. Document를 가져온다.
		Document doc=Jsoup.connect(url).get();
		System.out.println("url : "+url);
		//System.out.println("doc : "+doc);

		//2. 가게 목록을 가져온다.
		Elements list=doc.getElementsByAttributeValue("class", "UEzoS VHJNR");//광고 제외 6개 업체
		//Elements shopNames = doc.getElementsByAttributeValue("class", "place_bluelink TYaxT");//광고 2개 포함 shopNames
		ArrayList<CrawlingDTO> shopList=new ArrayList<CrawlingDTO>();
		for (Element ele : list) {
			//Elements aTags=ele.select(".CHC5F a:first-child");
/*			for (Element aTag : aTags) {
				String href=aTag.attr("abs:href");//a태그 href의 절대주소 저장//랜덤하게 두번째에 검색어 링크가 출력됨--첫번째만 저장
				System.out.println("상세페이지 링크 : "+href);
			}	*/
			//String href=aTags.get(0).attr("abs:href");//a태그 href의 절대주소 저장//네이버 지도에서 가게 이름 검색한 url로 지정
			String shopName=ele.getElementsByAttributeValue("class", "place_bluelink TYaxT").text();//광고 제외한 ele에서 shopNames 출력
			//String href="https://map.naver.com/v5/search/"+shopName;//네이버 지도에서 가게 이름 검색한 url로 지정//가게 상세정보가 나오지 않음--네이버 지도는 사용하기 어려운듯
			String href="https://search.naver.com/search.naver?where=nexearch%26sm=top_hty%26fbm=0%26ie=utf8%26query="+shopName;//네이버에서 가게 이름 검색한 url로 지정--& 주의
			String category=ele.getElementsByAttributeValue("class", "KCMnt").text();
			//String status=ele.select(".MVx6e span:first-child").text();//해당 class의 첫번째 span 선택--TV는 왜 나오는데 ㅠ//fist span을 선택하면 '새로오픈'이 출력되는 경우 발생
			//영업 상태가 2종류의 class명을 갖고 있음
			String aroundTheClock=ele.getElementsByAttributeValue("class", "h69bs KvAhC").text();//24시간 영업점
			String status=ele.getElementsByAttributeValue("class", "h69bs KvAhC utj_r").text();//24시간 영업XXX
			if (!aroundTheClock.equals("")) {//24시간 영업점인 경우 status 데이터 변경
				//System.out.println("24시간 영업=====");
				status=aroundTheClock;
			}
			String rateString=ele.getElementsByAttributeValue("class", "h69bs a2RFq").text();//별점 문자 지우기
			String rate=rateString.replace("별점", "");//별점 지우고 변수에 저장
			
			
/*			System.out.println("상세페이지 url : "+href);
			System.out.println("가게명 : "+shopName);
			System.out.println("카테고리 : "+category);
			System.out.println("영업 상태 : "+status);
			System.out.println("평점 : "+rate);
			System.out.println("========================================");	*/
			
			CrawlingDTO shop=new CrawlingDTO(href, shopName, category, status, rate);
			shopList.add(shop);
		}
		System.out.println(shopList);
		m.addFlashAttribute("shopList", shopList);
		
		return "redirect:/location";
	}
}
