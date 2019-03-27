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
<!-- 카카오 sdk -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>
	$(document).ready(function() {
		$("#btnComment").click(function() {
			reply(); // 폼데이터 형식으로 입력
		});
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
<!-- SNS 공유용 주소 연결 용 -->
<script type="text/javascript" async>
	var url_default_tw_txt = "https://twitter.com/intent/tweet?text=";
	var url_default_tw_url = "&url=";
	var url_default_band = "http://band.us/plugin/share?body=";
	var url_route_band = "&route=";
	var url_default_naver = "http://share.naver.com/web/shareView.nhn?url=";
	var title_default_naver = "&title=";
	var url_this_page = location.href;
	var title_this_page = document.title;
	var url_combine_tw = url_default_tw_txt + document.title
			+ url_default_tw_url + url_this_page;
	var url_combine_band = url_default_band + encodeURI(url_this_page) + '%0A'
			+ encodeURI(title_this_page) + '%0A' + '&route=tistory.com';
	var url_combine_naver = url_default_naver + encodeURI(url_this_page)
			+ title_default_naver + encodeURI(title_this_page);
</script>
<script type="text/javascript">
$(function(){
	
	
	$(".comment-box-reply-wrap").hide();
	$(".comment-box-up-wrap").hide();
	$(".btn-reply").click(function(){
		$(this).parent().parent().parent().parent().children(".comment-box-reply-wrap").toggle();
	});
	$(".btn-update").click(function(){
		$(this).parent().parent().parent().parent().children(".comment-box-up-wrap").toggle();
	});
});
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
		<!-- 다이어리 원글 리스트 -->
		<c:choose>
			<c:when test="${empty map.list }">
				<tr>
					<td colspan="5" aslign="center">---작성된 글이 없습니다.---</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="row" items="${map.list}">
					<tr>
						<td>${row.diaryno }</td>
						<td>${row.title }</td>
						<td>${row.content}</td>
						<td><fmt:formatDate value="${row.regdate}"
								pattern="yyyy-MM-dd HH:mm" /></td>
						<td id="groupno">그룹 번호${row.groupno }</td>
					</tr>
					<tr>
						<td colspan="5">
							<!-- SNS버튼 시작 -->
							<div style="width: 100%; text-align: center; margin-bottom: 64px;">
								<a id="kakao-link-btn" href="javascript:;"> 
								<img src="//developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_small.png"
									title="카카오 공유하기" class="sharebtn_custom" style="width: 32px;" />
								</a>
								<script type='text/javascript'>
									var url_this_page = location.href;
									var title_this_page = document.title;
									var url=url_this_page+title_this_page
									//<![CDATA[
									// // 사용할 앱의 JavaScript 키를 설정해 주세요.
									Kakao
											.init('1c8b81ba3e8a0181c778c2d6d46e4767');
									// // 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
									Kakao.Link.createDefaultButton({
										container : '#kakao-link-btn',
										objectType : 'feed',
										content : {
											title : '${row.title}',
											description : '${row.title}',
											imageUrl : '${row.picurl}',
											link : {
												mobileWebUrl : url,
												webUrl : url
											}
										},
										buttons : [ {
											title : '웹으로 보기',
											link : {
												mobileWebUrl : url,
												webUrl : url
											}
										} ]
									});
									//]]>
								</script>
								<!-- 트위터 공유 버튼 -->
								<a href="" onclick="window.open(url_combine_tw, '', 'scrollbars=no, width=600, height=600'); return false;">
									<img src="resources/img/snsshare/twitter_1.png"
									title="트위터로 공유하기" class="sharebtn_custom" style="width: 32px;"/>
								</a>
								<!-- 네이버 공유 버튼 -->
								<a href=""
									onclick="window.open(url_combine_naver, '', 'scrollbars=no, width=600, height=600'); return false;">
									<img src="resources/img/snsshare/naver.png" title="네이버로 공유하기" class="sharebtn_custom" style="width: 32px;"/>
								</a>
								<!-- 밴드 공유 버튼 -->
								<a href=""
									onclick="window.open(url_combine_band, '', 'scrollbars=no, width=584, height=635'); return false;">
									<img src="resources/img/snsshare/nband_1.png" title="밴드로 공유하기"
									class="sharebtn_custom" style="width: 32px;">
								</a>
							</div> 
							<!-- SNS버튼 끝 -->
						</td>
					</tr>

					<tr>
						<td colspan="5" >
							<div class="comment-box-recomment">
								<a class="btn-reply">답글</a>
							</div>
							<div class="comment-box-button">
								<div class="comment-button">
									<a class="btn-delete"
										onclick="">삭제</a>
								</div>
								<div class="comment-button">
									<a class="btn-update">수정</a>
								</div>
							</div>
						</td>
					</tr>
					<!-- 댓글리스트 -->
					<c:forEach var="cmt" items="${map.commentList}">
						<c:if test="${row.groupno eq cmt.groupno }">
							<tr>
								<td>
									<div class="comment-box-reply-wrap">
										<p style="float: left; margin-right: 10px;">ㄴ</p>
										<input class="comment-box-reply" name="jr_cmcontent"type="text">
										<div class="comment-cmbutton">
											<input type="hidden" name="jr_cmno"value=""> 
											<input type="hidden" name="jr_boardno"value=""> 
											<input type="hidden" name="user_id" value="">
											<input type="hidden" name="user_img" value="">
											<input type="hidden" name="user_nick" value=""> 
											<input type="submit" class="btn-reply-sumbit" value="확인" />
										</div>
									</div>
									<div class="comment-box-up-wrap">
										<p style="float: left; margin-right: 10px;">ㄴ</p>
										<input class="comment-box-reply" id="jr_cmcontent2"name="jr_cmcontent2" type="text" value="">
										<div class="comment-cmbutton">
											<input type="hidden" class="jr_cmno2" name="jr_cmno2"value=""> 
											<input type="hidden" class="jr_boardno2" name="jr_boardno2"value=""> 
											<input type="hidden" class="user_id2" name="user_id2" value="">
											<input type="button" class="jrup" value="확인" />
										</div>
									</div>
								</td>
								<td>${cmt.title }</td>
								<td>${cmt.content }</td>
								<td>그룹 번호=${cmt.groupno }</td>
								<td>그룹 순서=${cmt.groupsq }</td>
								
							</tr>
							
						</c:if>
					</c:forEach>

					<!-- 댓글 작성 영역 -->
					<tr>
						<td colspan="5">
							<form action="${path}/mvc03/comment_insert">
								<input type="hidden" name="groupno" value="${row.groupno }">
								<input type="hidden" name="groupsq" value="${row.groupsq }">
								<input type="hidden" class="diaryno" name="diaryno"
									value="${row.diaryno }">
								<div style="width: 650px; text-align: center;">
									<input type="text" class="title" name="title" value="">
									<br>
									<!-- 로그인 한 회원에게만 댓글 작성폼이 보이게 처리 -->
									<%-- <c:if test="${sessionScope.userId != null}"> --%>
									<textarea rows="5" cols="70" class="replytext" name="content"
										placeholder="댓글을 작성해주세요"></textarea>
									<br>
									
									<button type="submit" class="btnComment">댓글 작성</button>
									<%-- </c:if> --%>
								</div>
								
							</form>
						</td>
					</tr>
					<!-- 댓글 작성 영역 -->

				</c:forEach>
			</c:otherwise>
		</c:choose>


		<!-- 페이징 -->
		<tr>
			<td colspan="5">
				<!-- 처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력--> <c:if
					test="${map.paging.curBlock >= 1}">
					<a href="javascript:list('1')">[처음]</a>
				</c:if> <!-- 이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 --> <c:if
					test="${map.paging.curBlock > 1}">
					<a href="javascript:list('${map.paging.prevPage}')">[이전]</a>
				</c:if> <!-- **하나의 블럭 시작페이지부터 끝페이지까지 반복문 실행 --> <c:forEach var="num"
					begin="${map.paging.blockBegin}" end="${map.paging.blockEnd}">
					<!-- 현재페이지이면 하이퍼링크 제거 -->
					<c:choose>
						<c:when test="${num == map.paging.curPage}">
							<span style="color: red">${num}</span>&nbsp;
						</c:when>
						<c:otherwise>
							<a href="javascript:list('${num}')">${num}</a>&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach> <!-- 다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
				<c:if test="${map.paging.curBlock <= map.paging.totBlock}">
					<a href="javascript:list('${map.paging.nextPage}')">[다음]</a>
				</c:if> <!-- 끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 --> <c:if
					test="${map.paging.curPage <= map.paging.totPage}">
					<a href="javascript:list('${map.paging.totPage}')">[끝]</a>
				</c:if>
			</td>
		</tr>
		<!-- 페이징 -->

	</table>



</body>
</html>