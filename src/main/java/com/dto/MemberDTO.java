package com.dto;

public class MemberDTO {
	String id;
	String password;
	String member_name;
	String email1;
	String email2;
	String phone;
	int member_role;
	
	public MemberDTO() {
		super();
	}
	
	public MemberDTO(String id, String password, String member_name, String email1, String email2, String phone) {
		super();
		this.id = id;
		this.password = password;
		this.member_name = member_name;
		this.email1 = email1;
		this.email2 = email2;
		this.phone = phone;
		this.member_role = 1;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getEmail1() {
		return email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getEmail2() {
		return email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getMember_role() {
		return member_role;
	}

	public void setMember_role(int member_role) {
		this.member_role = member_role;
	}

	@Override
	public String toString() {
		return "MemberDTO [id=" + id + ", password=" + password + ", member_name=" + member_name + ", email1=" + email1
				+ ", email2=" + email2 + ", phone=" + phone + ", member_role=" + member_role + "]";
	}
	
}