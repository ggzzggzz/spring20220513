<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>

<script>
	$(document).ready(function() {
		$("#edit-button").click(function() {
			$("#input1").removeAttr("readonly");
			$("#textarea1").removeAttr("readonly");
			$("#modify-submit1").removeClass("d-none");
			$("#remove-submit1").removeClass("d-none");
		});
		$("#remove-submit1").click(function(e) {
			e.preventDefault();
			
			if(confirm("삭제하시겠습니까?")) {
				let form1 = $("#form1");
				let actionAttr = "${appRoot}/board/remove";
				form1.attr("action",actionAttr);
				
				form1.submit();
			}
		});
		
		$(".reply-edit-toggle-button").click(function() {
			const replyId = $(this).attr("data-reply-id");
			const displayDivId = "#replyDisplayContainer" + replyId;
			const editFormId = "#replyEditFormContainer" + replyId;
			
			$(displayDivId).hide();
			$(editFormId).show();
		});
		
		$(".reply-delete-button").click(function(){
			const replyId = $(this).attr("data-reply-id");
			
			if(confirm("댓글을 삭제하시겠습니까?")) {
				$("#replyDeleteInput1").val(replyId);
				$("#replyDeleteForm1").submit();
			}
		});
	});
</script>

<title>Insert title here</title>
</head>
<body>
	<my:navBar></my:navBar>
	<div class="container">
		<div class="row">
			<div class="col">
				<c:if test="${not empty param.writeSuccess }">
					<c:if test="${param.writeSuccess }">
						<script>
							alert("게시물이 잘 등록되었습니다.")
						</script>
					</c:if>
					<c:if test="${not param.writeSuccess }">
						<script>
							alert("게시물을 등록하는데에 문제가 발생하였습니다.")
						</script>
					</c:if>
				</c:if>
				<c:if test="${not empty param.modifySuccess }">
					<c:if test="${param.modifySuccess }">
						<div class="alert alert-primary">게시물을 수정하였습니다.</div>
					</c:if>
					<c:if test="${not param.modifySuccess }">
						<div class="alert alert-danger">게시물을 수정하는데에 문제가 발생하였습니다.</div>
					</c:if>
				</c:if>
				<h1>글 본문
					<button id="edit-button" class="btn btn-secondary">
						<i class="fa-solid fa-pen-to-square"></i>
					</button>
				</h1>
				
				<form id="form1" action="${appRoot }/board/modify" method="post">
					<input type="hidden" name="id" value="${board.id }" />
					<div>
						<label for="input1" class="form-label">제목</label>
						<input type="text" class="form-control" id="input1" name="title" 
						value="${board.title }" required readonly />
					</div>
					
					<div>
						<label for="textarea1" class="form-label">본문</label>
						<textarea name="body" id="textarea1" cols="30" rows="10" class="form-control" readonly>${board.body }</textarea>
					</div>
					
					<div>
						<label for="input2" class="form-label">작성일시</label>
						<input class="form-control" type="datetime-local" value="${board.inserted }" readonly />
					</div>
					
					<button id="modify-submit1" class="btn btn-primary d-none">수정</button>
					<button id="remove-submit1" class="btn btn-danger d-none">삭제</button>
				</form>
			</div>
		</div>
	</div>
	
	<%-- 댓글 --%>
	<div class="container mt-3">
		<div class="row">
			<div class="col">
				<form action="${appRoot }/reply/insert" method="post">
					<div class="input-group">
						<input type="hidden" name="boardId" value="${board.id }" />
						<input class="form-control" type="text" name="content" required />
						<button class="btn btn-secondary"><i class="fa-solid fa-comment-dots"></i></button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<%-- 댓글 목록 --%>
	<div class="container mt-3">
		<div class="row">
			<div class="col">
				<c:if test="${not empty param.insertReplySuccess }">
					<c:if test="${param.insertReplySuccess }">
						<div class="alert alert-primary">댓글을 등록하였습니다.</div>
					</c:if>
					<c:if test="${not param.insertReplySuccess }">
						<div class="alert alert-danger">댓글을 등록하는데에 문제가 발생하였습니다.</div>
					</c:if>
				</c:if>
				<c:if test="${not empty param.modifyReplySuccess }">
					<c:if test="${param.modifyReplySuccess }">
						<div class="alert alert-primary">댓글을 수정하였습니다.</div>
					</c:if>
					<c:if test="${not param.modifyReplySuccess }">
						<div class="alert alert-danger">댓글을 수정하는데에 문제가 발생하였습니다.</div>
					</c:if>
				</c:if>
				
				<c:if test="${not empty param.removeReplySuccess }">
					<c:if test="${param.removeReplySuccess }">
						<div class="alert alert-primary">댓글이 삭제되었습니다.</div>
					</c:if>
					<c:if test="${not param.removeReplySuccess }">
						<div class="alert alert-danger">댓글을 삭제하는데에 문제가 발생하였습니다.</div>
					</c:if>
				</c:if>
				<h3>댓글 ${board.numOfReply }개</h3>
				
				
				<ul class="list-group">
					<c:forEach items="${replyList }" var="reply" >
						<li class="list-group-item">
							<div id="replyDisplayContainer${reply.id }">
								<div class="fw-bold"><i class="fa-solid fa-comment"></i> ${reply.inserted }</div>
								${reply.content }
								
								<button style="float: right;" class="reply-delete-button" data-reply-id="${reply.id }">
									<i class="fa-solid fa-trash-can"></i>
								</button>
								
								<button style="float: right;" class="reply-edit-toggle-button" id="replyEditToggleButtone${reply.id }" data-reply-id="${reply.id }">
								<i class="fa-solid fa-pen-to-square"></i></button>															
							</div>
							
							<div id="replyEditFormContainer${reply.id }" style="display: none;">
								<form action="${appRoot }/reply/modify" method="post">
									<div class="input-group">
										<input type="hidden" name="boardId" value="${board.id }" />
										<input type="hidden" name="id" value="${reply.id }" />
										<input class="form-control" value="${reply.content }" type="text" name="content" required />
										<button class="btn btn-outline-secondary"><i class="fa-solid fa-comment-dots"></i></button>
									</div>
								</form>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	
	<%-- reply 삭제 --%>
	<div class="d-none">
		<form id="replyDeleteForm1" action="${appRoot }/reply/remove" method="post">
			<input type="hidden" name="boardId" value="${board.id }" />
			<input id="replyDeleteInput1" type="text" name="id" />
		</form>
	</div>
</body>
</html>