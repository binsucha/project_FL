<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor03" aria-controls="navbarColor03" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <c:choose>
    	<c:when test="${not empty login && login.member_role==1}">
	    	<div class="collapse navbar-collapse" id="navbarColor03">
		      <ul class="navbar-nav me-auto">
		        <li class="nav-item">
		          <a class="nav-link" href="${contextPath}/logout">로그아웃</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="${contextPath}/mypage/${login.id}">마이페이지</a>
		        </li>
		      </ul>
		    </div>
    	</c:when>
    	<c:when test="${not empty login && login.member_role==0}">
	    	<div class="collapse navbar-collapse" id="navbarColor03">
		      <ul class="navbar-nav me-auto">
		        <li class="nav-item">
		          <a class="nav-link" href="${contextPath}/logout">로그아웃</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="${contextPath}/admin">관리자 페이지</a>
		        </li>
		      </ul>
		    </div>
    	</c:when>
		<c:otherwise>
	    	<div class="collapse navbar-collapse" id="navbarColor03">
		      <ul class="navbar-nav me-auto">
		        <li class="nav-item">
		          <a class="nav-link" href="${contextPath}/login">로그인</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="${contextPath}/join">회원가입</a>
		        </li>
		      </ul>
		    </div>
		</c:otherwise>
    </c:choose>
    <a class="navbar-brand" href="${contextPath}/">FOODIE League</a>
    <div class="collapse navbar-collapse" id="navbarColor03">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link active" href="${contextPath}/reviewBoard">후기</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">공지사항</a>
          <div class="dropdown-menu">
            <a class="dropdown-item" href="#">소개</a>
            <a class="dropdown-item" href="#">공지 게시판</a>
          </div>
        </li>
      </ul>
      <form class="d-flex">
        <input class="form-control me-sm-2" type="search" placeholder="search">
        <button class="btn btn-secondary my-2 my-sm-0" type="submit">search</button>
      </form>
    </div>
  </div>
</nav>