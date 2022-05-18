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

<title>Insert title here</title>
</head>
<body>
	<my:navBar current="list"></my:navBar>
	<div class="container">
		<div class="row">
			<div class="col">
				<h1>글 목록</h1>
				
				<c:if test="${not empty param.removeSuccess }">
					<c:if test="${param.removeSuccess }">
						<div class="alert alert-primary">게시물이 삭제되었습니다.</div>
					</c:if>
					<c:if test="${not param.removeSuccess }">
						<div class="alert alert-danger">게시물을 삭제하는데에 문제가 발생하였습니다.</div>
					</c:if>
				</c:if>
				
				<form action="${appRoot }/board/search">
					<div style="float: right">
						<input type="text" name="searchKeyword" value="${param.searchKeyword }" />
						<button class="btn btn-info"><i class="fa-solid fa-magnifying-glass"></i></button>
					</div>
				</form>
				
				<br /><br />
				
				<form action="${appRoot }/board/paging">
					<input type="hidden" name="page" value="${pageInfo.current }" />
					<div style="float: right">
						<select name="pageNum" id="pageNum">
							<option value="5" ${param.pageNum == '5' ? 'selected="selected"' : '' }>5개씩 보기</option>
							<option value="10" ${param.pageNum == '10' ? 'selected="selected"' : '' }>10개씩 보기</option>
							<option value="${count }" ${param.pageNum == count ? 'selected="selected"' : '' }>전체보기</option>
						</select>
						<button class="btn btn-info">보기</button>
					</div>
				</form>
				
				<table class="table">
					<thead>
						<tr>
							<th>id</th>
							<th>title</th>
							<th>inserted</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${boardList }" var="board">
							<tr>
								<td>${board.id }</td>								
								<td>
								
								<c:url value="${board.id }" var="link"></c:url>
								<a href="${link }">${board.title }</a>
								<c:if test="${board.numOfReply > 0 }">
									[${board.numOfReply }]
								</c:if>
								</td>
								<td>${board.inserted }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<my:PageNation path="paging" />
			</div>
		</div>
	</div>
</body>
</html>