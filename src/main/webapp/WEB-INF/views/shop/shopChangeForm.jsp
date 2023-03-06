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
		height: 14%;
		resize: none;
	}
	.img {
		cursor: pointer;
		position: absolute; z-index: 2;
		top: 5%; left: 5%;
	}
	figcaption {
		position: absolute;/* 이미지 위에 출력 */
		top: 0%; left: 0%;/* 위치 설정 */
		
		width: 121px; height: 121px;/* 크기 설정 */
		background-color: rgba(0,0,0,0.5);/* 배경 검정색으로 */
		border-radius: 9px;
		
		color: #fff; text-align: center;/* 글자 색상, 위치 설정 */
		line-height: 120px;/* 글자 상하 위치 설정 */
		font-weight: bold;
		font-size: 13px;
		
		opacity: 0;/* 처음에 보이지 않도록 */
	}
</style>

<form action="${contextPath}/shop/${shop.shop_no}/admin" method="post" enctype="multipart/form-data">
<div class="container">
  <fieldset>
    <legend>가게 수정</legend>
    <div class="row" tabindex="0">
	    <div class="col-md-6" style="width: 30%;">
		    <div class="form-group">
		   	  <label for="shopName" class="form-label mt-4" style="display: block;">가게 이름</label>
		      <input type="text" class="form-control" id="shopName" name="shopName" aria-describedby="shopNameHelp" placeholder="지역+이름"
		      	value="${shop.shop_name}" readonly="readonly">
		    </div>
		    <div class="form-group">
		      <label for="category" class="form-label mt-4">카테고리</label>
		      <select class="form-select" id="category" name="category">
		      <c:forEach var="category" items="${categoryList}">
		        <option value="${category.category_no}" <c:if test="${category.category_no==shop.category_no}">selected</c:if>>${category.category_name}</option>
		      </c:forEach>
		      </select>
		    </div>
		    <div class="form-group">
		   	  <label for="category2" class="form-label mt-4">카테고리2</label>
		      <select class="form-select" id="category2" name="category2">
		      <c:forEach var="category2" items="${category2List}">
		        <option value="${category2.category2_no}" <c:if test="${category2.category2_no==shop.category2_no}">selected</c:if>>${category2.category2_name}</option>
		      </c:forEach>
		      </select>
		    </div>
		    <div class="form-group">
		   	  <label for="shopLocation" class="form-label mt-4">가게 위치</label>
		      <input type="text" class="form-control" id="shopLocation" name="shopLocation" value="${shop.shop_location}">
		    </div>
		    <div class="form-group">
		   	  <label for="shopContact" class="form-label mt-4">연락처</label>
		      <input type="text" class="form-control" id="shopContact" name="shopContact" aria-describedby="shopContactHelp"
		      	value="${shop.shop_contact}">
		    </div>
	    </div>
	    <div class="col-md-6" style="width: 30%;">
			<div class="form-group">
		   	  <label for="shopInfo" class="form-label mt-4">가게 정보</label>
		      <textarea class="form-control" id="shopInfo" name="shopInfo" aria-describedby="shopInfoHelp">${shop.shop_info}</textarea>
		    </div>
		    <div class="form-group">
		    	<div class="col-md-12">
		    		<label for="OldImgs" class="form-label mt-4">등록된 이미지</label>
		    	</div>
			    <c:forEach items="${imgList}" var="img" varStatus="status">
			    <div class="col-md-4" style="margin-bottom: 5; position: relative; float: left;">
				    <input type="hidden" id="OldImg_${status.index+1}" name="oldImg" value="${img.shop_img_route}">
				    <figure>
			    		<img src="${contextPath}/resources/shop/${img.shop_img_route}" height="120px"
								id="OldImgs_${status.index+1}" style="border-radius: 0.5em; margin-bottom: 5; z-index: 3;">
			    		<figcaption id="caption_${status.index+1}">삭제되었습니다.</figcaption>
		    		</figure>
			    	<img class="img deleteImage" data-num="${status.index+1}" src="${contextPath}/resources/image/delete.png" height="28px">
			    	<img class="img reloadImage" data-num="${status.index+1}" src="${contextPath}/resources/image/reloading.png" height="28px" style="left: 30%;">
		    	</div>
			    </c:forEach>
		    </div>
		    <div class="form-group">
		      <label for="imgFile" class="form-label mt-4">새로운 이미지 추가</label>
		      <input class="form-control" type="file" id="imgFile" name="imgFile" accept="image/*" multiple>
		    </div>
	    </div>
    </div>
	<div class="row">
		<div class="col-md-12" style="text-align: right; margin-top: 50;">
			<button type="submit" class="btn btn-primary">수정하기</button>
			<button type="button" id="deleteShop" data-no="${shop.shop_no}" class="btn btn-primary">삭제하기</button>
		</div>
	</div>
  </fieldset>
