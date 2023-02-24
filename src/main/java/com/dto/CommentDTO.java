package com.dto;

public class CommentDTO {
	private int review_no;
	private String id;
	private String comment_content;
	private String comment_created;
	private int comment_no;
	
	private String member_name;
	
	public CommentDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CommentDTO(int review_no, String id, String comment_content, String comment_created, int comment_no,
			String member_name) {
		super();
		this.review_no = review_no;
		this.id = id;
		this.comment_content = comment_content;
		this.comment_created = comment_created;
		this.comment_no = comment_no;
		this.member_name = member_name;
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

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public String getComment_created() {
		return comment_created;
	}

	public void setComment_created(String comment_created) {
		this.comment_created = comment_created;
	}
	
	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	
	public int getComment_no() {
		return comment_no;
	}

	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
	}

	@Override
	public String toString() {
		return "CommentDTO [review_no=" + review_no + ", id=" + id + ", comment_content=" + comment_content
				+ ", comment_created=" + comment_created + ", comment_no=" + comment_no + ", member_name=" + member_name
				+ "]";
	}

}
