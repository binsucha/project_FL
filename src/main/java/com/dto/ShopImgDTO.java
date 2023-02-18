package com.dto;

public class ShopImgDTO {
	private int shop_no;
	private int shop_img_rank;
	private String shop_img_route;
	
	public ShopImgDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ShopImgDTO(int shop_no, int shop_img_rank, String shop_img_route) {
		super();
		this.shop_no = shop_no;
		this.shop_img_rank = shop_img_rank;
		this.shop_img_route = shop_img_route;
	}

	public int getShop_no() {
		return shop_no;
	}

	public void setShop_no(int shop_no) {
		this.shop_no = shop_no;
	}

	public int getShop_img_rank() {
		return shop_img_rank;
	}

	public void setShop_img_rank(int shop_img_rank) {
		this.shop_img_rank = shop_img_rank;
	}

	public String getShop_img_route() {
		return shop_img_route;
	}

	public void setShop_img_route(String shop_img_route) {
		this.shop_img_route = shop_img_route;
	}

	@Override
	public String toString() {
		return "ShopImgDTO [shop_no=" + shop_no + ", shop_img_rank=" + shop_img_rank + ", shop_img_route="
				+ shop_img_route + "]";
	}
	
}
