<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />

<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<style>
	.container, .modal {
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
	.update-stars .fa.active {
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
	.submitComment, .submitEdit {
		color: #EB6864;
		float: right;
		cursor: pointer;
		margin-top: 18;
		font-weight: bold;
		font-size: 14;
	}
	.commentWriter, .writer {
		font-size: 14;
		font-weight: bold;
	}
	.commentContent {
		font-size: 14;
		color: #EB6864;
	}
	.commentCreated {
		font-size: 13;
		float: right;
	}
	.commentEdit, .commentDelete{
		font-size: 13;
		cursor: pointer;
	}
	.commentInput, .editInput {
		font-size: 14;
	}
	.reviewEdit, .reviewDelete {
		color: #EB6864;
		font-size: 14;
		font-weight: bold;
		cursor: pointer;
	}
	#deleteOldImg {
		font-size: 15;
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
						<img src="${contextPath}/resources/shop/${img.shop_img_route}" width="360px" height="360px"
							class="first-img" data-img="${img.shop_img_route}" style="border-radius: 1.5em; margin-bottom: 5;">
				  	</c:if>
				  	</c:forEach>
				  </div>
				  <div class="col" style="text-align: center;">
				  	<c:set value="1" var="imgBegin"></c:set>
				  	<c:set value="${fn:length(imgList)}" var="imgLength"></c:set>
				  	<c:forEach items="${imgList}" var="img" varStatus="status" begin="${imgBegin}" end="4"><!-- 두 번째 이미지부터 4개 출력 -->
						<img src="${contextPath}/resources/shop/${img.shop_img_route}" width="90px" height="90px"
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
			    <h4 class="card-title shopRating" style="display: inline;">평점 : ${shop.average_rate}</h4>
			    <c:set value="${shop.average_rate}" var="average_rate"/>
				<c:set value="${average_rate+((average_rate%1>0.5)?(1-(average_rate%1))%1:-(average_rate%1))}" var="rating"/><!-- 평점 반올림 -->
				<img class="ratingImg" src="${contextPath}/resources/image/rating${rating.intValue()}.png" height="30px" style="float: right;">
<%-- 			<span class="rating" style="position: absolute; display: inline-block; overflow: hidden;">
					<img src="${contextPath}/resources/image/rating0.png" height="30px">
				</span>
				<span style="position: absolute; display: inline-block; overflow: hidden;">
					<img src="${contextPath}/resources/image/rating5.png" height="30px">
				</span> --%>
			  </div>
			</div>
			<form id="insertForm" action="${contextPath}/review/${shop.shop_no}" method="post" enctype="multipart/form-data">
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
					        <div class="stars col-md-5">
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
				<div class="card border-primary mb-3 reviewList_${review.review_no}" style="max-width: 40rem;">
				  <div class="card-header">
				  	<span style="font-size: 17;">${review.member_name}</span>
				  	<c:if test="${login.id eq review.id}">
				  		<span class="reviewEdit" onClick="reviewEdit(${review.review_no}, ${review.rate}, '${review.review_content}', '${review.review_img_route}')">수정</span>
				  		<span class="reviewDelete" onClick="reviewDelete(${review.review_no})">삭제</span>
				  	</c:if>
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
				    <button class="accordion-button collapsed" type="button" name="commentsBtn" data-review-no="${review.review_no}" data-bs-toggle="collapse" data-bs-target="#comments_${review.review_no}" aria-expanded="false" aria-controls="comments_${review.review_no}">
						댓글
				    </button>
				    <div id="comments_${review.review_no}" class="accordion-collapse collapse" data-bs-parent="#reviewComments_${review.review_no}">
				      <div class="accordion-body">
				      	<div class="row">
					      	<div class="col-md-10">
					      		<input id="commentInput_${review.review_no}" class="form-control commentInput" name="comment" style="width: 100%; margin: 10 0 10 0;">
					      	</div>
					      	<div class="col-md-2">
					      		<p class="submitComment" data-review-no="${review.review_no}" data-comment-no="">입력</p>
					      	</div>
				      	</div>
				      	<!-- 후기의 댓글 append -->
				      	<div class="commentList_${review.review_no}" data-id="${review.id}">
				      		
				      	</div>
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
		//(관리자) 수정하기 버튼
		$("#change").click(function() {
			location.href="${contextPath}/shop/${shop.shop_no}/admin";
		});//end 수정하기 버튼
		
		//이미지 변경
		$(".the-others").mouseover(function() {
			var changedImg=$(this).attr("data-img");
			$(".first-img").attr("src","${contextPath}/resources/shop/"+changedImg);
		});//end 이미지 변경
		
		$(".the-others").mouseout(function() {
			var firstImg=$(".first-img").attr("data-img");
			$(".first-img").attr("src","${contextPath}/resources/shop/"+firstImg);
		});//end 이미지 변경
		
		//별점 선택
		$(".stars .fa").click(function() {
			$(this).addClass("active");//class 속성 추가//해당 class 선택 후 스타일 설정

			//클릭한 별을 기준으로 (.fa) 그 이전 별은 보이게 그 뒤에 별들은 안보이게
			$(this).prevAll().addClass("active");
			$(this).nextAll().removeClass("active");
			
			//순서를 찾는 메서드 index 0 1 2 3 4
			//텍스트내용을 출력 text, 태그+텍스트 html
			var num=$(this).index();
			var starRate=num+1;
			$("input[name=rating]").val(starRate);
			
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
			var mesg="로그인 후 이용하세요.";
			
			//후기 아코디언 열리지 않도록
			$("#reviewFormBtn").attr("data-bs-toggle","");
			$("#reviewFormBtn").click(function() {
				showMesg(mesg);
			});
			
			//후기의 댓글창 readonly
			$("input[name=comment]").attr("readonly", "readonly");
			$("input[name=comment]").click(function() {
				showMesg(mesg);
			});
		}
		
		//후기 등록
		$("#submitReview").click(function() {
			//로그인 검사--로그인 상태면 아코디언 collapse
			//공백 검사
			var starRate=$("input[name=rating]").val();
			var content=$("textarea[name=content]").val();
			console.log(starRate, content);
			
			if (starRate=="") {
				showMesg("별점을 선택해주세요.");
			} else if (content=="") {
				showMesg("내용을 입력해주세요.");
			} else {
				console.log("공백 검사 완료");
				//$("form").submit();//////////
				$("#insertForm").submit();
			}
		});//end 후기 등록
		
		//후기의 댓글 누르면 목록 가져와서 출력
		$("button[name=commentsBtn]").click(function() {
			var reviewNo=$(this).attr("data-review-no");
			
			//댓글 아코디언 닫을 경우 출력됐던 데이터 삭제
			//console.log("아코디언 높이 :", $("#comments_"+reviewNo).css("height"));
			if ($("#comments_"+reviewNo).css("height")!="0px") {//아코디언 닫을 때
				//console.log("닫음");
				$(".commentList_"+reviewNo).empty();//div 자식 empty
			} else {//아코디언 열 때
				//댓글 남기는 후기의 작성자
				var reviewWriter=$(".commentList_"+reviewNo).attr("data-id");
				//console.log("후기 작성자 :", reviewWriter);
				showComments(reviewNo, reviewWriter);
			}
		});//end 댓글 목록 출력
		
		//댓글 입력 후 출력
		$(".submitComment").click(function() {
			var reviewNo=$(this).attr("data-review-no");
			var commentNo=$(this).attr("data-comment-no");
			//console.log(reviewNo,"의 마지막 댓글 번호 :", commentNo);
			
			//댓글 남기는 후기의 작성자
			var reviewWriter=$(".commentList_"+reviewNo).attr("data-id");
			//console.log("후기 작성자 :", reviewWriter);
			
			var comment=$("#commentInput_"+reviewNo).val();
			
			if (comment.length==0) {
				showMesg("내용을 입력해주세요.");
			} else {
				//console.log(reviewNo, comment);
				$.ajax({
					type : "post",
					url : "${contextPath}/review/"+reviewNo+"/comment",
					data : {
						id : "${login.id}",
						reviewNo : reviewNo,
						comment : comment
					},
					dataType : "text",
					success : function(data, status, xhr) {
						$("#commentInput_"+reviewNo).val("");
						showComments(reviewNo, reviewWriter);
					},
					error : function(xhr, status, error) {
						console.log(error);
					}
				});//end ajax
			}
		});//end 댓글 입력
		
		//modal close 후 이벤트 중복 off
		$("#deleteModal").on("hidden.bs.modal", function () {
			$("#okayDelete").off("click").on("click", function() {
				console.log("중복 클릭 off");
			});//end fn
		});
		$("#editModal").on("hidden.bs.modal", function () {
			$("#okayEdit").off("click").on("click", function() {
				console.log("중복 클릭 off");
			});//end fn
		});
		
		//수정 modal 닫으면 입력 값 reset
		$("#editModal").on("hidden.bs.modal", function () {
			console.log("모달 close");
			//설정 데이터 삭제
			//별점 데이터 삭제//불필요함---공백인 경우가 없어서 항상 열 때마다 업데이트 됨
			//$("input[name=updateRating]").val("");
			//별점 표시 삭제
			$(".update-stars .fa").removeClass("active");//class 속성 제거
			//후기 데이터 삭제//불필요함---공백인 경우가 없어서 항상 열 때마다 업데이트 됨
			//이미지 데이터 삭제
			$("input[name=oldImgFile]").val("");
			//바뀐 데이터 삭제
			//선택한 이미지 삭제//직접 value 설정은 불가능하지만 초기화는 가능한 건가? 오류 없음
			$("#updateImgFile").val("");
			//기존 이미지 삭제 메세지 숨김
			$("#deleteOldImg").next("label").css("display","none");
		});
		
		//기존 이미지 데이터 삭제
		$("#deleteOldImg").click(function() {
			var oldImg=$("input[name=oldImgFile]").val();
			if (oldImg.length==0) {//oldImg 없음
				$(this).next("label").text("이미지가 없습니다.");
				$(this).next("label").css("display","");
			} else {
				$("input[name=oldImgFile]").val("");
				$(this).next("label").text("삭제되었습니다.");
				$(this).next("label").css("display","");
			}
		});//end
	});//end ready
	
	function showMesg(mesg) {
		$("#modalBtn").trigger("click");
		$("#modalMesg").text(mesg);
	}
	
	//후기 삭제
	function reviewDelete(reviewNo) {
		$("#deleteBtn").trigger("click");
		$("#deleteMesg").text("후기를 삭제하시겠습니까?");
		$("#okayDelete").click(function() {
			console.log(reviewNo, "후기 삭제");
			$.ajax({
				type : "delete",
				url : "${contextPath}/review/${shop.shop_no}/"+reviewNo,
				dataType: "text",
				success : function(data, status, xhr) {
					console.log("DELETE success");
					var update="평점 : "+data;
					var num=Math.round(data);
					console.log(update, num);
					
					//update 평점 출력
					$(".card-title.shopRating").text(update);
					
					//update 평점 이미지 변경/////이후에 평점 % 표시할 때 같이 수정
					$(".ratingImg").attr("src","${contextPath}/resources/image/rating"+num+".png");
					
					//후기 div 제거
					$(".reviewList_"+reviewNo).remove();
					
					//modal close
					$("#deleteModal").modal("hide");
					showMesg("후기가 삭제되었습니다.");
					
					//modal 닫힌 후 페이지 새로고침
/*					$("#modal").on("hidden.bs.modal", function () {
						//새로고침
						location.reload();
					});	*/
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
			});//end ajax
		});//end delete review
	}
	
	//후기 수정
	function reviewEdit(reviewNo, rating, content, imgRoute) {
		console.log(reviewNo, "후기 수정", rating, content, imgRoute);
		$("#editBtn").trigger("click");
		var idx=rating-1;
		console.log("별 index 번호 :", idx);
		
		//기존 데이터 출력
		//별점 데이터
		$("input[name=updateRating]").val(rating);
		//별점 표시
		//console.log($(".update-stars .fa").eq(idx));//idx번째 요소 선택
		$(".update-stars .fa").eq(idx).addClass("active");//class 속성 추가//해당 class 선택 후 스타일 설정
		$(".update-stars .fa").eq(idx).prevAll().addClass("active");//class 속성 추가//해당 class 선택 후 스타일 설정
		//수정 modal에 기존 후기 데이터 출력
		$("#editTextarea").val(content);//text(content)로 하면 제대로 출력이 안되고 마지막 입력한 데이터가 남아있는 문제,,,
		//이미지 데이터
		//$("input[name=updateImgFile]").val(imgRoute);//type file에 직접 value 설정이 불가능함
		$("input[name=oldImgFile]").val(imgRoute);//hidden value로 넘길 기존 이미지 데이터
		
		//별점 선택
		$(".update-stars .fa").click(function() {
			$(this).addClass("active");//class 속성 추가//해당 class 선택 후 스타일 설정

			//클릭한 별을 기준으로 (.fa) 그 이전 별은 보이게 그 뒤에 별들은 안보이게
			$(this).prevAll().addClass("active");
			$(this).nextAll().removeClass("active");
			
			//순서를 찾는 메서드 index 0 1 2 3 4
			//텍스트내용을 출력 text, 태그+텍스트 html
			var num=$(this).index();
			console.log("선택한 update 별점 :", num);
			var starRate=num+1;
			$("input[name=updateRating]").val(starRate);
			
		    if(starRate==1) {
		        $(".update-text").html("<h6>별로예요 😢</h6>");
		    } else if(starRate==2) {
		        $(".update-text").html("<h6>아쉬워요 🙁</h6>");
		    } else if(starRate==3) {
		        $(".update-text").html("<h6>괜찮아요 🙂</h6>");
		    } else if(starRate==4) {
		        $(".update-text").html("<h6>만족해요 😊</h6>");
		    } else {
		        $(".update-text").html("<h6>아주 좋아요 😍</h6>");
		    }
		});//end 별점 선택
		
		//후기 내용 공백 검사 후 form submit
		$("#okayEdit").click(function() {
			var updateContent=$("#editTextarea").val();
			console.log(updateContent, updateContent.length);
			if (updateContent.length==0) {//textArea의 text가 아닌 val로 확인
				showMesg("내용을 입력해주세요.");
			} else {
				console.log("form submit=====");
				$("#updateForm").attr("action","${contextPath}/review/${shop.shop_no}/"+reviewNo);
				$("#updateForm").submit();
			}
		});//end submit
	}
	
	//댓글 목록 출력
	function showComments(reviewNo, reviewWriter) {
		console.log("review no :", reviewNo);
		
		//마지막 댓글 번호
		var last=$(".commentList_"+reviewNo).children(":last");
		var lastNo=last.attr("data-no");
		//console.log("마지막 댓글 번호 :", lastNo);//undefined
		
		//댓글 append
		$.ajax({
			type : "get",
			url : "${contextPath}/review/"+reviewNo+"/comment",
			data : {
				reviewNo : reviewNo,
				lastNo : lastNo,
				reviewWriter : reviewWriter
			},
			dataType: "text",//success data List=>jsp return
			async: false,
			success : function(data, status, xhr) {
				//console.log(data);//comment.jsp return
				$(".commentList_"+reviewNo).append(data);
			},
			error : function(xhr, status, error) {
				console.log(error);
			}
		});//end ajax
		
		//마지막 댓글 번호 업데이트
		var last=$(".commentList_"+reviewNo).children(":last");
		var lastNo=last.attr("data-no");
		console.log("마지막 댓글 번호 업데이트 :", lastNo);
		$(".submitComment").attr("data-comment-no", lastNo);
	}
	
	//댓글 수정창 출력-닫힘
	function showEditDiv(comment_no) {
		if ($("#editDiv_"+comment_no).css("display")=="none") {//수정창 닫힘 상태
			//console.log(comment_no, "수정창 닫힘 상태");
			$("#editDiv_"+comment_no).css("display","");//출력
			var content=$("#editInput_"+comment_no).val();
			$("#editInput_"+comment_no).focus().val("").val(content);//텍스트 마지막에 focus
		} else {
			//console.log(comment_no, "수정창 출력 상태");
			$("#editDiv_"+comment_no).css("display","none");//닫음
		}
	}
	
	//댓글 수정
	function commentEdit(comment_no) {
		var editedComment=$("#editInput_"+comment_no).val();
		//console.log(comment_no, "수정 :", editedComment);
		var jsondata = {
				"commentNo" : comment_no,
				"editedComment" : editedComment
		};
		$.ajax({
			type : "put",//put일 때 컨트롤러에서 데이터를 못 받음
			url : "${contextPath}/review/comment/"+comment_no,
			data : JSON.stringify(jsondata),
			contentType:'application/json;charset=UTF-8',
			dataType: "text",
			//async: false,
			success : function(data, status, xhr) {
				console.log("PUT success");
				$("#editDiv_"+comment_no).css("display","none");//닫음
				$("#commentContent_"+comment_no).text(editedComment);//변경 내용 출력
			},
			error : function(xhr, status, error) {
				console.log(error);
			}
		});//end ajax
	}
	
	//댓글 삭제
	function commentDelete(comment_no) {
		$("#deleteBtn").trigger("click");
		$("#deleteMesg").text("댓글을 삭제하시겠습니까?");
		$("#okayDelete").click(function() {
			//console.log(comment_no, "댓글 삭제");
			$.ajax({
				type : "delete",
				url : "${contextPath}/review/comment/"+comment_no,
				//data : {},
				dataType: "text",
				//async: false,
				success : function(data, status, xhr) {
					console.log("DELETE success");
					//댓글 div 제거
					$("#comment_"+comment_no).remove();
					//modal close
					$("#deleteModal").modal("hide");
					showMesg("댓글이 삭제되었습니다.");
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
			});//end ajax
		});//end delete comment
	}
</script>