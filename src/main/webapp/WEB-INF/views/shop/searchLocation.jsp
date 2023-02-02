<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<div class="container col-md-6" style="justify-content: center;">
	<table class="table table-hover">
	  <thead>
	    <tr class="table-primary">
	      <th scope="col"></th>
	      <th scope="col">가게명</th>
	      <th scope="col">카테고리</th>
	      <th scope="col">영업 상태</th>
	      <th scope="col">평점</th>
	    </tr>
	  </thead>
	<c:forEach var="s" items="${shopList}" varStatus="status">
	  <tbody>
	    <tr>
	      <th>${status.index+1}</th>
	      <th scope="row" style="cursor: pointer;">${s.shop_name}</th>
	      <td>${s.category}</td>
	      <td>${s.status}</td>
	      <td>${s.rate}</td>
	    </tr>
	  </tbody>
	  <input class="shop" style="display: none;" data-href="${s.shop_url}">
	</c:forEach>
	</table>
</div>
