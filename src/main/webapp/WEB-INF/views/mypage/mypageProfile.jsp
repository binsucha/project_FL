<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<style>
	.profile {
		float: left;
	}
</style>

<div class="profile col-md-2">
	<div class="card">
	  <div class="card-body">
	    <h4 class="card-title">${login.member_name}님</h4>
	    <h6 class="card-subtitle mb-2 text-muted">Member Ranking</h6>
	    <div class="col-md-12" style="text-align: center; margin: 20 0 20 0;">
	    	<img src="${contextPath}/resources/image/defaultProfile.png" width="80%">
	    </div>
	    <span class="badge bg-primary" onclick="check()">회원 정보 수정</span>
	    <span class="badge bg-primary">프로필 수정</span>
	  </div>
	</div>
</div>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#okay").click(function() {
			//var id=${login.id};//--데이터가 문자인 경우 오류 발생하는 코드
			var password=$("#textArea").val();
			//console.log(password);
			//ajax로 비밀번호 인증 후 정보 수정 폼으로 이동
			$.ajax({
				type : "get",
				url : "${contextPath}/mypage/${login.id}/check",
				contentType:"application/json;charset=UTF-8",//매개변수 map으로 받을 수 있도록
				data : {
					//id : id,//변수 id가 문자로 인식되지 않음, 따옴표로 감싸도 오류 발생
					id : "${login.id}",//왜 오류?--따옴표로 감싸줘서 문자임을 인식시켜줘야함 : 변수임을 확실히 해야함
					password : password
				},
				success : function(responseData, status, xhr) {
					//console.log("성공====",responseData);//인증하면 1, 오류는 0
					if (responseData==1) {
						//회원 정보 수정 폼
						location.href="${contextPath}/mypage/${login.id}/account";//주소 요청, 페이지 이동
					} else {
						//비밀번호 오류
						//현재 modal open 상태
						$("#mypageModalMesg").text("비밀번호가 틀렸습니다.");
						$("#textArea").val("");
						$("#textArea").focus();
					}
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
			});//end ajax
		});//end fn
		
		//프로필 수정
		
	});//end ready
	
	//회원 정보 수정 클릭
 	function check() {
		$("#mypageModalBtn").trigger("click");
		$("#mypageModalMesg").text("비밀번호를 입력하세요.");
		$("#mypageModal").on("shown.bs.modal", function () {
			$("#textArea").focus();//첫번째 오픈 시 포커스 안 됨 ㅠㅠ 두번째부터는 됨,,
		});
	}
	
</script>