</div>
</form>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//기존 이미지 삭제
		$(".deleteImage").click(function() {
			var num=$(this).attr("data-num");
			$("#OldImg_"+num).attr("name","deleteImg");
			$("#caption_"+num).css("opacity","1");
		});//end 기존 이미지 삭제
		
		//기존 이미지 삭제 취소
		$(".reloadImage").click(function() {
			var num=$(this).attr("data-num");
			$("#OldImg_"+num).attr("name","oldImg");
			$("#caption_"+num).css("opacity","0");
		});//enf 삭제 취소
		
		//가게 삭제
		$("#deleteShop").click(function() {
			var shopNo="${shop.shop_no}";
			console.log(shopNo);
			$("#deleteBtn").trigger("click");
			$("#deleteMesg").text("가게를 삭제하시겠습니까?");
			$("#okayDelete").click(function() {
				$.ajax({
					type : "delete",
					url : "${contextPath}//shop/"+shopNo,
					success : function(status, xhr) {
						console.log("success");
						//삭제 성공 후 후기 목록으로 페이지 이동
						location.href="${contextPath}/reviewBoard";
					},
					error : function(xhr, status, error) {
						console.log(error);
					}
				});//end ajax
			});//okayDelete
		});//end deleteShop
		
		$("form").submit(function() {
			var result=dataCheck();//중복 확인 메서드 리턴 값 저장
			console.log("result :", result);
			
			//연락처 중복 검사
			if (result=="다른 가게의 연락처로 등록된 번호입니다.") {
				showMesg(result);
 				$("#modal").on("hidden.bs.modal", function () {
					$("#shopContact").focus();
				});
 				$("#shopContact").val("");
 				event.preventDefault();
			} else {
				//데이터 공백 검사
				if (dataCheck2()) {//공백 검사 err
					event.preventDefault();
				} else {
					//submit
				}
			}
		});//end submit
	});//end ready

	function showMesg(mesg) {
		$("#modalBtn").trigger("click");
		$("#modalMesg").text(mesg);
	}
	
	//연락처만 중복 확인
	function dataCheck() {
		var shopName = $("#shopName").val().replace(/(\s*)/g,'');//전체 공백 제거
		var shopContact = $("#shopContact").val().replace(/(\s*)/g,'').replace(/\-/g,'');//전체 공백 제거, 특수문자 - 제거
		console.log("입력 된 데이터 :", shopName, shopContact);
		var result;
		
		if (shopContact.length==0) {
			showMesg("가게 연락처를 입력해주세요.");
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
					result=data;
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
	//카테고리, 카테고리2는 기본적으로 selected 상태여서 null인 경우가 없음
	//위치, 이미지 공백 확인//가게 정보는 선택 사항
	function dataCheck2() {
		var category=$("#category").val();
		var category2=$("#category2").val();
		var shopLocation=$("#shopLocation").val();
		var oldFile=$("input[name=oldImg]").val();
		var imgFile=$("#imgFile").val();
		
		if (shopLocation.length==0) {//input text는 공백 or value
			showMesg("가게 위치를 입력해주세요.");
			$("#modal").on("hidden.bs.modal", function () {
				$("#shopLocation").focus();
			});
			return true;
		} else if (oldFile==undefined && imgFile.length==0) {
			showMesg("1개 이상 이미지를 등록해주세요.");
			return true;
		} else {
			console.log("공백 확인 완료");
			return false;
		}
	}//end 공백 확인
</script>