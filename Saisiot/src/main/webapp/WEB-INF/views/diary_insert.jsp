<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/diary_insert_web.css">
<link rel="stylesheet" href="resources/css/diary_insert_mob.css">
<title>Insert title here</title>
<!-- 스마트 에디터 -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript"
	src="<c:url value="/resources/api/se/js/HuskyEZCreator.js" />"
	charset="utf-8"></script>
<script type="text/javascript">
	$(function() {
		//전역변수선언
		var editor_object = [];

		nhn.husky.EZCreator.createInIFrame({
			oAppRef : editor_object,
			elPlaceHolder : "smarteditor",
			sSkinURI : "/mvc03/resources/api/se/SmartEditor2Skin.html",
			htParams : {
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseToolbar : true,
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,
			}
		});

		//전송버튼 클릭이벤트
		$("#savebutton").click(
				function() {
					//id가 smarteditor인 textarea에 에디터에서 대입
					editor_object.getById["smarteditor"].exec(
							"UPDATE_CONTENTS_FIELD", []);

					// 이부분에 에디터 validation 검증

					//폼 submit
					$("#frm").submit();
				});

		//장소선택 버튼 클릭이벤트
		$("#selectmap_btn").click(function() {
			window.open('selectForm_map.do', "장소 선택", "width=600, height=400")
		});

		//동영상추가 버튼 클릭이벤트
		$("#selectvideo_btn").click(
				function() {
					window.open('selectForm_video.do', "동영상 추가",
							"width=300,height=100")
				});

	});
</script>
<%
	UserinfoDto dto = (UserinfoDto) session.getAttribute("login");
%>
</head>
<body>

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
										<c:when test="${empty folderList}">
											<li><p>폴더를 생성해주세요.</p></li>
										</c:when>
										<c:otherwise>
											<c:forEach var="list" items="${folderList}">
												<li><a href="#">${list.foldername }</a></li>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</ul>
							</div>
						</div>
					</div>
					<!-- left_wrapper5_2 end -->
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
						<form:form id="frm" action="diary_insert.do" method="post" enctype="multipart/form-data" modelAttribute="DiaryDto">
							<input type="hidden" name="email" value="<%=dto.getEmail()%>" />
							<div id="diary_insert">
								<div id="diary_title_wrapper1">
									<div id="ddiary_title_wrapper2">
										제 목<input type="text" name="title" />
										<select class="folder_select" name="folderno">
											<c:forEach var="list" items="${folderList }">
												<option value="${list.folderno}">${list.foldername }</option>
											</c:forEach>
										</select>
									</div>
									<div>
										<input type="button" name="selectmap_btn" id="selectmap_btn" value="장소 선택" /> 
										<input id="file_btn" type="file" name="file"/>
										<input type="button" name="selectvideo_btn" id="selectvideo_btn" value="동영상 추가" />
									</div>
								</div>
								<div>
									<div>내 용</div>
									<div>
										<textarea rows="10" cols="100" name="content"
												id="smarteditor"
												style="width: 100%; height: 250px; min-width: 350px;">
			 							</textarea>
		 							</div>
								</div>
								<div id="insertTag">
									<div >
										<input type="button" value="작성" id="savebutton" />
										<input type="button" value="취소" onclick="location.href='diary.do'" />
									</div>
								</div>
							</div>
						</form:form>
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
























	<!-- 지도  -->
	<script
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1fe75f64aaf4512f8f75ce29f8ceb483&libraries=services"></script>
	<script>
		function addrCallBack(x, y, selectaddr) {

			// 선택한 지도 값을 가져오기전에 먼저 태그 삭제(장소 선택을 바꿀 수 있게 하기 위함)
			$("#maplati").remove();
			$("#maplong").remove();
			$("#mapname").remove();
			$("#selectmap").remove();
			$("mapdel").remove();

			// 선택한 지도 값을 이용하여 태그 생성 (map,maplati,maplong)
			var insTag_map = "<tr id='selectmap'> <th>지	도</th><td><div id='map' style='width:350px;height:350px;'></div></td></tr>";
			$("#insertTag").before(insTag_map);

			var maplati = "<input type='hidden' id='maplati' name='maplati' value='"+y+"'/>";
			$("#insertTag").before(maplati);

			var maplong = "<input type='hidden' id='maplong' name='maplong' value='"+x+"'/>";
			$("#insertTag").before(maplong);

			var mapname = "<input type='hidden' id='mapname' name='mapname' value='"+selectaddr+"'/>";
			$("#insertTag").before(mapname);

			var mapdel = "<input type='button' id='mapdel' value='지도삭제' />";
			$("#map").after(mapdel);

			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			mapOption = {
				center : new daum.maps.LatLng(y, x), // 지도의 중심좌표
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
				position : new daum.maps.LatLng(y, x), // 마커의 좌표
				map : map
			// 마커를 표시할 지도 객체
			});

			// 마커 위에 표시할 인포윈도우를 생성한다
			var infowindow = new daum.maps.InfoWindow({
				content : '<div style="padding:5px;">' + selectaddr + '</div>' // 인포윈도우에 표시할 내용
			});

			// 인포윈도우를 지도에 표시한다
			infowindow.open(map, marker);
		}

		function videoCallBack(videourl) {

			$("#selectvideo").remove();
			$("#videourl").remove();

			var insTag_video = "<tr id='selectvideo'> <th>동 영 상</th><td><iframe width='640' height='480' value='" + videourl + "'src='"+ videourl +"' frameborder='0' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe></td></tr>";
			$("#insertTag").before(insTag_video);

			var videourl_res = "<input type='hidden' id='videourl' name='videourl' value='"+videourl+"'/>";
			$("#insertTag").before(videourl_res);
		}
	</script>
</body>
</html>