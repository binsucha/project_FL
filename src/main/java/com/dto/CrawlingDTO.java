package com.dto;

public class CrawlingDTO {
	String shop_url;
	String shop_name;
	String category;
	String status;
	String rate;
	
	public CrawlingDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CrawlingDTO(String shop_url, String shop_name, String category, String status, String rate) {
		super();
		this.shop_url = shop_url;
		this.shop_name = shop_name;
		this.category = category;
		this.status = status;
		this.rate = rate;
	}

	public String getShop_url() {
		return shop_url;
	}

	public void setShop_url(String shop_url) {
		this.shop_url = shop_url;
	}

	public String getShop_name() {
		return shop_name;
	}

	public void setShop_name(String shop_name) {
		this.shop_name = shop_name;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	@Override
	public String toString() {
		return "CrawlingDTO [shop_url=" + shop_url + ", shop_name=" + shop_name + ", category=" + category + ", status="
				+ status + ", rate=" + rate + "]";
	}
	
}
