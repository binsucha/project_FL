<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 부트스트랩 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<!-- 테마 적용 -->
<link href="https://cdn.jsdelivr.net/npm/bootswatch@5.2.3/dist/journal/bootstrap.min.css" rel="stylesheet"></link>

<html>
	<head>
	<meta charset="UTF-8">
	<title>Foodie League</title>
	</head>
<body>

<jsp:include page="common/header.jsp"></jsp:include><br>
<jsp:include page="shop/category.jsp"></jsp:include><br>
<jsp:include page="shop/shopDetail.jsp"></jsp:include><br>
<jsp:include page="common/footer.jsp"></jsp:include><br>

<!-- modal -->
<div class="modal" id="modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Foodie League</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"></span>
        </button>
      </div>
      <div class="modal-body" style="text-align: center;">
        <span id="modalMesg"></span>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<button type="button" id="modalBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal" style="display: none;">modal</button>
<!-- end modal -->
<!-- modal -->
<div class="modal" id="editModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Foodie League</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"></span>
        </button>
      </div>
      <div class="modal-body" style="text-align: center;">
        <form id="updateForm" action="" method="post" enctype="multipart/form-data">
		<input type="hidden" name="updateRating" value="">
		<input type="hidden" name="oldImgFile" value="">
		<div id="editContent" class="accordion-collapse" aria-labelledby="heading">
		  <div class="accordion-body">
		    <div class="star-rating row">
			  <div class="update-stars col-md-5">
				<i class="fa fa-star fa-lg"></i>
				<i class="fa fa-star fa-lg"></i>
				<i class="fa fa-star fa-lg"></i>
				<i class="fa fa-star fa-lg"></i>
				<i class="fa fa-star fa-lg"></i>
			  </div>
			  <div class="update-text col-md-5 text-muted">
			    <h6>별점을 선택해주세요.</h6>
			  </div>
			</div>
			<textarea rows="5" name="updateContent" id="editTextarea"></textarea><br>
			<div class="row">
			  <div class="col-md-8">
				<label for="updateImgFile" class="form-label" style="float: left;">새로운 이미지 첨부</label>
				<input class="form-control" type="file" id="updateImgFile" name="updateImgFile" accept="image/*" multiple>
			  </div>
			  <div class="col-md-4">
			    <a class="card-link" id="deleteOldImg">기존 이미지 삭제</a>
			    <label for="deleteOldImg" class="form-label" style="float: right; display: none;"></label>
			  </div>
			</div>
		  </div>
		</div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="okayEdit">수정</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<button type="button" id="editBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModal" style="display: none;">modal</button>
<!-- end modal -->
<!-- modal -->
<div class="modal" id="deleteModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Foodie League</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"></span>
        </button>
      </div>
      <div class="modal-body" style="text-align: center;">
        <span id="deleteMesg"></span>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="okayDelete">삭제</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<button type="button" id="deleteBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#deleteModal" style="display: none;">modal</button>
<!-- end modal -->
</body>
</html>