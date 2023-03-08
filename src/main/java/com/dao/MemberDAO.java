package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.MemberDTO;
import com.dto.ReviewDTO;
import com.dto.ShopDTO;

@Repository
public class MemberDAO {
	@Autowired
	private SqlSessionTemplate session;
	
	//회원 가입 데이터 중복 확인
	public MemberDTO checkData(HashMap<String, String> map) {
		return session.selectOne("MemberMapper.checkData", map);
	}

	//회원 가입
	public int joinMember(Map<String, String> map) {
		return session.insert("MemberMapper.joinMember", map);
	}

	//아이디로 회원 찾기
	public MemberDTO selectMember(Map<String, String> map) {
		return session.selectOne("MemberMapper.selectMember", map);
	}

	//로그인 : 아이디-비밀번호 매칭
	public MemberDTO login(Map<String, String> map) {
		return session.selectOne("MemberMapper.login", map);
	}

	//비밀번호 수정
	public int changePassword(HashMap<String, String> accountMap) {
		return session.update("MemberMapper.changePassword", accountMap);
	}
	
	//이름 수정
	public int changeName(HashMap<String, String> accountMap) {
		return session.update("MemberMapper.changeName", accountMap);
	}
	
	//연락처 수정
	public int changePhone(HashMap<String, String> accountMap) {
		return session.update("MemberMapper.changePhone", accountMap);
	}
	
	//이메일 수정
	public int changeEmail(HashMap<String, String> accountMap) {
		return session.update("MemberMapper.changeEmail", accountMap);
	}

	//회원 탈퇴
	public int deleteMember(String id) {
		return session.delete("MemberMapper.deleteMember", id);
	}

	//회원이 작성한 후기 목록
	public List<ReviewDTO> selectMemberReview(String id) {
		return session.selectList("MemberMapper.selectMemberReview", id);
	}

	//회원이 스크랩한 가게 목록
	public List<Integer> selectMemberShop(String id) {
		return session.selectList("MemberMapper.selectMemberShop", id);
	}

}
