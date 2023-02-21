<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />

<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<style>
	.container {
		cursor: default;
	}
	#scrap {
		border-radius: 0;
		float: right;
		cursor: pointer;
	}
	#downImg {
		margin-top: -5;
		cursor: pointer;
	}
	.star-rating {
		text-align: right;
	}
	i {
		cursor: pointer;
	}
	.stars .fa.active {
	    color: #EB6864;
	    text-shadow: 0 0 5px #EB6864;
	}
	.text {
		margin: 4 0 0 0;
	}
	textarea {
		resize: none;
		width: 100%;
		margin: 10 0 10 0;
	}
	.card-link {
		font-weight: bold;
		float: right;
		cursor: pointer;
	}
	.form-label {
		font-size: 15;
	}
	.submitComment {
		color: #EB6864;
		float: right;
		cursor: pointer;
		margin-top: 13;
		font-weight: bold;
	}
</style>

<div class="container col-md-12">
	<div class="row">
		<div class="col-md-6">
			<div class="card mb-3" style="max-width: 40rem;">
			  <h3 class="card-header">${shop.shop_name}<img src="${contextPath}/resources/image/heart.png" height="30px" id="scrap"></h3>
			  <div class="card-body">
			    <h5 class="card-title">${shop.category_name}</h5>
			    <h6 class="card-subtitle text-muted">${shop.category2_name}</h6>
			  </div>
			  <div class="card-body">
			  	<div class="row">
				  <div class="col-md" style="text-align: center;">
				  	<c:forEach items="${imgList}" var="img" varStatus="status" end="0"><!-- 한 번만 출력 -->
				  	<c:if test="${status.index==0}"><!-- 첫 번째 이미지만 출력 -->
						<img src="${contextPath}/resources/upload/${img.shop_img_route}" width="360px" height="360px"
							class="first-img" data-img="${img.shop_img_route}" style="border-radius: 1.5em; margin-bottom: 5;">
				  	</c:if>
				  	</c:forEach>
				  </div>
				  <div class="col" style="text-align: center;">
				  	<c:set value="1" var="imgBegin"></c:set>
				  	<c:set value="${fn:length(imgList)}" var="imgLength"></c:set>
				  	<c:forEach items="${imgList}" var="img" varStatus="status" begin="${imgBegin}" end="4"><!-- 두 번째 이미지부터 4개 출력 -->
						<img src="${contextPath}/resources/upload/${img.shop_img_route}" width="90px" height="90px"
							style="border-radius: 0.5em; margin-bottom: 5;" class="the-others" data-img="${img.shop_img_route}">
				  	</c:forEach>
				  	<c:if test="${imgLength>5}">
				  		<br>
						<img src="${contextPath}/resources/image/down.png" height="20px" id="downImg">
					</c:if>
				  </div>
				 </div>
			  </div>
			  <ul class="list-group list-group-flush">
			    <li class="list-group-item">${shop.shop_location}</li>
			    <c:set value="${fn:length(shop.shop_contact)}" var="length"></c:set>
			    <li class="list-group-item">
			    	${fn:substring(shop.shop_contact,0,length-8)}-${fn:substring(shop.shop_contact,length-8,length-4)}-${fn:substring(shop.shop_contact,length-4,length)}
			    </li>
			  </ul>
			  <div class="card-footer text-muted">
			  	<c:choose>
			  		<c:when test="${empty shop.shop_info}">가게 정보 없음</c:when>
			  		<c:otherwise>${shop.shop_info}</c:otherwise>
			  	</c:choose>
			  </div>
			  <!-- 관리자 가게 수정 -->
			  <c:if test="${not empty login && login.member_role==0}">
			  <div class="card-body">
			    <div class="float-end">
			    	<button type="button" class="btn btn-primary btn-sm" id="change">수정하기</button>
			    </div>
			  </div>
			  </c:if>
			</div>
		</div>
		<div class="col-md-6">
			<div class="card border-primary mb-3">
			  <div class="card-body">
			    <h4 class="card-title" style="display: inline;">평점 : ${shop.average_rate}</h4>
			    <c:set value="${shop.average_rate}" var="average_rate"/>
				<c:set value="${average_rate+((average_rate%1>0.5)?(1-(average_rate%1))%1:-(average_rate%1))}" var="rating"/><!-- 평점 반올림 -->
				<img src="${contextPath}/resources/image/rating${rating.intValue()}.png" height="30px" style="float: right;">
			  </div>
			</div>
			<form action="${contextPath}/review/${shop.shop_no}" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="${login.id}">
			<input type="hidden" name="rating" value="">
				<div class="accordion" id="reviewForm">
				  <div class="accordion-item">
				    <h2 class="accordion-header" id="heading">
				      <button class="accordion-button collapsed" id="reviewFormBtn" type="button" data-bs-toggle="collapse" data-bs-target="#reviewContent" aria-expanded="false" aria-controls="reviewContent">
				        	<b>후기 남기기</b>
				      </button>
				    </h2>
				    <div id="reviewContent" class="accordion-collapse collapse" aria-labelledby="heading" data-bs-parent="#reviewForm">
				      <div class="accordion-body">
					    <div class="star-rating row">
					        <div class="stars col-md-5" data-rating="">
					            <i class="fa fa-star fa-lg"></i>
					            <i class="fa fa-star fa-lg"></i>
					            <i class="fa fa-star fa-lg"></i>
					            <i class="fa fa-star fa-lg"></i>
					            <i class="fa fa-star fa-lg"></i>
					        </div>
					        <div class="text col-md-5 text-muted">
					        	<h6>별점을 선택해주세요.</h6>
					        </div>
					    </div>
					    <textarea rows="5" name="content" placeholder="따뜻한 후기를 남겨주세요."></textarea><br>
						<div class="row">
						  <div class="col-md-8">
						      <label for="imgFile" class="form-label">이미지 첨부</label>
						      <input class="form-control" type="file" id="imgFile" name="imgFile" accept="image/*" multiple>
					      </div>
					      <div>
						      <a class="card-link" id="submitReview">등록</a>
					      </div>
					    </div>
				      </div>
				    </div>
				  </div>
				</div>
			</form>
			<div>
			<c:forEach items="${reviewList}" var="review">
				<div class="card border-primary mb-3" style="max-width: 40rem;">
				  <div class="card-header">
				  	<span style="font-size: 17;">${review.member_name}</span>
				  	<img src="${contextPath}/resources/image/rating${review.rate.intValue()}.png" height="20px" style="float: right;">
				  </div>
				  <div class="card-body">
				    <p class="card-text">${review.review_content}</p>
				    <c:if test="${not empty review.review_img_route}">
				  		<img src="${contextPath}/resources/review/${review.review_img_route}" height="90px"><br>
				    </c:if>
				    <span class="text-muted" style="float: right;">${review.review_created}</span>
				  </div>
				  <div class="card-footer text-muted" id="reviewComments_${review.review_no}">
				    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#comments_${review.review_no}" aria-expanded="false" aria-controls="comments_${review.review_no}">
						댓글
				    </button>
				    <div id="comments_${review.review_no}" class="accordion-collapse collapse" data-bs-parent="#reviewComments_${review.review_no}">
				      <div class="accordion-body">
				      	<div class="row">
					      	<div class="col-md-10">
					      		<input id="comment_${review.review_no}" name="comment" style="width: 100%; margin: 10 0 10 0;">
					      	</div>
					      	<div class="col-md-2">
					      		<p class="submitComment" data-review-no="${review.review_no}">등록</p>
					      	</div>
				      	</div>
				        <strong>Harry</strong>Styles<code>concert</code>in Korea
				      </div>
				    </div>
				  </div>
				</div>
			</c:forEach>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#change").click(function() {
			//location.href="${contextPath}/shop/${shop.shop_no}/admin";
		});//end 수정하기
		
		$(".the-others").mouseover(function() {
			var changedImg=$(this).attr("data-img");
			$(".first-img").attr("src","${contextPath}/resources/upload/"+changedImg);
		});//end 이미지 변경
		
		$(".the-others").mouseout(function() {
			var firstImg=$(".first-img").attr("data-img");
			$(".first-img").attr("src","${contextPath}/resources/upload/"+firstImg);
		});//end 이미지 변경
		
		$(".stars .fa").click(function() {
			$(this).addClass("active");//class 속성 추가//해당 class 선택 후 스타일 설정

			//클릭한 별을 기준으로 (.fa) 그 이전 별은 보이게 그 뒤에 별들은 안보이게
			$(this).prevAll().addClass("active");
			$(this).nextAll().removeClass("active");
			
			//순서를 찾는 메서드 index 0 1 2 3 4
			//텍스트내용을 출력 text, 태그+텍스트 html
			var num=$(this).index();
			var starRate=num+1;
			$(".stars.col-md-5").attr("data-rating", starRate);
			$("input[name=rating]").val(starRate);
			$(".text").text(starRate);
			
		    if(starRate==1) {
		        $(".text").html("<h6>별로예요 😢</h6>");
		    } else if(starRate==2) {
		        $(".text").html("<h6>아쉬워요 🙁</h6>");
		    } else if(starRate==3) {
		        $(".text").html("<h6>괜찮아요 🙂</h6>");
		    } else if(starRate==4) {
		        $(".text").html("<h6>만족해요 😊</h6>");
		    } else {
		        $(".text").html("<h6>아주 좋아요 😍</h6>");
		    }
		});//end 별점 선택
		
		//로그아웃 상태
		if ("${login.id}"=="") {
			//후기 아코디언 열리지 않도록
			$("#reviewFormBtn").attr("data-bs-toggle","");
			$("#reviewFormBtn").click(function() {
				$("#modalBtn").trigger("click");
				$("#modalMesg").text("로그인 후 이용하세요.");
			});
			
			//후기의 댓글창 readonly
			$("input[name=comment]").attr("readonly", "readonly");
			$("input[name=comment]").click(function() {
				$("#modalBtn").trigger("click");
				$("#modalMesg").text("로그인 후 이용하세요.");
			});
		}
		
		$("#submitReview").click(function() {
			//로그인 검사
			//공백 검사
			$("form").submit();
		});//end 리뷰 등록
		
		$(".submitComment").click(function() {
			var reviewNo=$(this).attr("data-review-no");
			var comment=$("#comment_"+reviewNo).val();
			if (comment.length==0) {
				console.log(reviewNo, "내용을 입력해주세요.");
			} else {
				console.log(reviewNo, comment);
			}
		});//end 댓글 등록
	});//end ready
</script>