package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.CommentDTO;
import com.dto.PageDTO;
import com.dto.ReviewDTO;
import com.dto.ShopDTO;

@Repository
public class ReviewDAO {
	@Autowired
	private SqlSessionTemplate session;

	//전체 가게 목록
	public PageDTO selectAllShop(HashMap<String, String> map) {
		int page=Integer.parseInt(map.getOrDefault("page", "1"));//map에서 page 값 가져옴, 없으면 default 1
		PageDTO pDTO=new PageDTO();
		pDTO.setPerPage(6);//한 페이지에 레코드 개수//////////
		int perPage=pDTO.getPerPage();
		int offset=(page-1)*perPage;//해당 페이지에서 출력되는 first index 값
		
		List<ShopDTO> list=session.selectList("ReviewMapper.selectAllShop", map, new RowBounds(offset, perPage));
		
		pDTO.setPage(page);//현재 페이지 번호
		pDTO.setList(list);//가져온 list를 pDTO에 set
		pDTO.setTotalCount(countTotalShop(map));//전체 레코드 개수
		//System.out.println("전체 레코드 개수 : "+countTotalShop(map));
		//System.out.println("한 페이지 레코드 개수 : "+perPage);
		
		pDTO.setFirstLastPages();//firstPage, lastPage, prev, next 생성 함수 호출
		
		return pDTO;
	}
	
	//가게 목록 전체 개수 for 페이징
	private int countTotalShop(HashMap<String, String> map) {
		return session.selectOne("ReviewMapper.countTotalShop", map);
	}

	//후기 데이터 저장
	public void insertReview(Map<String, Object> map) {
		int num=session.insert("ReviewMapper.insertReview", map);
		System.out.println(num+"개 후기 저장 완료");
	}

	//가게 후기 목록
	public List<ReviewDTO> selectShopReviews(int shopNo) {
		return session.selectList("ReviewMapper.selectShopReviews", shopNo);
	}

	//후기 댓글 등록
	public int insertComment(Map<String, String> map) {
		return session.insert("ReviewMapper.insertComment", map);
	}

	//후기의 댓글
	public List<CommentDTO> selectComments(Map<String, String> map) {
		return session.selectList("ReviewMapper.selectComments", map);
	}

	//후기 댓글 삭제
	public void deleteComment(int commentNo) {
		int num=session.delete("ReviewMapper.deleteComment", commentNo);
		System.out.println(num+"개 댓글 삭제 완료");
	}

	//후기 댓글 수정
	public void updateComment(Map<String, String> map) {
		int num=session.update("ReviewMapper.updateComment", map);
		System.out.println(num+"개 댓글 수정 완료");
	}
	
}
