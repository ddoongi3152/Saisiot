<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="java.util.List"%>
<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta property="og:url" content="${path}/diary.do" />
<meta property="og:site_name" content="Dreamload" />
<meta property="og:title" content="사이시옷" />
<meta property="og:description" content="사이시옷" />
<meta property="og:image" content="../img/99E7B933599BF9DD16.jpg" />
<script type="text/javascript"></script>
<link rel="stylesheet" href="resources/css/diary_web.css">
<link rel="stylesheet" href="resources/css/diary_mob.css">
<link rel="stylesheet" type="text/css" href="resources/css/map.css" />
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.js" />"></script>
<title>Insert title here</title>
<script type="text/javascript">
	//원하는 페이지로 이동시 검색조건, 키워드 값을 유지하기 위해 
	function list(page) {
		location.href = "${path}/mvc03/diary.do?curPage=" + page
				+ "&searchOption-${map.searchOption}"
				+ "&keyword=${map.keyword}";
	}

	//폴더 추가 팝업 띄우기
	function insert_Folder() {
		window.open("insertForm_folder.do", "폴더 추가", "width=300,height=100")
	}
	
	//폴더 삭제 팝업 
	function delete_Folder(folderno){
		window.open("deleteForm_folder.do?folderno="+folderno, "폴더 삭제", "width=300,height=100")
	}
	
	//폴더 수정 팝업
	function update_Folder(folderno){
		window.open("updateForm_folder.do?folderno="+folderno, "폴더 수정", "width=300,height=100")
	}
