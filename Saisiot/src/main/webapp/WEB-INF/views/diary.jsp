<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>다이어리 레이아웃</h1>
	
	<table border="1">
		<col width="100" />
		<col width="300" />
		<col width="300" />
		<tr>
			<th>제	목</th>
			<th>내	용</th>
			<th>날	짜</th>
			<th>조 회 수</th>
		</tr>
		<c:choose>
			<c:when test="${empty list }">
				<tr>
					<td colspan="3" style="font-align : center">**** 작성된 글이 없습니다. ****</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${list }" var="dto">
					<tr>
						<td><input type="hidden" id="diaryno" value="${dto.diaryno }"/><a href="/mvc03/diaryDetail.do?diaryno=${dto.diaryno}" >${dto.title }</a></td>
						<td>${dto.content }</td>
						<td>${dto.regdate }</td>
						<td>${dto.viewtime }</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>

		<tr>
			<td colspan="3">
				<input type="button" value="글쓰기" onclick="location.href='insertForm_diary.do'" />
			</td>
		</tr>
	</table>

</body>
</html>