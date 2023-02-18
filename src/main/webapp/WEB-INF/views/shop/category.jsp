<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<style>
	a {
		text-decoration: none;
	}
	.category {
		float: left;
		margin-top: 24;
	}
	.badge-size {
		font-size: 27;
		margin-left: 20;
	}
	.badge {
		color: #eb6864;
		cursor: pointer;
	}
</style>

<div class="category col-md-2">
	<c:forEach items="${categoryList}" var="list">
		<p class="badge-size">
			<span class="badge bg-light" data-no="${list.category_no}">
				${list.category_name}
			</span>
		</p>
	</c:forEach>
</div>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".badge").click(function() {
			var categoryNo=$(this).attr("data-no");
			$("#categoryNo").val(categoryNo);
			console.log($("#categoryNo").val());
			$("form").submit();
		});//end 카테고리 선택
		
	});//end ready
</script>