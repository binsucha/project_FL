package com.dto;

public class ReviewDTO {
	private int review_no;
	private String id;
	private int shop_no;
	private double rate;
	private String review_content;
	private String review_created;
	
	private String review_img_route;
	private String member_name;
	
	private String shop_name;

	public ReviewDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ReviewDTO(int review_no, String id, int shop_no, double rate, String review_content, String review_created,
			String review_img_route, String member_name, String shop_name) {
		super();
		this.review_no = review_no;
		this.id = id;
		this.shop_no = shop_no;
		this.rate = rate;
		this.review_content = review_content;
		this.review_created = review_created;
		this.review_img_route = review_img_route;
		this.member_name = member_name;
		this.shop_name = shop_name;
	}

	public int getReview_no() {
		return review_no;
	}

	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getShop_no() {
		return shop_no;
	}

	public void setShop_no(int shop_no) {
		this.shop_no = shop_no;
	}

	public double getRate() {
		return rate;
	}

	public void setRate(double rate) {
		this.rate = rate;
	}

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public String getReview_img_route() {
		return review_img_route;
	}

	public void setReview_img_route(String review_img_route) {
		this.review_img_route = review_img_route;
	}
	
	public String getReview_created() {
		return review_created;
	}

	public void setReview_created(String review_created) {
		this.review_created = review_created;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getShop_name() {
		return shop_name;
	}

	public void setShop_name(String shop_name) {
		this.shop_name = shop_name;
	}

	@Override
	public String toString() {
		return "ReviewDTO [review_no=" + review_no + ", id=" + id + ", shop_no=" + shop_no + ", rate=" + rate
				+ ", review_content=" + review_content + ", review_created=" + review_created + ", review_img_route="
				+ review_img_route + ", member_name=" + member_name + ", shop_name=" + shop_name + "]";
	}

}
