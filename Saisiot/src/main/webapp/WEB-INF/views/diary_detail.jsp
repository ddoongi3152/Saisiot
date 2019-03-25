<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/map.css" />
</head>
<body>

	<h1>게시글 상세보기</h1>

	<table>
		<tr>
			<th>제 목</th>
			<td>${dto.title }</td>
			<th>작성일</th>
			<td>${dto.regdate }</td>
			<th>조회수</th>
			<td>${dto.viewtime }</td>
		</tr>
		<tr>
			<th>내 용</th>
			<td>${dto.content }</td>
		</tr>
	</table>
	<c:choose>
		<c:when test="${ empty dto.maplati}">
			<input type="hidden" value="${dto.maplati }" id="maplati" />
			<input type="hidden" value="${dto.maplong }" id="maplong" />
			<input type="hidden" value="${dto.mapname }" id="mapname" />
		</c:when>
		<c:otherwise>
			<div class="map_wrap">
				<div id="map"
					style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
			</div>
		</c:otherwise>
	</c:choose>
	<input type="hidden" value="${dto.diaryno }" name="diaryno" />
	<input type="hidden" value="${dto.folderno }" name="folderno" />
	<form action="download.do" method="post">
		<input type="text" name="filename" value="${dto.fileurl }"/>
		<input type="submit" value="DOWNLOAD"/>
	</form>
	<img src="<spring:url value="/upload/${dto.picurl }"/>" />
	<input type="hidden" value="${dto.mapname }" id="mapname" />
	<input type="hidden" value="${dto.maplati }" id="maplati" />
	<input type="hidden" value="${dto.maplong }" id="maplong" />
	<input type="hidden" value="${dto.videourl }" name="videourl" />


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