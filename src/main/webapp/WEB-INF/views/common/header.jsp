<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor03" aria-controls="navbarColor03" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarColor03">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="#">로그인</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">회원가입</a>
        </li>
      </ul>
    </div>
    <a class="navbar-brand" href="#">FOODIE League</a>
    <div class="collapse navbar-collapse" id="navbarColor03">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link active" href="#">후기</a>
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
        <input class="form-control me-sm-2" type="search" placeholder="검색">
        <button class="btn btn-secondary my-2 my-sm-0" type="submit">검색</button>
      </form>
    </div>
  </div>
</nav>