<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<style>
	legend {
		color: #eb6864;
		font-weight: bolder;
		margin-bottom: 20px;
	}
	label {
		font-weight: bolder;
	}
	button {
		margin-top: 20px;
		float: right;
	}
</style>

<div class="container col-md-4" style="margin-top: 20px;"><!-- form 폭 조정 4, 위 여백 20 -->
<form method="post" action="${contextPath}/login">
  <fieldset>
    <legend>로그인</legend>
	<div class="form-group">
	  <div class="form-floating mb-3">
	    <input type="text" class="form-control" id="id" name="id">
	    <label for="id">아이디</label>
	  </div>
	  <div class="form-floating">
	    <input type="password" class="form-control" id="password" name="password">
	    <label for="password">비밀번호</label>
	  </div>
	</div>
    <button type="submit" class="btn btn-primary">로그인</button>
  </fieldset>
</form>
</div>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#id").focus();
		
		$("form").submit(function() {
			var id=$("#id").val();
			var password=$("#password").val();
			
 			if (id.length==0) {//아이디 공백
				$("#modalBtn").trigger("click");
 				$("#modalMesg").text("아이디를 입력하세요.");
 				$("#modal").on("hidden.bs.modal", function () {
 					$("#id").focus();
 				});
 				event.preventDefault();
			} else if (password.length==0) {//비밀번호 공백
				$("#modalBtn").trigger("click");
 				$("#modalMesg").text("비밀번호를 입력하세요.");
 				$("#modal").on("hidden.bs.modal", function () {
 					$("#password").focus();
 				});
 				event.preventDefault();
			} else {//로그인
				console.log("submit=====");
			}
		});//end submit
	});
</script>