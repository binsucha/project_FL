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
	<c:if test="${not empty mesg}">
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				$("#modalBtn").trigger("click");
				$("#modalMesg").text("${mesg}");
			});
		</script>
	</c:if>
	</head>
<body>

<jsp:include page="common/header.jsp"></jsp:include><br>
<jsp:include page="mypage/mypage.jsp"></jsp:include><br>
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
<div class="modal" id="mypageModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Foodie League</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"></span>
        </button>
      </div>
      <div class="modal-body" style="text-align: center;">
        <p id="mypageModalMesg"></p><br>
        <input type="password" id="textArea"></input>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="okay">확인</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<button type="button" id="mypageModalBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#mypageModal" style="display: none;">modal</button>
<!-- end modal -->
</body>
</html>