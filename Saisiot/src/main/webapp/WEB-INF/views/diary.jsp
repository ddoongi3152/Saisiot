<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.List"%>
<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"></script>
<link rel="stylesheet" href="resources/css/diary_web.css">
<link rel="stylesheet" href="resources/css/diary_mob.css">
<title>Insert title here</title>
<script type="text/javascript">
	//원하는 페이지로 이동시 검색조건, 키워드 값을 유지하기 위해 
	function list(page) {
		location.href = "${path}/mvc03/diary.do?curPage=" + page
				+ "&searchOption-${map.searchOption}"
				+ "&keyword=${map.keyword}";
	}
</script>
</head>
<body>
	<%
		String whos = (String) session.getAttribute("whos");
		UserinfoDto dto;
		if (whos.equals("mine")) {
			dto = (UserinfoDto) session.getAttribute("login");
		} else {
			dto = (UserinfoDto) session.getAttribute("others");
		}

		List<String> friendList = (List<String>) session.getAttribute("friendList");
		//UserinfoDto dto = (UserinfoDto)session.getAttribute("login");

		if (dto.getAddr() == null) {
			response.sendRedirect("user_info_plus.do");
		}
	%>
	<div id="left_wrapper1">
		<div id="left_wrapper2">
			<div id="left_wrapper3">
				<div id="left_wrapper4">
					<div id="left_wrapper5_1">today | total</div>
					<div id="left_wrapper5_2">
						<div id="left_wrapper6">
							<div id="mob_top">사이좋은 사람들 사이시옷</div>
							<div id="tmpdiv">|프로필|다이어리|갤러리|쥬크박스|</div>
							<div id="folder_list_div">
								<ul>
									<li><a>전체보기</a></li>
									<li><a>20190303강릉</a></li>
									<li><a>20190311태국</a></li>
								</ul>
							</div>
						</div>
					</div>
					<!-- left_wrapper5 end -->
				</div>
				<!-- left_wrapper4 end(white box) -->
			</div>
			<!-- left_wrapper3 end(gray box) -->
		</div>
		<!-- left_wrapper2 end(dashed box) -->
	</div>
	<!-- left_wrapper1 end(blue box) -->


	<div id="right_wrapper1">
		<div id="right_wrapper2">
			<div id="right_wrapper3">
				<div id="right_wrapper4">
					<div id="right_wrapper4_1">사이좋은 사람들 사이시옷</div>

					<!-- right_wrapper4_2: right contentbox start -->
					<div id="right_wrapper4_2">
						<!-- search option  -->
						<div class="diary_search">
							<form name="form1" method="post" action="${path}/mvc03/diary.do">
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
						</div>
						<!-- diary list area , groupsq=0 list -->
						<c:choose>
							<c:when test="${empty map.list }">
								<div class="diary_div">
									<div class="diary_title">---작성된 글이 없습니다.---</div>
									<div class="diary_meta"></div>
									<div class="diary_pic"></div>
									<div class="diary_content">----게시글을 작성해주세요----</div>
								</div>
							</c:when>
							<c:otherwise>
								<c:forEach var="row" items="${map.list}">
									<div class="diary_div">
										<div class="diary_title">${row.title }</div>
										<div class="diary_meta">
											<fmt:formatDate value="${row.regdate}"
												pattern="yyyy-MM-dd HH:mm" />
										</div>
										<div class="diary_pic">${row.picurl }</div>
										<div class="diary_content">${row.content }</div>

										<!-- comment area -->
										<c:forEach var="cmt" items="${map.commentList}">
											<c:if test="${row.groupno eq cmt.groupno }">
												<div class="diary_reply">
													<div class="reply">
														<div class="reply_writer">${cmt.email }</div>
														<div class="reply_content">${cmt.content }</div>
														<br>
														<div class="reply_btn">
															<fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm" />
															<input type="button" value="삭제" onclick="location.href='comment_delete?diaryno=${cmt.diaryno}'">
														</div>
													</div>
												</div>
											</c:if>
										</c:forEach>

										<!-- 댓글 작성 영역 -->
										<div>
											<div>
												<form action="${path}/mvc03/comment_insert">
													<input type="hidden" name="groupno" value="${row.groupno }">
													<input type="hidden" name="groupsq" value="${row.groupsq }">
													<input type="hidden" class="diaryno" name="diaryno" value="${row.diaryno }">
													<div style="width: 100%; text-align: center;">
														<!-- 로그인 한 회원에게만 댓글 작성폼이 보이게 처리 -->
														<%-- <c:if test="${sessionScope.userId != null}"> --%>
														<textarea rows="2" cols="70" class="replytext"
															name="content" placeholder="댓글을 작성해주세요"></textarea>
														<br>
														<button type="submit" class="btnComment">댓글 작성</button>
														<%-- </c:if> --%>
													</div>

												</form>
											</div>
										</div>
										<!-- 댓글 작성 영역 -->

									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
						<!-- paging -->
						<div id="right_wrapper4_3">
							<div id="diary_paging">
								<!-- 처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
								<c:if test="${map.paging.curBlock >= 1}">
									<a href="javascript:list('1')">[처음]</a>
								</c:if>
								<!-- 이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
								<c:if test="${map.paging.curBlock > 1}">
									<a href="javascript:list('${map.paging.prevPage}')">[이전]</a>
								</c:if>
								<!-- **하나의 블럭 시작페이지부터 끝페이지까지 반복문 실행 -->
								<c:forEach var="num" begin="${map.paging.blockBegin}"
									end="${map.paging.blockEnd}">
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
							</div>
						</div>

					</div>
				</div>
				<!-- right_wrapper4_2 end -->
			</div>
			<!-- right_wrapper4 end(white box) -->
		</div>
		<!-- right_wrapper3 end(gray box) -->
	</div>
	<!-- right_wrapper2 end(dashed box) -->
	</div>
	<!-- right_wrapper1 end(blue box) -->

	<!-- -webtabs start(desktop only) -->
	<div id="web_tabs">
		<div onclick="location.href='home.do'">home</div>
		<div onclick="location.href='gallery.do'">gallery</div>
		<div onclick="location.href='diary.do'">diary</div>
		<%-- <div onclick="location.href='jukebox.do?email=<%=dto.getEmail()%>'"> --%>
		<div
			style="display:<%=(!session.getAttribute("whos").equals("mine")) ? "none" : ""%>">
			<a href="profile.do">profile</a>
		</div>
		<div onclick="location.href='chat.do'">chat</div>
	</div>
	<!--webtabs end(desktop only)-->



	<div id="right_sidebar">
		<div id="to_home">메인홈으로</div>
		<div id="graph">그래프표시영역</div>
		<div id="audio">
			<audio controls controlsList="nodownload" loop>
				<source src="test.mp3" type="audio/mpeg">
				Your browser does not support the audio tag.
			</audio>
		</div>
		<div id="audio_list">
			<table>
				<tr>
					<td>오디오리스트</td>
				</tr>
				<tr>
					<td>오디오리스트</td>
				</tr>
				<tr>
					<td>오디오리스트</td>
				</tr>
				<tr>
					<td>오디오리스트</td>
				</tr>
				<tr>
					<td>오디오리스트</td>
				</tr>
				<tr>
					<td>오디오리스트</td>
				</tr>
				<tr>
					<td>오디오리스트</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>