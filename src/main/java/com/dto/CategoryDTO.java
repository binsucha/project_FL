package com.dto;

public class CategoryDTO {
	private int category_no;
	private String category_name;
	private int category_rank;
	
	public CategoryDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public CategoryDTO(int category_no, String category_name, int category_rank) {
		super();
		this.category_no = category_no;
		this.category_name = category_name;
		this.category_rank = category_rank;
	}
	
	public int getCategory_no() {
		return category_no;
	}
	
	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}
	
	public String getCategory_name() {
		return category_name;
	}
	
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	
	public int getCategory_rank() {
		return category_rank;
	}
	
	public void setCategory_rank(int category_rank) {
		this.category_rank = category_rank;
	}
	
	@Override
	public String toString() {
		return "CategoryDTO [category_no=" + category_no + ", category_name=" + category_name + ", category_rank="
				+ category_rank + "]";
	}
	
}
