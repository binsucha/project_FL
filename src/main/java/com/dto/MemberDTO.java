package com.dto;

import org.apache.ibatis.type.Alias;

//@Alias("MemberDTO")//root-context.xml 설정이랑 충돌하는지 실행하면 오류나서 막아둠,, 한참 괜찮았는데 오류가 갑자기 발생하네?
public class MemberDTO {
	private String id;
	private String password;
	private String member_name;
	private String email;
	private String phone;
	private int member_role;
	
	public MemberDTO() {
		super();
	}
	
	public MemberDTO(String id, String password, String member_name, String email, String phone) {
		super();
		this.id = id;
		this.password = password;
		this.member_name = member_name;
		this.email = email;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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
		return "MemberDTO [id=" + id + ", password=" + password + ", member_name=" + member_name + ", email=" + email
				+ ", phone=" + phone + ", member_role=" + member_role + "]";
	}
	
}