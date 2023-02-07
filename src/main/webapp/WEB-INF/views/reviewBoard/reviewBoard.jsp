<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<c:if test="${not empty login && login.member_role==0}">
	<button type="button" class="btn btn-outline-dark" id="addShop">가게 등록</button>
</c:if>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#addShop").click(function() {
			location.href="${contextPath}/shop";
		});//end addShop
	});//end ready
</script>