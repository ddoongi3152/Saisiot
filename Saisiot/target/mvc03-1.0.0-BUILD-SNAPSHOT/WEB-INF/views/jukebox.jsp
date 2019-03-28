<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="resources/js/bgm.js?ver=3"></script>
<script src="resources/js/jukebox.js?ver=2"></script>
<script type="text/javascript">

	$(window).resize(function(){
		if ($(window).width() > 460) {
			  $("#music_list_div").show()
		}else {
			$("#music_list_div").hide()
		}
	})
	$(document).ready(function(){
	  $("#music_list_drop").click(function(){
	    $("#music_list_div").toggle()
	  });
	});

	// 체크박스 체크, 언체크 값 넘겨서 submit
	function chksubmit() {
		var unchkArray = new Array();
		var unchktag = "";
		$("input[name=chk]:not(:checked)").each(function() { 
				
			unchkArray.push($(this).val()); 
		}); 
		$(unchkArray).each(function(index, item) {
			unchktag += "<input type='hidden' name='unchk' value='"+item+"'>"
		});
		$("#hiddenunchk").append(unchktag);
		
		$('#updateBackForm').submit();
	}


</script>
<link rel="stylesheet" href="resources/css/jukebox_web.css?ver=1">
<link rel="stylesheet" href="resources/css/jukebox_mob.css?ver=1">
<title>Insert title here</title>
</head>
<body>
	<%
		UserinfoDto dto = (UserinfoDto)session.getAttribute("login");
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
			<c:choose>
				<c:when test="${empty jukelist }">
					<div id="music_list_drop" checked="true">노래 목록이 없습니다.</div>
				</c:when>
				<c:otherwise>
					<div id="music_list_drop" checked="true">${jukelist[0].musictitle }</div>
				</c:otherwise>
			</c:choose>
			<form id="updateBackForm" action="updateBack.do" method="post">
			<input type="hidden" name="email" value="<%=dto.getEmail()%>">
			<div id="music_list_div">
				<ul>
					<li><img src="resources/img/folder_icon.png"><a>내 쥬크박스</a></li>
				<c:choose>
				<c:when test="${empty jukelist }">
					<li>
						구매한 노래 목록이 없습니다.
					</li>
				</c:when>
				<c:otherwise>
					<c:forEach items="${jukelist }" var="list">
							<li align="center">
								<c:choose>
									<c:when test="${list.background eq 'Y'}">
										<input type="checkbox" name="chk" class="chk" checked="checked" value="${list.musicno }">
									</c:when>
									<c:otherwise>
										<input type="checkbox" name="chk" class="chk" value="${list.musicno }">
									</c:otherwise>
								</c:choose>
							<a onclick="musiclistForm();">${list.musictitle }</a></li>
					</c:forEach>
				</c:otherwise>
			</c:choose>
					<li><a onclick="chksubmit()">저장</a></li>
				</ul>
				<div id="hiddenunchk" style="display: none;"></div>
			</div>
			</form>
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
			<form id="searchForm" action="jukebox.do" method="post">
			<input type="hidden" name="email" id="email" value="<%=dto.getEmail()%>">
				<div id="search_div"><input type="text" id="search" placeholder="노래명을 검색해주세요."/><div onclick="searchMusic();">검색</div></div>
				<table id="music_table">
					<thead>
						<tr>
							<th>가수명</th>
							<th>노래명</th>
							<th>재생시간</th>
							<th>앨범명</th>
							<th></th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
				<input type="submit" style="display: none;">
			</form>
			<form id="musiclistForm" action="" method="post" style="display: none;">
			<input type="hidden" name="email" id="email" value="<%=dto.getEmail()%>">
				<div id="search_div"><div onclick="musiclistForm();" style="width: 70px;">노래 찾기</div></div>
				<table id="music_table">
					<thead>
						<tr>
							<th>가수명</th>
							<th>노래명</th>
							<th>재생시간</th>
							<th>앨범명</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty jukelist }">
								<tr>
									<td colspan="5" align="center">구매한 노래 목록이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${jukelist }" var="list">
									<tr>
										<td>${list.singer }</td>
										<td>${list.musictitle }</td>
										<td>${list.runtime }</td>
										<td colspan="2">${list.musicalbum }</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</form>
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
		<div>home</div>
		<div onclick="location.href='gallery.do'">gallery</div>
		<div>diary</div>
		<div onclick="location.href='jukebox.do?email=<%=dto.getEmail()%>'">jukebox</div>
		<div>profile</div>
		<div>chat</div>
	</div>
	<!--webtabs end(desktop only)-->

	<div id="right_sidebar">
		<div id="to_home">메인홈으로</div>
		<div id="graph">그래프표시영역</div>
		<div id="audio">
			<audio id="musicplayer" autoplay="autoplay" controls controlsList="nodownload">
				<source src="" type="audio/mpeg" >
				Your browser does not support the audio tag.
			</audio>
		</div>
		<div id="audio_list">
			<table>
				<c:choose>
					<c:when test="${empty background }">
						<tr>
							<td align="center">- 선택된 배경음악이 없습니다 -</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${background }" var="back">
							<tr>
								<td class="musictitle"><a onclick="musiclistForm();">${back.musictitle}</a></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
		<div id="tracks" style="display: none;">
			<input type="hidden" id="firstSong" value="">
			<input type="hidden" id="songindex" value="">
			<input type="hidden" id="repeat" value="">
		</div>
	</div>

</body>
</html>