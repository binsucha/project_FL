<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<style>
	.container {
		margin-top: 20px;
	}
	.row {
		justify-content: center;
	}
	legend {
		color: #eb6864;
		font-weight: bolder;
	}
	label {
		font-weight: bolder;
	}
	#shopName {
		display: inline;
		width: 60%;
	}
	#search {
		display: inline;
		float: right;
	}
	#shopContact {
		width: 60%;
	}
	textarea {
		height: 28%;
		resize: none;
	}
</style>

<form method="post" enctype="multipart/form-data">
<div class="container">
  <fieldset>
    <legend>가게 등록</legend>
    <div class="row" tabindex="0">
	    <div class="col-md-6" style="width: 30%;">
		    <div class="form-group">
		   	  <label for="shopName" class="form-label mt-4" style="display: block;">가게 이름</label>
		      <input type="text" class="form-control" id="shopName" name="shopName" aria-describedby="shopNameHelp" placeholder="지역+이름">
		      <button type="button" class="btn btn-outline-primary" id="search">가게 검색</button>
		    </div>
		    <div class="form-group">
		      <label for="category" class="form-label mt-4">카테고리</label>
		      <select class="form-select" id="category" name="category">
		      <option value="none" selected disabled hidden>카테고리 선택</option>
		      <c:forEach var="category" items="${categoryList}">
		        <option value="${category.category_no}">${category.category_name}</option>
		      </c:forEach>
		      </select>
		    </div>
		    <div class="form-group">
		   	  <label for="category2" class="form-label mt-4">카테고리2</label>
		      <select class="form-select" id="category2" name="category2">
		      <option value="none" selected disabled hidden>카테고리 선택</option>
		      <c:forEach var="category2" items="${category2List}">
		        <option value="${category2.category2_no}">${category2.category2_name}</option>
		      </c:forEach>
		      </select>
		    </div>
		    <div class="form-group">
		   	  <label for="shopLocation" class="form-label mt-4">가게 위치</label>
		      <input type="text" class="form-control" id="shopLocation" name="shopLocation">
		    </div>
		    <div class="form-group">
		   	  <label for="shopContact" class="form-label mt-4">연락처</label>
		      <input type="text" class="form-control" id="shopContact" name="shopContact" aria-describedby="shopContactHelp">
		    </div>
	    </div>
	    <div class="col-md-6" style="width: 30%;">
			<div class="form-group">
		   	  <label for="shopInfo" class="form-label mt-4">가게 정보</label>
		      <textarea class="form-control" id="shopInfo" name="shopInfo" aria-describedby="shopInfoHelp" placeholder="상세 정보를 추가하세요."></textarea>
		    </div>
		    <div class="form-group">
		      <label for="imgFile" class="form-label mt-4">이미지 등록</label>
		      <input class="form-control" type="file" id="imgFile" name="imgFile" accept="image/*" multiple>
		    </div>
		    <div class="form-group">
		      <label for="imgFile2" class="form-label mt-4">이미지 등록2</label>
		      <input class="form-control" type="file" id="imgFile2" name="imgFile" accept="image/*" multiple>
		    </div>
		    <div class="form-group">
		      <label for="imgFile3" class="form-label mt-4">이미지 등록3</label>
		      <input class="form-control" type="file" id="imgFile3" name="imgFile" accept="image/*" multiple>
		    </div>
	    </div>
	    <div class="col-md-12" style="margin-top: 55;">
		   	<button type="submit" class="btn btn-primary" style="float: right;">등록하기</button>
		</div>
    </div>
  </fieldset>
