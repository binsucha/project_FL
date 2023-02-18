package com.dto;

public class Category2DTO {
	private int category2_no;
	private String category2_name;
	private int category2_rank;
	
	public Category2DTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Category2DTO(int category2_no, String category2_name, int category2_rank) {
		super();
		this.category2_no = category2_no;
		this.category2_name = category2_name;
		this.category2_rank = category2_rank;
	}

	public int getCategory2_no() {
		return category2_no;
	}

	public void setCategory2_no(int category2_no) {
		this.category2_no = category2_no;
	}

	public String getCategory2_name() {
		return category2_name;
	}

	public void setCategory2_name(String category2_name) {
		this.category2_name = category2_name;
	}

	public int getCategory2_rank() {
		return category2_rank;
	}

	public void setCategory2_rank(int category2_rank) {
		this.category2_rank = category2_rank;
	}

	@Override
	public String toString() {
		return "Category2DTO [category2_no=" + category2_no + ", category2_name=" + category2_name + ", category2_rank="
				+ category2_rank + "]";
	}
	
}
