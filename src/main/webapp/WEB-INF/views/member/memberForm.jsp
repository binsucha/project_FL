<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</style>
<div class="container col-md-12" style="margin-top: 20px;"><!-- form 폭 조정 4, 위 여백 20 -->
<form method="post" action="${contextPath}/join">
  <fieldset>
    <legend>회원가입</legend>
    <div class="container" tabindex="0">
    	<div class="item">
		    <div class="form-group">
		   	  <label for="id" class="form-label mt-4">아이디</label>
		      <input type="text" class="form-control" id="id" name="id" aria-describedby="idHelp" placeholder="영문, 숫자 포함 6-12자"
		      			style="display: inline-block;">
		      <button type="button" class="btn btn-outline-primary btn-sm" name="dataCheck" data-type="id">중복 확인</button>
		      <p class="form-text text-muted" id="idMesg" data-name="mesg">아이디 중복 확인 결과</p>
		    </div>
		    <div class="form-group">
		   	  <label for="password" class="form-label mt-4">비밀번호</label>
		      <input type="password" class="form-control" id="password" name="password" data-name="pw" placeholder="영문, 숫자, 특수문자 포함 8-20자">
		      <input type="password" class="form-control" id="pwCheck" data-name="pw" placeholder="비밀번호 확인">
		      <p class="form-text text-muted" id="pwMesg" data-name="mesg">확인할 비밀번호를 입력하세요.</p>
		    </div>
		    <div class="form-group">
		   	  <label for="phone" class="form-label mt-4">연락처</label>
		      <input type="tel" class="form-control" id="phone" name="phone" placeholder="010+숫자 8자리">
		      <button type="button" class="btn btn-outline-primary btn-sm" name="dataCheck" data-type="phone">중복 확인</button>
		      <p class="form-text text-muted" id="phoneMesg" data-name="mesg">연락처 중복 확인 결과</p>
		    </div>
		</div>
		<div class="item">
		    <div class="form-group">
		   	  <label for="memberName" class="form-label mt-4">이름</label>
		      <input type="text" class="form-control" id="memberName" name="member_name" aria-describedby="nameHelp" placeholder="한글 2-8자리"
		      			style="display: inline-block;">
		      <button type="button" class="btn btn-outline-primary btn-sm" name="dataCheck" data-type="memberName">중복 확인</button>
		      <p class="form-text text-muted" id="memberNameMesg" data-name="mesg">이름 중복 확인 결과</p>
		    </div>
			<div class="form-group">
		   	  <label for="email" class="form-label mt-4">이메일</label>
		      <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="email@address" style="width: 100%;">
		      <p id="emailMesg" class="form-text text-muted" data-name="mesg">이메일 중복 확인 결과</p>
		      <button type="button" class="btn btn-outline-primary btn-sm" name="dataCheck" data-type="email">중복 확인</button>
		    </div>
    	</div>
    </div>
    <button type="submit" class="btn btn-primary">가입하기</button>
  </fieldset>
