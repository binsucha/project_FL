package com.dto;

public class ShopDTO {
	int shop_no;
	String shop_name;
	int category_no;
	int category2_no;
	String shop_location;
	String shop_contact;
	String shop_status;
	String shop_info;
	int average_rate;
	String shop_created;
	int shop_hits;
	
	public ShopDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ShopDTO(int shop_no, String shop_name, int category_no, int category2_no, String shop_location,
			String shop_contact, String shop_status, String shop_info, int average_rate, String shop_created,
			int shop_hits) {
		super();
		this.shop_no = shop_no;
		this.shop_name = shop_name;
		this.category_no = category_no;
		this.category2_no = category2_no;
		this.shop_location = shop_location;
		this.shop_contact = shop_contact;
		this.shop_status = shop_status;
		this.shop_info = shop_info;
		this.average_rate = average_rate;
		this.shop_created = shop_created;
		this.shop_hits = shop_hits;
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

	public String getShop_status() {
		return shop_status;
	}

	public void setShop_status(String shop_status) {
		this.shop_status = shop_status;
	}

	public String getShop_info() {
		return shop_info;
	}

	public void setShop_info(String shop_info) {
		this.shop_info = shop_info;
	}

	public int getAverage_rate() {
		return average_rate;
	}

	public void setAverage_rate(int average_rate) {
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

	@Override
	public String toString() {
		return "ShopDTO [shop_no=" + shop_no + ", shop_name=" + shop_name + ", category_no=" + category_no
				+ ", category2_no=" + category2_no + ", shop_location=" + shop_location + ", shop_contact="
				+ shop_contact + ", shop_status=" + shop_status + ", shop_info=" + shop_info + ", average_rate="
				+ average_rate + ", shop_created=" + shop_created + ", shop_hits=" + shop_hits + "]";
	}
	
}