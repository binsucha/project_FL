<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<style>
	.container {
		float: left;
	}
	img {
		border-radius: 1.5em;
		cursor: pointer;
	}
	.scrap {
		border-radius: 0;
		float: right;
		margin-right: 5;
	}
	.card {
		border-radius: 2em;
	}
	.item {
		margin-bottom: 15;
		width: 33%;
	}
	#paging {
		justify-content: center;
	}
	.card-title {
		cursor: default;
	}
	.page-item {
		cursor: pointer;
	}
</style>

<c:set value="${paging.list}" var="shopList"/>

<form action="reviewBoard">
<input type="hidden" id="page" name="page" value="1">
<input type="hidden" id="categoryNo" name="categoryNo" value="${category}">
<div class="container col-md-10">
	<div class="row">
		<!-- 검색창 -->
		<div class="col-md-8">
		    <div class="form-group" id="searching">
		      <select class="form-select" id="searchName" name="searchName" style="display: inline; width: 140px;">
		        <option selected disabled hidden="">검색</option>
		        <option value="shop_name" <c:if test="${searchName=='shop_name'}">selected</c:if>>가게 이름</option>
		        <option value="shop_location" <c:if test="${searchName=='shop_location'}">selected</c:if>>지역</option>
		      </select>
		      <input type="text" class="form-control" id="searchValue" name="searchValue" style="display: inline; width: 150px;">
		      <button type="button" class="btn btn-outline-primary" id="search" style="display: inline; margin-top: -5;">찾기</button>
		    </div>
	    </div>
		<!-- 관리자 가게 등록 -->
		<div class="col-md-2">
			<div class="float-end">
			<c:if test="${not empty login && login.member_role==0}">
				<button type="button" class="btn btn-outline-primary" id="addShop">가게 등록</button>
			</c:if>
			</div>
		</div>
	    <!-- 가게 정렬 -->
	    <div class="col-md-2">
		    <div class="float-end">
			    <div class="form-group" id="sorting">
			      <select class="form-select" id="sortBy" name="sortBy" style="display: inline; width: 140px; margin-right: 12;">
			        <option value="shop_created" selected>최신 등록</option>
			        <option value="average_rate" <c:if test="${sortBy=='average_rate'}">selected</c:if>>높은 평점</option>
			        <option value="shop_hits" <c:if test="${sortBy=='shop_hits'}">selected</c:if>>조회수</option>
			      </select>
			    </div>
		    </div>
	    </div>
	</div><br>
    <!-- 가게 목록 -->
	<div class="row">
	<c:forEach items="${shopList}" var="list" varStatus="status">
		<c:set value="${list.shop_name}" var="shop"></c:set>
		<%-- <c:if test="${list.shop_img_rank eq 1}"> --%>
		<div class="item col-md-4">
			<div class="card">
			  <div class="card-body">
			    <h4 class="card-title" style="margin-left: 5;">${fn:substring(shop,0,12)}<!-- 가게 이름 12자리까지만 출력 -->
			    	&nbsp;<img class="scrap" src="${contextPath}/resources/image/heart.png" width="30px" height="30px"></h4>
			    <h6 class="card-subtitle mb-2 text-muted" style="margin-left: 5;">${list.category_name} / ${list.category2_name}</h6>
			    <%-- <p class="card-text">${list.shop_info}</p> --%>
			    	<img src="${contextPath}/resources/image/left.png" name="prev" width="20px" height="20px">
			    	<a href="${contextPath}/shop/${list.shop_no}" class="card-link" style="text-decoration: none;">
			    		<img src="${contextPath}/resources/shop/${list.shop_img_route}" style="margin: 20 10 10 10"
			    			id="img_${list.shop_no}" data-no="${list.shop_no}" data-rank="${list.shop_img_rank}" width="250px" height="250px">
			    	</a>
			    	<img src="${contextPath}/resources/image/right.png" name="next" width="20px" height="20px">
			  </div>
			</div>
		</div>
		<%-- </c:if> --%>
	</c:forEach>
	</div>
	<!-- 페이징 -->
	<div class="row" id="paging">
		<div class="col-md-4">
		  <ul class="pagination">
		  	<!-- 이전 페이지 -->
			<c:choose>
				<c:when test="${paging.prev}">
					<li class="page-item">
						<a class="page-link" data-page="${paging.firstPage-1}">&laquo;</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" data-page="${paging.firstPage-1}">&laquo;</a>
					</li>
				</c:otherwise>
			</c:choose>
			<!-- 페이지 이동 -->
		  	<c:forEach var="page" begin="${paging.firstPage}" end="${paging.lastPage}">
		  	<%-- ${page} --%>
				 <c:choose>
				 	<c:when test="${page==paging.page}">
					 	<li class="page-item active">
					 		<a class="page-link" data-page="${page}"><b>${page}</b></a>
					 	</li>
				 	</c:when>
				 	<c:otherwise>
				 		<li class="page-item">
				 			<a class="page-link" data-page="${page}">${page}</a>
				 		</li>
				 	</c:otherwise>
				 </c:choose>
		  	</c:forEach>
		  	<!-- 이후 페이지 -->
			<c:choose>
				<c:when test="${paging.next}">
					<li class="page-item">
						<a class="page-link" data-page="${paging.lastPage+1}">&raquo;</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" data-page="${paging.lastPage+1}">&raquo;</a>
					</li>
				</c:otherwise>
			</c:choose>
		  </ul>
		  </div>
	</div>
