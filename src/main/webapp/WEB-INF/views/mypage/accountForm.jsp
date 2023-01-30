<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<style>
	.container {
		display: flex;
		justify-content: center;
		align-items: flex-start;
	}
	legend {
		color: #eb6864;
		font-weight: bolder;
	}
	label {
		font-weight: bolder;
	}
	.form-control {
		/* width: 60%;
		height: 5%; */
	}
	button {
		float: right;
	}
 	p {
		margin-left: 18px;
		font-weight: bolder;
		visibility: hidden;
	}
	.form-group {
		padding: 20 0 10 0;
	}
	#check {
		margin-left: -100px;
	}
</style>
<div class="container col-md-12" style="margin-top: 20px;"><!-- form 폭 조정 4, 위 여백 20 -->
<form method="post" action="${contextPath}/mypage/${login.id}/account">
  <input type="hidden" name="_method" value="put"><!-- method put으로 변경 -->
  <fieldset>
    <legend>회원 정보 수정</legend>
    <div class="container" tabindex="0">
    	<div class="item">
		    <div class="form-group">
		   	  <label for="id" class="form-label mt-4">아이디</label>
		      <input type="text" class="form-control" id="id" aria-describedby="idHelp" placeholder="${login.id}"
		      			style="display: inline-block;" readonly="readonly">
		    </div>
		    <div class="form-group">
		   	  <label for="password" class="form-label mt-4">비밀번호</label>
		      <input type="password" class="form-control" id="password" name="password" data-name="pw" placeholder="영문, 숫자, 특수문자 포함 8-20자">
		      <input type="password" class="form-control" id="pwCheck" data-name="pw" placeholder="비밀번호 확인">
		      <p class="form-text text-muted" id="pwMesg" data-name="mesg">변경할 비밀번호를 입력하세요.</p>
		    </div>
		    <div class="form-group">
		   	  <label for="phone" class="form-label mt-4">연락처</label>
		      <input type="tel" class="form-control" id="phone" name="phone" value="${login.phone}" readonly="readonly">
		      <button type="button" class="btn btn-outline-primary btn-sm" name="dataCheck" data-type="phone">연락처 변경</button>
		    </div>
		</div>
		<div class="item">
		    <div class="form-group">
		   	  <label for="memberName" class="form-label mt-4">이름</label>
		      <input type="text" class="form-control" id="memberName" name="member_name" aria-describedby="nameHelp" value="${login.member_name}"
		      			style="display: inline-block;" readonly="readonly">
		      <button type="button" class="btn btn-outline-primary btn-sm" name="dataCheck" data-type="memberName">이름 변경</button>
		    </div>
			<div class="form-group">
		   	  <label for="email" class="form-label mt-4">이메일</label>
		      <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" value="${login.email}"
		      			style="width: 100%;" readonly="readonly">
		      <button type="button" class="btn btn-outline-primary btn-sm" name="dataCheck" data-type="email">이메일 변경</button>
		    </div>
    	</div>
    </div>
    <button type="submit" class="btn btn-primary">수정</button>
    <button type="button" class="btn btn-light btn-sm" id="delete">회원 탈퇴</button>
  </fieldset>
