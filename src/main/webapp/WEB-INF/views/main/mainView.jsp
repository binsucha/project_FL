<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<!-- 지역 맛집 검색창 -->
<div class="container col-md-4">
    <div class="input-group mb-3">
      <input type="text" class="form-control" placeholder="지역 검색" id="locationSearch" aria-label="Recipient's username" aria-describedby="search">
      <button class="btn btn-primary" type="button" id=search>검색</button>
    </div>
</div>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#search").click(function() {
			var searchWord=$("#locationSearch").val();
			if (searchWord.length==0) {
				console.log("검색어를 입력하세요.");
			} else {
				location.href="${contextPath}/crawl/"+searchWord;
			}
		});//end search
		
	});//end ready
</script>