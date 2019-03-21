<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/map.css"/>
</head>
<body>

	<h1>게시글 상세보기</h1>
	
	<table>
		<tr>
			<th>제	목</th>
			<td>${dto.title }</td>
			<th>작성일</th>
			<td>${dto.regdate }</td>
			<th>조회수</th>
			<td>${dto.viewtime }</td>
		</tr>
		<tr>
			<th>내	용</th>
			<td>${dto.content }</td>
		</tr>
	</table>
		<c:choose>
			<c:when test="${ empty dto.maplati}">
				<input type="hidden" value="${dto.maplati }" id="maplati"/>
				<input type="hidden" value="${dto.maplong }" id="maplong"/>
			</c:when>
			<c:otherwise>
				<div class="map_wrap">
					<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
				</div>
			</c:otherwise>
		</c:choose>
			<input type="hidden" value="${dto.diaryno }" name="diaryno"/>
			<input type="hidden" value="${dto.folderno }" name="folderno"/>
			<input type="file" value="${dto.fileurl }" name="fileurl"/>
			<input type="hidden" value="${dto.picurl }" name="picurl"/>
			<input type="hidden" value="${dto.maplati }" id="maplati"/>
			<input type="hidden" value="${dto.maplong }" id="maplong"/>
			<input type="hidden" value="${dto.videourl }" name="videourl"/>

	
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1fe75f64aaf4512f8f75ce29f8ceb483&libraries=services"></script>
	<script>
	// 마커를 담을 배열입니다
	var markers = [];
	
	var maplati = $("#maplati").val();
	var maplong = $("#maplong").val();
	alert(maplati);
	alert(maplong);

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new daum.maps.LatLng(maplati, maplong), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

	// 지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption);
	</script>

</body>
</html>