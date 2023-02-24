<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach items="${commentList}" var="list">
	<div id="comment_${list.comment_no}" data-no="${list.comment_no}" style="margin-bottom: 5;">
		<span class="commentWriter">${list.member_name}</span>
		<!-- 후기 작성자와 댓글 작성자가 같으면 -->
		<c:if test="${reviewWriter eq list.id}">
			<span class="writer">(작성자)</span>
		</c:if>
		<br>
		<span class="commentContent" id="commentContent_${list.comment_no}">${list.comment_content}</span>
		<span class="commentCreated">${list.comment_created}</span>
		<c:if test="${list.id eq login.id}">
			<span onClick="showEditDiv(${list.comment_no})" class="commentEdit">수정</span>
			<span onClick="commentDelete(${list.comment_no})" class="commentDelete">삭제</span>
		</c:if>
		<div class="row" id="editDiv_${list.comment_no}" style="display: none;">
			<div class="col-md-10">
				<input class="form-control editInput" id="editInput_${list.comment_no}" value="${list.comment_content}"
					style="width: 100%; margin: 10 0 10 0;">
			</div>
			<div class="col-md-2">
				<p onClick="commentEdit(${list.comment_no})" class="submitEdit">수정</p>
			</div>
		</div>
	</div>
</c:forEach>
