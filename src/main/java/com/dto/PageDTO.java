package com.dto;

import java.util.List;

public class PageDTO {
	private List list;//현재 페이지에 들어갈 레코드를 perPage만큼 저장 
	private int page;//현재 페이지 번호 
	private int perPage;//한 페이지에 보여질 레코드 개수 
	private int totalCount;//전체 레코드 개수
	
	private int firstPage;//현재 화면에 보이는 시작 번호
	private int lastPage;//현재 화면에 보이는 끝 번호
	
	boolean prev;//이전 존재
	boolean next;//다음 존재
	
	public PageDTO() {
		super();
	}
	
	public void setFirstLastPages() {
		//현재 화면에 보이는 끝번호/시작번호
		lastPage=(int)(Math.ceil(page/5.0))*5;//5페이지까지만//////////
		//System.out.println(Math.ceil(page/5.0));
		//System.out.println("lastPage ==== "+lastPage);
		firstPage=lastPage-4;//////////
		//System.out.println("firstPage ==== "+firstPage);
		
		//진짜 끝번호 구하기
		int realLast=(int)(Math.ceil((totalCount*1.0)/perPage));
		//System.out.println("realLast ===="+realLast);
		if (realLast<lastPage) lastPage=realLast;
		
		//이전과 다음--조건 검사 후 return true OR false
		prev=firstPage > 1;
		next=lastPage < realLast;
	}

	public PageDTO(List list, int page, int perPage, int totalCount, int firstPage, int lastPage, boolean prev,
			boolean next) {
		super();
		this.list = list;
		this.page = page;
		this.perPage = perPage;
		this.totalCount = totalCount;
		this.firstPage = firstPage;
		this.lastPage = lastPage;
		this.prev = prev;
		this.next = next;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPerPage() {
		return perPage;
	}

	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getFirstPage() {
		return firstPage;
	}

	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	@Override//리스트 제외하고 출력
	public String toString() {
		return "PageDTO [page=" + page + ", perPage=" + perPage + ", totalCount=" + totalCount
				+ ", firstPage=" + firstPage + ", lastPage=" + lastPage + ", prev=" + prev + ", next=" + next + "]";
	}
	
}