</div>
</form>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#search").click(function() {
			//가게 이름 유효성 검사 추가하기
			var shopName=$("#shopName").val();
			//console.log(shopName);
			$.ajax({
				type : "get",
				url : "${contextPath}/"+shopName,
				dataType: "JSON",
				contentType : "application/json; charset=UTF-8",
				//dataType : "text",
				success : function(data, status, xhr) {
					//console.log("success : ",data);
					var shopName=data.shopName;
					var shopHoursInfo=data.shopHoursInfo;
					//var status=data.status;
					var shopLocation=data.shopLocation;
					var shopContact=data.shopContact;
					//console.log(shopName, shopHoursInfo, status, shopLocation,shopContact);
					
					//데이터 출력
					$("#shopName").val(shopName);
					//$("#status").val(status);
					$("#shopLocation").val(shopLocation);
					$("#shopContact").val(shopContact);
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
			});//end ajax
			//카테고리와 상세 영업시간은 직접 입력
			//form submit--공백 확인
		});//end 가게 검색
		
		$("form").submit(function() {
			var result=dataCheck();//중복 확인 메서드 리턴 값 저장
			console.log("result :", result);
			if (result=="등록 가능한 가게입니다.") {
				//데이터 공백 검사
				if (dataCheck2()) {//공백 검사 err
					event.preventDefault();
				} else {//submit
					$(this).attr("action", "${contextPath}/shop/"+$("#shopName").val());
					//console.log($(this).attr("action"));
	 				console.log("폼 제출");
				}
			} else if (result=="이미 존재하는 가게 정보입니다." || result=="다른 가게의 연락처로 등록된 번호입니다.") {
				console.log("중복 데이터");
				$("#modalBtn").trigger("click");
				$("#modalMesg").text(result);
 				$("#modal").on("hidden.bs.modal", function () {
					$("#shopContact").focus();
				});
 				$("#shopContact").val("");
 				event.preventDefault();
			} else {
				console.log("데이터 공백");
				event.preventDefault();
			}
		});//end submit
	});//end ready
	
	//가게 이름과 연락처 중복 확인
	function dataCheck() {
		var shopName = $("#shopName").val().replace(/(\s*)/g,'');//전체 공백 제거
		var shopContact = $("#shopContact").val().replace(/(\s*)/g,'').replace(/\-/g,'');//전체 공백 제거, 특수문자 - 제거
		console.log("입력 된 데이터 :", shopName, shopContact);
		var result;
		
		if (shopName.length==0) {
			$("#modalBtn").trigger("click");
			$("#modalMesg").text("가게 이름을 입력해주세요.");
			$("#modal").on("hidden.bs.modal", function () {
				$("#shopName").focus();
			});
			result=false;
		} else if (shopContact.length==0) {
			$("#modalBtn").trigger("click");
			$("#modalMesg").text("가게 연락처를 입력해주세요.");
			$("#modal").on("hidden.bs.modal", function () {
				$("#shopContact").focus();
			});
			result=false;
		} else {//가게 이름, 연락처 입력 완료 후 중복 검사
			$.ajax({
				type : "get",
				url : "${contextPath}/shop/data",
				dataType : "text",
				async: false,
				data : {
					shopName : shopName,
					shopContact : shopContact
				},
				success : function(data, status, xhr) {
					//console.log("success :", data);
					if (data=="등록 가능한 가게입니다.") {
						result=data;
					} else {
						result=data;
					}
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
			});//end ajax
			//console.log("return :", result);
		}
		return result;
	}//end 중복 확인
	
	//이름, 연락처는 공백 안되게 설정 완료
	//카테고리, 카테고리2, 위치 공백 확인//가게 정보랑 이미지는 선택 사항
	function dataCheck2() {
		var category=$("#category").val();
		var category2=$("#category2").val();
		var shopLocation=$("#shopLocation").val();
		if (category==null) {//select option은 선택 안 하는 경우 null or value
			console.log("카테고리");
			$("#modalBtn").trigger("click");
			$("#modalMesg").text("카테고리를 선택해주세요.");
			$("#modal").on("hidden.bs.modal", function () {
				$("#category").focus();
			});
			return true;
		} else if (category2==null) {
			console.log("카테고리2");
			$("#modalBtn").trigger("click");
			$("#modalMesg").text("카테고리2를 선택해주세요.");
			$("#modal").on("hidden.bs.modal", function () {
				$("#category2").focus();
			});
			return true;
		} else if (shopLocation.length==0) {//input text는 공백 or value
			console.log("위치");
			$("#modalBtn").trigger("click");
			$("#modalMesg").text("가게 위치를 입력해주세요.");
			$("#modal").on("hidden.bs.modal", function () {
				$("#shopLocation").focus();
			});
			return true;
		} else {
			console.log("공백 확인 완료");
			return false;
		}
	}//end 공백 확인
</script>