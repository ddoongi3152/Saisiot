<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="<c:url value="resources/js/jquery-3.3.1.js"/>"></script>
<script src="resources/js/bgm.js?ver=4"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#add_friend").click(function() {
			window.open("addfriendpop.do", "친구찾기", "width=500,height=300");
		});
		//개인정보 수정 버튼 클릭
		$("#personal_func").click(function() {
			$("#update_personal").submit();
		})
		//비밀번호 변경 클릭
		$("#pw_ok").click(function() {
			var pw = $("#updatepw").val();
			var name = $("input[name=username]").val();
			var email = $("input[name=email]").val();
			if(pwchk(pw, name)){
				$("#pw_change").show();
				$("#updatepw").hide();
				$("#pw_ok").hide();
				location.href="update_pw.do?email="+email+"&pw="+pw+"&name="+name;
			}else{
				alert("비밀번호를 6자리 이상 입력하셔야 합니다.\n회원님의 이름이 지워졌는지 확인해주세요.");
				return false;
			}
		})
	});
	
	function reset(){
		location.href="profile.do";
	}
	//비밀번호 태그 변경 func
	function update_pw() {
		$("#pw_change").hide();
		$("#updatepw").show();
		$("#pw_ok").show();
	}
	//비밀번호 수, name 유효성 검사
	function pwchk(pw, name) {
		if(pw.length < 6 || name == null || name == ""){
			return false;
		}else{
			return true;
		}
	}
</script>
<link rel="stylesheet" href="resources/css/profile_web.css">
<link rel="stylesheet" href="resources/css/profile_mob.css">
<title>Insert title here</title>
</head>
<body>
<%
	UserinfoDto dto = (UserinfoDto)session.getAttribute("login");
	SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
	String birth = dateformat.format(dto.getBirthdate());
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
			<form id="update_personal" action="updatePersonal.do" method="post">
				<div id="personal_div">
					<input type="hidden" name="email" value="<%=dto.getEmail()%>">
					<div><label>도토리</label><label><%=dto.getCoinno() %></label><div>충전</div></div>
					<div><label>비밀번호</label><div id="pw_change" onclick="update_pw()">변경하기</div>
						<input type="password" id="updatepw" style="width: 100px; display: none"><div id="pw_ok" style="display: none">확인</div>
					</div>
					<div><label>이름</label><input type="text" name="username" value="<%=dto.getUsername() %>"></div>
					<div><label>생일</label><input type="date" name="birthdate" value="<%=birth %>"></div>
					<div><label>성별</label><input type="text" name="gender" value="<%=dto.getGender() %>"></div>
					<div><label>주소</label><textarea name="addr"><%=dto.getAddr() %></textarea></div>
				</div>
			<div id="personal_ok_btn"><div id="personal_func">수정완료</div></div>
			</form>
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
		<div onclick="location.href='homepage.do'">home</div>
		<div onclick="location.href='gallery.do'">gallery</div>
		<div><a href="diary.do">diary</a></div>
		<div onclick="location.href='jukebox.do?email=<%=dto.getEmail()%>'">jukebox</div>
		<div style="display:<%=(!session.getAttribute("whos").equals("mine"))?"none":""%>" onclick="location.href='profile.do'">profile</div>
		<div onclick="location.href='chat.do'">chat</div>
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
