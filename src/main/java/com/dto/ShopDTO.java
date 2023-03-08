package com.dto;

public class ShopDTO {
	private int shop_no;
	private String shop_name;
	private int category_no;
	private int category2_no;
	private String shop_location;
	private String shop_contact;
	private String shop_info;
	private double average_rate;
	private String shop_created;
	private int shop_hits;
	
	private String shop_img_rank;
	private String shop_img_route;
	
	private String category_name;
	private String category_rank;
	private String category2_name;
	private String category2_rank;
	
	public ShopDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ShopDTO(int shop_no, String shop_name, int category_no, int category2_no, String shop_location,
			String shop_contact, String shop_info, double average_rate, String shop_created, int shop_hits,
			String shop_img_rank, String shop_img_route, String category_name, String category_rank,
			String category2_name, String category2_rank) {
		super();
		this.shop_no = shop_no;
		this.shop_name = shop_name;
		this.category_no = category_no;
		this.category2_no = category2_no;
		this.shop_location = shop_location;
		this.shop_contact = shop_contact;
		this.shop_info = shop_info;
		this.average_rate = average_rate;
		this.shop_created = shop_created;
		this.shop_hits = shop_hits;
		this.shop_img_rank = shop_img_rank;
		this.shop_img_route = shop_img_route;
		this.category_name = category_name;
		this.category_rank = category_rank;
		this.category2_name = category2_name;
		this.category2_rank = category2_rank;
	}

	public int getShop_no() {
		return shop_no;
	}
	
	public void setShop_no(int shop_no) {
		this.shop_no = shop_no;
	}
	
	public String getShop_name() {
		return shop_name;
	}
	
	public void setShop_name(String shop_name) {
		this.shop_name = shop_name;
	}
	
	public int getCategory_no() {
		return category_no;
	}
	
	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}
	
	public int getCategory2_no() {
		return category2_no;
	}
	
	public void setCategory2_no(int category2_no) {
		this.category2_no = category2_no;
	}
	
	public String getShop_location() {
		return shop_location;
	}
	
	public void setShop_location(String shop_location) {
		this.shop_location = shop_location;
	}
	
	public String getShop_contact() {
		return shop_contact;
	}
	
	public void setShop_contact(String shop_contact) {
		this.shop_contact = shop_contact;
	}
	
	public String getShop_info() {
		return shop_info;
	}
	
	public void setShop_info(String shop_info) {
		this.shop_info = shop_info;
	}
	
	public double getAverage_rate() {
		return average_rate;
	}
	
	public void setAverage_rate(double average_rate) {
		this.average_rate = average_rate;
	}
	
	public String getShop_created() {
		return shop_created;
	}
	
	public void setShop_created(String shop_created) {
		this.shop_created = shop_created;
	}
	
	public int getShop_hits() {
		return shop_hits;
	}
	
	public void setShop_hits(int shop_hits) {
		this.shop_hits = shop_hits;
	}
	
	public String getShop_img_rank() {
		return shop_img_rank;
	}
	
	public void setShop_img_rank(String shop_img_rank) {
		this.shop_img_rank = shop_img_rank;
	}
	
	public String getShop_img_route() {
		return shop_img_route;
	}
	
	public void setShop_img_route(String shop_img_route) {
		this.shop_img_route = shop_img_route;
	}
	
	public String getCategory_name() {
		return category_name;
	}
	
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	
	public String getCategory_rank() {
		return category_rank;
	}
	
	public void setCategory_rank(String category_rank) {
		this.category_rank = category_rank;
	}
	
	public String getCategory2_name() {
		return category2_name;
	}
	
	public void setCategory2_name(String category2_name) {
		this.category2_name = category2_name;
	}
	
	public String getCategory2_rank() {
		return category2_rank;
	}
	
	public void setCategory2_rank(String category2_rank) {
		this.category2_rank = category2_rank;
	}

	@Override
	public String toString() {
		return "ShopDTO [shop_no=" + shop_no + ", shop_name=" + shop_name + ", category_no=" + category_no
				+ ", category2_no=" + category2_no + ", shop_location=" + shop_location + ", shop_contact="
				+ shop_contact + ", shop_info=" + shop_info + ", average_rate=" + average_rate + ", shop_created="
				+ shop_created + ", shop_hits=" + shop_hits + ", shop_img_rank=" + shop_img_rank + ", shop_img_route="
				+ shop_img_route + ", category_name=" + category_name + ", category_rank=" + category_rank
				+ ", category2_name=" + category2_name + ", category2_rank=" + category2_rank + "]";
	}
	
}