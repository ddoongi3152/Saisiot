<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="<c:url value="resources/js/jquery-3.3.1.js"/>"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#add_friend").click(function() {
			window.open("addfriendpop.do", "친구찾기", "width=500,height=300");
		});
	});

</script>
<link rel="stylesheet" href="resources/css/profile_web.css">
<link rel="stylesheet" href="resources/css/profile_mob.css">
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
			<div id="profile_title">프로필 수정</div>
			<div id="profile_pic"><img alt="profile_img" src="checkbox.PNG"></div>
			<div id="profile_pic_edit">사진변경하기</div>
			<hr id="profile_hr1">
			<textarea id="profile_content">
				인생.....★ 사이좋은 사람들 사이시옷
				인생.....★ 사이좋은 사람들 사이시옷
				인생.....★ 사이좋은 사람들 사이시옷
				인생.....★ 사이좋은 사람들 사이시옷
				인생.....★ 사이좋은 사람들 사이시옷
				인생.....★ 사이좋은 사람들 사이시옷
				인생.....★ 사이좋은 사람들 사이시옷
				인생.....★ 사이좋은 사람들 사이시옷
				인생.....★ 사이좋은 사람들 사이시옷
			</textarea>
			<div id="profile_edit">수정완료</div>
			<hr id="profile_hr2">
			<div id="owner_name">마루홍시(♪)</div>

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
			<div class="div_title">개인정보관리</div>
			<div id="personal_div">
				<div><label>도토리</label><label><%=dto.getCoinno() %></label><div>충전</div></div>
				<div><label>비밀번호</label><div>변경하기</div></div>
				<div><label>이름</label><input type="text"/ value="<%=dto.getUsername() %>"></div>
				<div><label>생일</label><input type="text"/ value="<%=dto.getBirthdate() %>"></div>
				<div><label>성별</label><input type="text"/ value="<%=dto.getGender() %>"></div>
				<div><label>주소</label><textarea><%=dto.getAddr() %></textarea></div>
			</div>
			<div id="personal_ok_btn"><div>수정완료</div></div>
			<div id="friend_title"><div class="div_title">친구관리</div><div id="add_friend">친구추가하기</div></div>
			<div id="friend_div">
				<c:forEach items="${friendList}" var="dtos">
					<div><label>${dtos.username }</label><div>x</div></div>
				</c:forEach>
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
			<audio controls controlsList="nodownload" loop>
			  <source src="test.mp3" type="audio/mpeg">
			  Your browser does not support the audio tag.
			</audio>
		</div>
		<div id="audio_list">
			<table>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
			</table>
		</div>
	</div>

</body>
</html>
