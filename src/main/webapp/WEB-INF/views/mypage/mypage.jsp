<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<style>
	.container {
		display: flex;
		flex-flow: row wrap;
		justify-content: space-between;
		align-items: center;
		align-content: flex-start;
	}
	.back {
		outline: solid 2px #eb6864;
		border-radius: 9px;
		height: 17rem;
		/* margine: 10 0 10 0; */
	}
	a {
		cursor: pointer;
	}
</style>
<div class="container">
	<div class="item card mb-3 col-md-4" style="flex-basis: 30%;">
	  <h3 class="card-header">${login.member_name}님</h3>
	  <div class="card-body">
	    <h5 class="card-title">매일 응원 메세지 스케줄링?</h5>
	    <h6 class="card-subtitle text-muted">오늘 날짜</h6>
	  </div>
	  <svg xmlns="http://www.w3.org/2000/svg" class="d-block user-select-none" width="100%" height="200" aria-label="Placeholder: Image cap" focusable="false" role="img" preserveAspectRatio="xMidYMid slice" viewBox="0 0 318 180" style="font-size:1.125rem;text-anchor:middle">
	    <rect width="100%" height="100%" fill="#868e96"></rect>
	    <text x="50%" y="50%" fill="#dee2e6" dy=".3em">Image cap</text>
	  </svg>
	  <div class="card-body">
	    <p class="card-text">블라블라~~</p>
	  </div>
	  <ul class="list-group list-group-flush">
	    <li class="list-group-item">마이페이지 홈</li>
	    <li class="list-group-item">작성 후기</li>
	    <li class="list-group-item">가볼 곳</li>
	  </ul>
	  <div class="card-body">
	    <a onclick="check()" class="card-link">회원 정보 수정</a>
	  </div>
	  <div class="card-footer text-muted">
	    2 days ago
	  </div>
	</div>
	<div class="item" style="flex-basis: 65%;"><!--  flex-flow: column wrap; justify-content: space-around; align-items: center; -->
		<div class="back"><!-- rem은 Root em을 의미하며 문서의 최상위 요소인 html 요소를 기준으로 크기를 결정합니다. -->
			작성 후기
		</div>
		<div style="height: 3rem;">
			공백
		</div>
		<div class="back">
			가볼 곳
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
	});
	
	//회원 정보 수정 클릭
 	function check() {
		$("#mypageModalBtn").trigger("click");
		$("#mypageModalMesg").text("비밀번호를 입력하세요.");
		$("#mypageModal").on("shown.bs.modal", function () {
			$("#textArea").focus();//첫번째 오픈 시 포커스 안 됨 ㅠㅠ 두번째부터는 됨,,
		});
	}
</script>