</form>
</div>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		//데이터 중복 검사
		$("button[name=dataCheck]").click(function () {
			var type=$(this).attr("data-type");
			//console.log(type);//어떤 type인지 : 아이디, 이름, 연락처, 이메일
			//console.log($("#"+type+"").val()," : 데이터 중복 체크");//해당 데이터 type의 value 값 가져오기
			var data=$("#"+type+"").val();
 			$.ajax({
				type : "get",
				url : "join/data",
				dataType : "text",
				data : {
					type : type,
					data : data
				},
				success : function(responseData, status, xhr) {
					//console.log("success : ",responseData);
					$("#"+type+"Mesg").text(responseData);
					$("#"+type+"Mesg").css("visibility","visible");
					if (responseData=="내용을 입력해주세요.") {
						$("#"+type+"").focus();
					} else if (responseData=="이미 사용 중입니다.") {
						$("#"+type+"").val("");
						$("#"+type+"").focus();
					} else {
						//console.log("사용 가능");
					}
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
			});
		});//end 데이터 중복
		
		//중복 검사 후 input text 수정하면 Mesg 초기화
		$("input").keypress(function() {
			var type=$(this).attr("id");
			var text=$("#"+type+"Mesg").text();
			
			if (text=="사용 가능합니다.") {//중복 검사 후 사용 가능한 상태
				//console.log($(this));
				$("#"+type+"Mesg").text("결과");
				$("#"+type+"Mesg").css("visibility","hidden");
			}
		})
		
		//비밀번호 일치 검사
		$("input[data-name=pw]").keyup(function () {
			var password=$("#password").val();
			var pwCheck=$("#pwCheck").val();
			
			if (password.length==0) {//비번 미입력 상태에서 검사
				$("#pwMesg").text("확인할 비밀번호를 입력하세요.");
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
		
		//유효성 검사, 중복 검사 여부, 비밀번호 검사 후 form submit
		$("form").submit(function() {
			//console.log(checkValue());//(메서드 return 값 없으면 : undefined)//유효성 검사 err : false
			var mesg=$("p[data-name=mesg]").text();//중복 검사 결과 메세지
			var pwMesg=$("#pwMesg").text();
			
 			if (!checkValue()) {//유효성 검사를 통과 못하면 false. !false==true
				//console.log("유효성 검사 오류");
			} else if (mesg.includes("결과")) {//중복 검사를 안 한 경우//공백인 경우 : 유효성 err//중복인 경우 : 데이터 지워서 공백 처리됨
				//console.log("중복 검사 오류");
				$("#modalBtn").trigger("click");
				$("#modalMesg").text("중복 여부를 확인해주세요.");
				event.preventDefault();
			} else if (pwMesg=="비밀번호가 일치하지 않습니다." || pwMesg=="확인할 비밀번호를 입력하세요.") {//비밀번호 불일치 or 검사 안 함
				//console.log("비밀번호 검사 오류");
				$("#modalBtn").trigger("click");
				$("#modalMesg").text("비밀번호 일치 여부를 확인해주세요.");
				event.preventDefault();
			} else {
				//console.log("검사 완료 : submit");
			}
		});//end submit
	});
	
	//유효성 검사 메서드
	function checkValue() {
		var idCheck=/^(?=.*[A-Za-z])(?=.*\d)[a-zA-Z0-9]{6,12}$/;//영문, 숫자 포함 6-12자
		var pwCheck=/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,20}$/;//영문, 숫자, 특문 포함 8-20자
		var nameCheck=/^[가-힣]{2,8}$/;//한글만 2-8자
		var phoneCheck=/^010\d{4}\d{4}$/;///숫자만 11자//010으로 시작
		//type="email" submit 할 때 자동으로 유효성 검사
		
		var id=$("#id").val();
		var pw=$("#pwCheck").val();
		var memberName=$("#memberName").val();
		var phone=$("#phone").val();
		
		if (!idCheck.test(id)) {//유효성 검사를 통과 못하면 false. !false==true
			//console.log("아이디 오류");
			$("#modalBtn").trigger("click");
			$("#modalMesg").text("알맞은 형식의 ID를 입력하세요.");
			$("#id").val("");
			$("#modal").on("hidden.bs.modal", function () {//모달창 close 되면
				$("#id").focus();//id 입련란에 focus
			});
			event.preventDefault();
			return false;
		} else if (!pwCheck.test(pw)) {
			//console.log("비밀번호 오류");
			$("#modalBtn").trigger("click");
			$("#modalMesg").text("알맞은 형식의 비밀번호를 입력하세요.");
			$("#password").val("");
			$("#pwCheck").val("");
			$("#modal").on("hidden.bs.modal", function () {
				$("#password").focus();
			});
			event.preventDefault();
			return false;
		} else if (!nameCheck.test(memberName)) {
			//console.log("이름 오류");
			$("#modalBtn").trigger("click");
			$("#modalMesg").text("알맞은 형식의 이름을 입력하세요.");
			$("#memberName").val("");
			$("#modal").on("hidden.bs.modal", function () {
				$("#memberName").focus();
			});
			event.preventDefault();
			return false;
		} else if (!phoneCheck.test(phone)) {
			//console.log("연락처 오류");
			$("#modalBtn").trigger("click");
			$("#modalMesg").text("알맞은 형식의 연락처를 입력하세요.");
			$("#phone").val("");
			$("#modal").on("hidden.bs.modal", function () {
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