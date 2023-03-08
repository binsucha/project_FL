<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<style>
	.container {
		float: left;
		cursor: default;
		margin: 25;
	}
	.list {
		outline: solid 2px #eb6864;
		background-color: white;
		border-radius: 9px;
		height: auto;
		padding: 15;
	}
	.badge {
		cursor: pointer;
	}
	h5 {
		margin-bottom: 15;
	}
	img {
		border-radius: 9px;
		cursor: pointer;
	}
	.alert {
		text-align: center;
	}
	.scrap {
		cursor: pointer;
		border-radius: 9px;
	}
</style>
<div class="container col-md-9">
	<div class="col">
		<div class="list">
			<c:set var="reviewLength" value="${fn:length(reviewList)}"/>
			<div class="row">
				<div class="col">
					<h5 style="float: left;">작성한 후기  (
					<c:choose>
						<c:when test="${reviewLength < 5}">
							${reviewLength} /
						</c:when>
						<c:otherwise>
							5 /
						</c:otherwise>
					</c:choose>
					${reviewLength} )</h5>
				</div>
				<div class="col">
					<span class="badge bg-light" data-type="review" style="float: right;">전체 보기</span>
				</div>
			</div>
			<div class="col">
			<c:choose>
				<c:when test="${reviewLength < 1}">
					<div class="alert alert-dismissible alert-primary">
					  <a href="${contextPath}/reviewBoard" class="alert-link" style="text-decoration: none;">첫번째 후기 작성하기 🎉🎉</a>
					</div>
				</c:when>
				<c:otherwise>
					<table class="table table-hover">
					  <thead>
					    <tr class="table-primary">
					      <th scope="col" width="15%">가게 이름</th>
					      <th scope="col" width="15%">평점</th>
					      <th scope="col" width="60%">내용</th>
					      <th scope="col" width="10%">이미지</th>
					    </tr>
					  </thead>
					  <tbody>
					  	<c:forEach items="${reviewList}" var="review" end="4">
					    <tr style="cursor: pointer;" onClick="shop(${review.shop_no})">
					      <th scope="row">${review.shop_name}</th>
					      <td>
					      	<img src="${contextPath}/resources/image/rating${review.rate.intValue()}.png" height="20px" style="border-radius: 0;">
					      </td>
					      <td>
					      	${review.review_content}
					      </td>
					      <td>
						  	<c:if test="${not empty review.review_img_route}">
						    	<img src="${contextPath}/resources/review/${review.review_img_route}" height="50px">
						  	</c:if>
					      </td>
					    </tr>
					    </c:forEach>
					  </tbody>
					</table>
				</c:otherwise>
			</c:choose>
			</div>
		</div>
		<div class="list" style="height: auto; margin-top: 15;">
			<c:set var="scrapLength" value="${fn:length(scrapList)}"/>
			<div class="row">
				<div class="col">
					<h5 style="float: left;">스크랩한 가게 (
					<c:choose>
						<c:when test="${scrapLength < 6}">
							${scrapLength} /
						</c:when>
						<c:otherwise>
							6 /
						</c:otherwise>
					</c:choose>
					${scrapLength} )</h5>
				</div>
				<div class="col">
					<span class="badge bg-light" data-type="scrap" style="float: right;">전체 보기</span>
				</div>
			</div>
			<div class="col" style="text-align: center;">
				<c:forEach items="${scrapList}" var="scrap" end="5">
					<img class="scrap" src="${contextPath}/resources/shop/${scrap.shop_img_route}" width="150px"
						onClick="shop(${scrap.shop_no})">
				</c:forEach>
				<c:if test="${scrapLength < 6}">
					<c:forEach begin="1" end="${6 - scrapLength}">
						<img src="${contextPath}/resources/image/notScrap.png" width="150px" style="cursor: default;">
					</c:forEach>
				</c:if>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//전체 보기
		$(".badge.bg-light").click(function() {
			var type=$(this).attr("data-type");
			//console.log(type);
			location.href="${contextPath}/mypage/${login.id}/"+type;
		});//end 전체보기
		
		//프로필 수정
		
	});//end ready
	
	function shop(shopNo) {
		location.href="${contextPath}/shop/"+shopNo;
	}
</script>