</script>
<!-- 네이버 공유용 주소 연결 용 -->
<script type="text/javascript" async>
	var url_default_naver = "http://share.naver.com/web/shareView.nhn?url=";
	var title_default_naver = "&title=";
	var url_this_page = location.href;
	var title_this_page = document.title;
	var url_combine_naver = url_default_naver + encodeURI(url_this_page)
			+ title_default_naver + encodeURI(title_this_page);
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
									<li><a>전체보기</a><a href='javascript:void(0);'
										onclick="insert_Folder();"> 폴더 추가</a></li>
									<c:choose>
										<c:when test="${empty map.folderList }">
											<li><p>폴더를 생성해주세요.</p></li>
										</c:when>
										<c:otherwise>
											<c:forEach var="list" items="${map.folderList }">
												<li>
													<a href="">${list.foldername }</a>
													<a href='javascript:void(0);' onclick="delete_Folder(${list.folderno});">
													삭제</a>
													<a href='javascript:void(0);' onclick="update_Folder(${list.folderno});">
													수정</a>
												</li>
											</c:forEach>
										</c:otherwise>
									</c:choose>
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
								</select> 
								<input name="keyword" value="${map.keyword}"> 
								<input type="submit" value="검색">
								<input type="button" value="글쓰기" onclick="location.href='insertForm_diary.do'" />
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
										<c:choose>
											<c:when test="${ empty row.picurl }">
											</c:when>
											<c:otherwise>
												<div class="diary_pic" style="width: 400px; height: 300px;">
													<img style="width: 100%; height: 100%;"
														src="<spring:url value='/upload/${row.picurl }'/>" />
												</div>
											</c:otherwise>
										</c:choose>
										<div class="diary_content">${row.content }</div>
										<c:choose>
											<c:when test="${ empty row.maplati}">
												<input type="hidden" value="${row.maplati }" id="maplati" />
												<input type="hidden" value="${row.maplong }" id="maplong" />
												<input type="hidden" value="${row.mapname }" id="mapname" />
											</c:when>
											<c:otherwise>
												<div>
													<input type="hidden" id="mapname" value="${row.mapname }" />
													<input type="hidden" id="maplati" value="${row.maplati }" />
													<input type="hidden" id="maplong" value="${row.maplong }" />
													<div class="map_wrap" style="width: 300px; height: 300px;">
														<div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
													</div>
												</div>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${ empty row.videourl }">
											</c:when>
											<c:otherwise>
												<div>
													<iframe width="514" height="360" src="${row.videourl }"
														frameborder="0"
														allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
														allowfullscreen>
													</iframe>
												</div>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${ empty row.fileurl }">
											</c:when>
											<c:otherwise>
												<div>
													<form action="download.do" method="post">
														<input type="text" name="filename" value="${row.fileurl }" />
														<input type="submit" value="DOWNLOAD" />
													</form>
												</div>
											</c:otherwise>
										</c:choose>

										<!-- sns share -->
										<div style="width: 100%; text-align: center; margin-bottom: 64px;">
											<a id="kakao-link-btn" href="javascript:;"> 
											<img src="//developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_small.png"
												title="카카오 공유하기" class="sharebtn_custom" style="width: 32px;" />
											</a>
											<script type='text/javascript'>
												//<![CDATA[
												// // 사용할 앱의 JavaScript 키를 설정해 주세요.
												Kakao.init('1fe75f64aaf4512f8f75ce29f8ceb483');
												// // 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
												Kakao.Link.createDefaultButton({
													container : '#kakao-link-btn',
													objectType : 'feed',
													content : {
														title : '${row.title}',
														description : '${row.title}',
														imageUrl : '${row.picurl}',
														link : {
															mobileWebUrl : '${path}/mvc03/diary.do?',
															webUrl : '${path}/mvc03/diary.do?'
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
											<!-- 네이버 공유 버튼 -->
											<a href=""
												onclick="window.open(url_combine_naver, '', 'scrollbars=no, width=600, height=600'); return false;">
												<img src="resources/img/snsshare/naver.png" title="네이버로 공유하기" class="sharebtn_custom" style="width: 32px;"/>
											</a>
										</div> 
										<!-- sns share end -->

										<!-- comment area -->
										<div class="diary_reply">
											<c:forEach var="cmt" items="${map.commentList}">
												<c:if test="${row.groupno eq cmt.groupno }">

													<div class="reply">
														<div class="reply_writer">${cmt.email }</div>
														<div class="reply_content">${cmt.content }</div>
														<br>
														<div class="reply_btn">
															<fmt:formatDate value="${row.regdate}"
																pattern="yyyy-MM-dd HH:mm" />
															<input type="button" value="삭제"
																onclick="location.href='comment_delete?diaryno=${cmt.diaryno}'">
														</div>
													</div>
												</c:if>
											</c:forEach>
										</div>

										<!-- 댓글 작성 영역 -->
										<div class="diary_comment">
											<form action="${path}/mvc03/comment_insert">
												<input type="hidden" name="groupno" value="${row.groupno }">
												<input type="hidden" name="groupsq" value="${row.groupsq }">
												<input type="hidden" class="diaryno" name="diaryno"
													value="${row.diaryno }">
												<div class="diary_comment_textarea">
													<a>댓글</a>
													<!-- 로그인 한 회원에게만 댓글 작성폼이 보이게 처리 -->
													<%-- <c:if test="${sessionScope.userId != null}"> --%>
													<textarea rows="1" cols="59" class="replytext"
														name="content" placeholder="댓글을 작성해주세요"></textarea>
													<button type="submit" class="diary_comment_btn">확인</button>
													<%-- </c:if> --%>
												</div>
											</form>
										</div>
										<!-- 댓글 작성 영역 -->

									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>

						<!-- paging -->
						<div id="right_wrapper4_2_2">
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
						<!-- right_wrapper4_2_2 end -->
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

	<script
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1fe75f64aaf4512f8f75ce29f8ceb483&libraries=services"></script>
	<script>
		// 마커를 담을 배열입니다
		var markers = [];

		var maplati = $("#maplati").val();
		var maplong = $("#maplong").val();
		var mapname = $("#mapname").val();

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new daum.maps.LatLng(maplati, maplong), // 지도의 중심좌표
			level : 3, // 지도의 확대 레벨
			mapTypeId : daum.maps.MapTypeId.ROADMAP
		// 지도종류
		};

		// 지도를 생성한다 
		var map = new daum.maps.Map(mapContainer, mapOption);

		// 마우스 드래그와 모바일 터치를 이용한 지도 이동을 막는다
		map.setDraggable(false);

		// 마우스 휠과 모바일 터치를 이용한 지도 확대, 축소를 막는다
		map.setZoomable(false);

		// 지도에 마커를 생성하고 표시한다
		var marker = new daum.maps.Marker({
			position : new daum.maps.LatLng(maplati, maplong), // 마커의 좌표
			map : map
		// 마커를 표시할 지도 객체
		});

		//장소 검색 서비스 객체 생성
		var places = new daum.maps.services.Places();

		// 마커 위에 표시할 인포윈도우를 생성한다
		var infowindow = new daum.maps.InfoWindow({
			content : '<div style="padding:5px;">' + mapname + '</div>' // 인포윈도우에 표시할 내용
		});

		// 인포윈도우를 지도에 표시한다
		infowindow.open(map, marker);
	</script>

</body>
</html>