</div>
</form>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#addShop").click(function() {
			location.href="${contextPath}/shop";
		});//end addShop

		//정렬 기준 변경
		$("#sortBy").change(function() {
			$("form").submit();
		});//end 정렬
		
		//검색 기능
		$("#search").click(function() {
			$("form").submit();
		});//end 정렬
		
		//페이징
		$(".page-link").click(function() {
			$("#page").val($(this).attr("data-page"));
			//console.log("page 데이터", $("#page").val());
			$("form").submit();
		});//end 페이징
		
		//다음 이미지
		$("img[name=next]").click(function() {
			//console.log($(this).prev("a").children("img"));//선택한 요소의 바로 이전에 위치한 형제 요소의 자식 요소를 모두 선택
			var imgShopNo=$(this).prev("a").children("img").attr("data-no");
			var imgRank=parseInt($(this).prev("a").children("img").attr("data-rank"));
			console.log("가게 번호 :", imgShopNo, "이미지 순서 :", imgRank);
			$.ajax({
				type : "get",
				url : "reviewBoard/img",
				dataType: "JSON",
				contentType : "application/json; charset=UTF-8",
				data : {
					imgShopNo : imgShopNo
				},
				success : function(responseData, status, xhr) {
					//console.log("success : ",responseData);//==ShopImgDTO 배열
					var lastIdx=responseData.length-1;
					//console.log("마지막 idx :", lastIdx);
					
					$.each(responseData, function (index, item) {
						if (imgRank==item.shop_img_rank) {//현재 이미지 순서면
							if (index != lastIdx) {//마지막 데이터가 아니면
								//console.log("현재 idx =====", index, " :", responseData[index]);
								index+=1;//다음 idx
								console.log("현재 이미지 rank :", imgRank, "다음 idx :", index);
								var nextRank=responseData[index].shop_img_rank;
								var nextImg=responseData[index].shop_img_route;
								console.log("다음 이미지 rank :", nextRank, " route :", nextImg);
								
								//이미지 데이터 변경
								$("#img_"+imgShopNo).attr("src","${contextPath}/resources/shop/"+nextImg);
								$("#img_"+imgShopNo).attr("data-rank",nextRank);
							} else {//마지막 데이터
								console.log("마지막");
							}
						}
					})//end each
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
			});//end ajax
		});//end next img
		
		//이전 이미지
		$("img[name=prev]").click(function() {
			//console.log($(this).next("a").children("img"));//선택한 요소의 바로 다음에 위치한 형제 요소의 자식 요소를 모두 선택
			var imgShopNo=$(this).next("a").children("img").attr("data-no");
			var imgRank=parseInt($(this).next("a").children("img").attr("data-rank"));
			console.log("가게 번호 :", imgShopNo, "이미지 순서 :", imgRank);
			$.ajax({
				type : "get",
				url : "reviewBoard/img",
				dataType: "JSON",
				contentType : "application/json; charset=UTF-8",
				data : {
					imgShopNo : imgShopNo
				},
				success : function(responseData, status, xhr) {
					//console.log("success : ",responseData);//==ShopImgDTO 배열
					
					$.each(responseData, function (index, item) {
						if (imgRank==item.shop_img_rank) {//현재 이미지 순서면
							if (index != 0) {//첫번째 데이터가 아니면
								//console.log("현재 idx =====", index, " :", responseData[index]);
								index-=1;//이전 idx
								console.log("현재 이미지 rank :", imgRank, "이전 idx :", index);
								var prevRank=responseData[index].shop_img_rank;
								var prevImg=responseData[index].shop_img_route;
								console.log("이전 이미지 rank :", prevRank, " route :", prevImg);
								
								//이미지 데이터 변경
								$("#img_"+imgShopNo).attr("src","${contextPath}/resources/shop/"+prevImg);
								$("#img_"+imgShopNo).attr("data-rank",prevRank);
							} else {//마지막 데이터
								console.log("첫번째");
							}
						}
					})//end each
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
			});//end ajax
		});//end prev img
	});//end ready
</script>
