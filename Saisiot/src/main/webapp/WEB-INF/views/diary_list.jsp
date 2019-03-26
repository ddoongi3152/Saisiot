<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	$(document).ready(function() {
		listReply();
		$("#btnWrite").click(function() {
			// 페이지 주소 변경(이동)
			location.href = "${path}/write.do";
		});
	});
	// 원하는 페이지로 이동시 검색조건, 키워드 값을 유지하기 위해 
	function list(page) {
		location.href = "${path}/sai/listall.do?curPage=" + page
				+ "&searchOption-${map.searchOption}"
				+ "&keyword=${map.keyword}";
	}
</script>
</head>
<body>
	<h2>페이징목록이긔</h2>
	${map.count}개의 게시물이 있습니다.
	<form name="form1" method="post" action="${path}/sai/listall.do">
		<select name="searchOption">
			<!-- 검색조건을 검색처리후 결과화면에 보여주기위해  c:out 출력태그 사용, 삼항연산자 -->
			<option value="all"
				<c:out value="${map.searchOption == 'all'?'selected':''}"/>>전체</option>
			<option value="content"
				<c:out value="${map.searchOption == 'content'?'selected':''}"/>>내용</option>
			<option value="title"
				<c:out value="${map.searchOption == 'title'?'selected':''}"/>>제목</option>
		</select> <input name="keyword" value="${map.keyword}"> <input
			type="submit" value="검색">
	</form>
	<table border="1">
		<tr>
			<th>다이어리번호</th>
			<th>제목</th>
			<th>내용</th>
			<th>작성일</th>
			<th>그룹번호</th>
		</tr>
		<c:choose>
		 	<c:when test="${empty map.list }">
				<tr>
					<td colspan="3" aslign="center">---작성된 글이 없습니다.---</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="row" items="${map.list}" >
					<c:if test="${row.groupsq eq 0}">
						<tr>
							<td>${row.diaryno }</td>
							<td>${row.title }</td>
							<td>${row.content}</td>
							<td><fmt:formatDate value="${row.regdate}"
									pattern="yyyy-MM-dd HH:mm" /></td>
							<td id="groupno">그룹 번호${row.groupno }</td>
						</tr>
					</c:if>
				</c:forEach>
			</c:otherwise>
		</c:choose>

	</table>
</body>
</html>