</form>
</div>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		//데이터 중복 검사
		$("button[name=dataCheck]").click(function () {
			$("#modalBtn").trigger("click");
			$("#modalMesg").text("변경할 데이터를 입력해주세요.");
			//$("#modalText").focus();//왜 안 될까
			
			//var data=$("#modalText").val();//modal의 value를 변수에 저장해서 사용하려고 했는데 이렇게 하면 95행 data까지 전달이 안 됨
			var type=$(this).attr("data-type");
			
			$("#check").click(function() {
				console.log(type);//어떤 type인지 : 아이디, 이름, 연락처, 이메일
				//console.log(data);//modal input에 입력된 데이터
				console.log($("#modalText").val());//이렇게 직접 대입해야 데이터 출력됨
	  			$.ajax({
					type : "get",
					url : "${contextPath}/join/data",
					dataType : "text",
					data : {
						type : type,
						data : $("#modalText").val()
					},
					success : function(responseData, status, xhr) {
						//console.log("success : ",responseData);
						$("#modalMesg").text(responseData);
						
						if (responseData=="사용 가능합니다.") {//중복 확인 완료, 사용 버튼 클릭 가능
							//console.log("사용 가능");
							//console.log(type);
							$("#okay").attr("data-type",type);
						} else {//데이터 미입력 or 데이터 중복
							if (responseData=="이미 사용 중입니다.") {
								$("#modalText").val("");//중복 데이터 초기화
								$("#modalText").focus();
							}
						}
					},
					error : function(xhr, status, error) {
						console.log(error);
					}
				});//end ajax
			});//end okay
		});//end 수정 데이터 중복 확인
		
		//modal close 후 이벤트 중복 off
		$("#modal").on("hidden.bs.modal", function () {
			$("#check").off("click").on("click", function() {
				console.log("중복 클릭 해결");
			});//end fn
		});
						
		//사용 버튼 클릭
		$("#okay").click(function() {
			if ($("#modalText").val().length==0) {
				//console.log("데이터 없음");
				$("#modalMesg").text("사용 가능한 데이터를 입력하세요.");
			} else {
				//console.log("데이터 있음");
				//중복 검사 여부
				if ($("#modalMesg").text()!="사용 가능합니다.") {
					//console.log("중복 검사 안 함");
					$("#modalMesg").text("중복 여부를 확인해주세요.");
				} else {
					var type=$(this).attr("data-type");
					$("#"+type+"").val($("#modalText").val());//modal창 데이터를 form input에 대입
					$("#modalText").val("");//modal창 데이터 초기화
					$("#modal").modal("hide");//modal close
				}
			}
		});//end okay
		
		//비밀번호 일치 검사
		$("input[data-name=pw]").keyup(function () {
			var password=$("#password").val();
			var pwCheck=$("#pwCheck").val();
			
			if (password.length==0) {//비번 미입력 상태에서 검사
				$("#pwMesg").text("변경할 비밀번호를 입력하세요.");
				$("#pwMesg").css("visibility","visible");
				$("#pwCheck").val("");
				$("#password").focus();
			} else {//비번 입력 상태, 일치 여부 검사
				if (password==pwCheck) {
					$("#pwMesg").text("비밀번호가 일치합니다.");
					$("#pwMesg").css("visibility","visible");
				} else {
					$("#pwMesg").text("비밀번호가 일치하지 않습니다.");
					$("#pwMesg").css("visibility","visible");
				}
			}
		});//end 비밀번호 일치
		
		//유효성 검사, 비밀번호 검사 후 form submit//변경 데이터 중복 검사는 modal에서 완료
		$("form").submit(function() {
			//console.log(checkValue());//(메서드 return 값 없으면 : undefined)//유효성 검사 err : false
			var pwMesg=$("#pwMesg").text();
			
			//비밀번호 변경 안 함 vs 변경
			if (pwMesg=="변경할 비밀번호를 입력하세요." || $("#password").val().length==0) {//비밀번호 데이터 없음
				//console.log("비밀번호 변경 안 함");
				if (!checkValue()) {//유효성 검사를 통과 못하면 false. !false==true
					console.log("비밀번호 외 유효성 검사 오류");
				} else {
					console.log("검사 완료 : submit");
				}
			} else {//비밀번호 변경
				var pwCheck=/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,20}$/;//영문, 숫자, 특문 포함 8-20자
				var pw=$("#pwCheck").val();
				
				if (pwMesg=="비밀번호가 일치하지 않습니다.") {//비밀번호 불일치
					console.log("비밀번호 확인 오류");
					$("#checkModalBtn").trigger("click");
					$("#checkModalMesg").text("비밀번호 일치 여부를 확인해주세요.");
					event.preventDefault();
				} else if (!pwCheck.test(pw)) {//비밀번호 유효성 검사
					console.log("비밀번호 유효성 검사 오류");
					$("#checkModalBtn").trigger("click");
					$("#checkModalMesg").text("알맞은 형식의 비밀번호를 입력하세요.");
					$("#password").val("");
					$("#pwCheck").val("");
					$("#checkModal").on("hidden.bs.modal", function () {
						$("#password").focus();
					});
					event.preventDefault();
				} else if (!checkValue()) {//비밀번호 외 유효성 검사
					console.log("비밀번호 외 유효성 검사 오류");
				} else {
					console.log("검사 완료 : submit");
				}
			}
		});//end submit
		
		//회원 탈퇴 클릭
		$("#delete").click(function() {
			$("#deleteBtn").trigger("click");
			$("#deleteMesg").text("계정을 삭제합니다. 비밀번호를 입력하세요.");
			
			$("#okayDelete").click(function() {
				$.ajax({
					type : "get",
					url : "${contextPath}/mypage/${login.id}/check",
					dataType : "text",
					data : {
						id : "${login.id}",
						password : $("#textArea").val()
					},
					success : function(responseData, status, xhr) {
						//console.log("성공====",responseData);//인증하면 1, 오류는 0
						if (responseData==1) {
							$("input[name=_method]").attr("value","delete");
							$("form").submit();//location.href로 페이지 이동하면 delete가 안 됨
						} else {
							//비밀번호 오류
							//현재 modal open 상태
							$("#deleteMesg").text("비밀번호가 틀렸습니다.");
							$("#textArea").val("");
							$("#textArea").focus();
						}
					},
					error : function(xhr, status, error) {
						console.log(error);
					}
				});//end ajax
			});//end okayDelete
		});//end delete
	});
	
	//유효성 검사 메서드(아이디, 비밀번호 제외)
	function checkValue() {
		var nameCheck=/^[가-힣]{2,8}$/;//한글만 2-8자
		var phoneCheck=/^010\d{4}\d{4}$/;///숫자만 11자//010으로 시작

		var memberName=$("#memberName").val();
		var phone=$("#phone").val();
		
		if (!nameCheck.test(memberName)) {
			console.log("이름 오류");
			$("#checkModalBtn").trigger("click");
			$("#checkModalMesg").text("알맞은 형식의 이름을 입력하세요.");
			$("#memberName").val("");
			$("#checkModal").on("hidden.bs.modal", function () {
				$("#memberName").focus();
			});
			event.preventDefault();
			return false;
		} else if (!phoneCheck.test(phone)) {
			console.log("연락처 오류");
			$("#checkModalBtn").trigger("click");
			$("#checkModalMesg").text("알맞은 형식의 연락처를 입력하세요.");
			$("#phone").val("");
			$("#checkModal").on("hidden.bs.modal", function () {
				$("#phone").focus();
			});
			event.preventDefault();
			return false;
		} else {
			console.log("유효성 검사 완료");
			return true;
		}
	}//end 유효성 검사
</script>