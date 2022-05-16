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
</body>
</html>