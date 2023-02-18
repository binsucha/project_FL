<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

가게 상세 페이지<br>
<form method="get" action="${contextPath}/shop/${shop.shop_no}/admin">
<!-- 관리자 가게 등록 -->
<div class="col-md-2">
	<div class="float-end">
	<c:if test="${not empty login && login.member_role==0}">
		<button type="submit" class="btn btn-outline-primary btn-sm" id="change">수정하기</button>
	</c:if>
	</div>
</div>
${shop.shop_no}
</form>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
	});//end ready
</script>