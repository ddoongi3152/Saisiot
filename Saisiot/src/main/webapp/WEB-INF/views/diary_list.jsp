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
			location.href = "${path}/mvc03/diary_write.do";
		});
	});
	// 원하는 페이지로 이동시 검색조건, 키워드 값을 유지하기 위해 
	function list(page) {
		location.href = "${path}/mvc03/diary_list.do?curPage=" + page
				+ "&searchOption-${map.searchOption}"
				+ "&keyword=${map.keyword}";
	}
</script>
</head>
<body>
	<h2>페이징목록이긔</h2>
	${map.count}개의 게시물이 있습니다.
	<form name="form1" method="post" action="${path}/mvc03/diary_list.do">
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
				<c:forEach var="row" items="${map.list}">
					<%-- <c:if test="${row.groupsq eq 0}"> --%>
					<tr>
						<td>${row.diaryno }</td>
						<td>${row.title }</td>
						<td>${row.content}</td>
						<td><fmt:formatDate value="${row.regdate}"
								pattern="yyyy-MM-dd HH:mm" /></td>
						<td id="groupno">그룹 번호${row.groupno }</td>
					</tr>

					<!-- 댓글리스트 -->
					<c:forEach var="cmt" items="${map.commentList}">
						<c:if test="${row.groupno eq cmt.groupno }">
							<tr>
								<td>${row.groupno}:${cmt.groupno}</td>
								<td>${cmt.title }</td>
								<td>${cmt.content }</td>
								<td>그룹 번호=${cmt.groupno }</td>
								<td>그룹 순서=${cmt.groupsq }</td>
							</tr>
						</c:if>
					</c:forEach>
					<%-- <tr>
							<td colspan="5">
								<%@ include file="/WEB-INF/views/diary_comment.jsp"%>
							</td>
						</tr> --%>

					<!-- 댓글 작성 영역 -->
					<tr>
						<td colspan="5">
							<form action="${path}/mvc03/comment_insert">
							<input type="hidden" name="groupno" value="${row.groupno }">
							<input type="hidden" name="groupsq" value="${row.groupsq }"> 
							<div style="width: 650px; text-align: center;">
								<input type="text" name="title" value="">
								<br>
								<!-- 로그인 한 회원에게만 댓글 작성폼이 보이게 처리 -->
								<%-- <c:if test="${sessionScope.userId != null}"> --%>
								<textarea rows="5" cols="80" id="replytext" name="content" placeholder="댓글을 작성해주세요"></textarea>
								<br>
								<!-- 비밀댓글 체크박스 -->
								<input type="checkbox" id="secretReply">비밀 댓글
								<button type="button" id="btnReply">댓글 작성</button>
								<%-- </c:if> --%>
							</div>
							</form>
						</td>
					</tr>
					<!-- 댓글 작성 영역 -->

					<%-- </c:if> --%>
				</c:forEach>
			</c:otherwise>
		</c:choose>


		<!-- 페이징 -->
		<tr>
			<td colspan="5">
				<!-- 처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력--> 
				<c:if test="${map.paging.curBlock >= 1}">
					<a href="javascript:list('1')">[처음]</a>
				</c:if> 
				<!-- 이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 --> 
				<c:if test="${map.paging.curBlock > 1}">
					<a href="javascript:list('${map.paging.prevPage}')">[이전]</a>
				</c:if> 
				<!-- **하나의 블럭 시작페이지부터 끝페이지까지 반복문 실행 --> 
				<c:forEach var="num" begin="${map.paging.blockBegin}" end="${map.paging.blockEnd}">
					<!-- 현재페이지이면 하이퍼링크 제거 -->
					<c:choose>
						<c:when test="${num == map.paging.curPage}">
							<span style="color: red">${num}</span>&nbsp;
						</c:when>
						<c:otherwise>
							<a href="javascript:list('${num}')">${num}</a>&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach> 
				<!-- 다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
				<c:if test="${map.paging.curBlock <= map.paging.totBlock}">
					<a href="javascript:list('${map.paging.nextPage}')">[다음]</a>
				</c:if> 
				<!-- 끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 --> 
				<c:if test="${map.paging.curPage <= map.paging.totPage}">
					<a href="javascript:list('${map.paging.totPage}')">[끝]</a>
				</c:if>
			</td>
		</tr>
		<!-- 페이징 -->

	</table>
	
	
	
</body>
</html>