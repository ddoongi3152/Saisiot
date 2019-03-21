<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="resources/js/canvas.js"></script>
<script type="text/javascript">

	$(window).resize(function(){
		if ($(window).width() > 769) {
		  $("#right_wrapper4_2").append($("#gallery"))
		}else {
			$("#gallery_out").append($("#gallery"))
		}
	})
	$(document).ready(function(){
		if ($(window).width() > 769) {
			$("#right_wrapper4_2").append($("#gallery"))
		}else {
			$("#gallery_out").append($("#gallery"))
		}
	  $("#folder_list_drop").click(function(){
	    $("#folder_list_div").toggle()
	  });
	});


</script>
<link rel="stylesheet" href="resources/css/gallery_web.css">
<link rel="stylesheet" href="resources/css/gallery_mob.css">
<title>Insert title here</title>
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
			<div id="gallery_out"></div>
			<div id="gallery_toolbox">
				<div class="color">
					<div id="red"></div>
					<div id="orange"></div>
					<div id="yellow"></div>
					<div id="blue"></div>
					<div id="green"></div>
					<div id="black"></div>
				</div>
				<div class="settings">
					<div id="color_input"><input type="color" id="selectColor" onchange="selectWidth()"/></div>
					<div id="line_input"><input type="range" min="1" max="30" value="5"/></div>
				</div>
				<div class="tools">
					<div id="pen"><div><a class = "pen" onclick="changeMode(0)" style="display: none;">pen</a></div></div>
					<div id="line"><div><a class = "line" onclick="changeMode(1)" style="display: none;">line</a></div></div>
					<div id="rect"><div><a class="rect" onclick="changeMode(2)" style="display: none;">rect</a></div></div>
					<div id="circ"><div><a class = "circ" onclick="changeMode(3)" style="display: none;">circ</a></div></div>
				</div>
				<div class="btns">
					<div><input type="file" id="img" accept="image/*" onchange="selectImg(this);" placeholder="배경이미지"></div>
					<div onclick="clearCanvas()">새로그리기</div>
				</div>
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
			<div id="gallery">
			<form action="Canvas.do" method="post">
			 	<input type="hidden" name="command" value="insert_canvas">
 				<input type="hidden" id="path" name="path" value="">
				<div id="gallery_title"><input placeholder="title" type="text"/></div>
				<div><canvas id = "canvas" style = "border: 1px solid #b6b6b6;border-radius: 5px; width: 100%; height: 100%; "></canvas></div>
				<div id="gallery_content"><textarea placeholder="content"></textarea></div>
				<div id="gallery_btn">
					<div onclick="save()">save image</div><div>to diary</div>
				</div>
				<div id="showmode" style="display: none;"> mode : <span id="mode"></span></div>
				<img id="fileImage" style="display: none;">
				<img id="myImage" style="display: none">
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
		<div>gallery</div>
		<div>diary</div>
		<div>jukebox</div>
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
								<td class="musictitle"><a>${back.musictitle}</a></td>
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
