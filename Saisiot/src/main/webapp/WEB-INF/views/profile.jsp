<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/profile_mob.css">
<link rel="stylesheet" href="resources/css/profile_web.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript">

	function update_p(){
		var email = $("#email").val();
		var p_picurl = $("#profile_pic").children().attr('src');
		var p_content = $("#profile_content").val();
		var p_title_bf = $("#p_title").val();
		var p_title_web = $("#p_title_web").val();
		var p_title_mob = $("#p_title_mob").val();
		
		if(p_title_web == p_title_mob){
			var p_title = p_title_web;
		}else{
			if(p_title_web != p_title_bf){
				var p_title = p_title_web;
			}else{
				var p_title = p_title_mob;
			}
		}
		location.href="updateprofile.do?p_picurl="+p_picurl+"&p_content="+p_content+"&p_title="+p_title+"&email="+email;
	}
	
</script>
</head>
<body>
<body>

	<div id="left_wrapper1">
	<div id="left_wrapper2">
	<div id="left_wrapper3">
	<div id="left_wrapper4">
		<div id="left_wrapper5_1">${todayCount} today | total  ${totalCount}</div>
		<div id="left_wrapper5_2">
		<div id="left_wrapper6">
			<div id="mob_top"><input type="text" id="p_title_mob" value="${pdto.p_title }"/></div>
			<div id="tmpdiv">|프로필|다이어리|갤러리|쥬크박스|</div>
			<div id="profile_title">프로필 수정</div>
			<div id="profile_pic"><img alt="profile_img" src=${pdto.p_picurl }></div>
			
			
			<form action="update_pic.do" method="post" enctype="multipart/form-data">
			<div id="profile_pic_edit"><input type="file" name="p_picurl">이미지 선택</div>
			<div id="profile_pic_edit"><input type="submit">이미지 저장</div>
			</form>
			
			<hr id="profile_hr1">
			<textarea id="profile_content">${pdto.p_content }</textarea>
			<div id="profile_edit" onclick="update_p()">수정완료</div>
			<hr id="profile_hr2">
			<div id="owner_name">${login.username }</div>
			<input type="hidden" id="email" value=${login.email }>
			<input type="hidden" id="p_title" value="${pdto.p_title }">

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
		<div id="right_wrapper4_1"><input type="text" id="p_title_web" value="${pdto.p_title }"/></div>

		<!-- right_wrapper4_2: right contentbox start -->
		<div id="right_wrapper4_2">
			<div class="div_title">개인정보관리</div>
			<div id="personal_div">
				<div><label>도토리</label><label>104</label><div>충전</div></div>
				<div><label>비밀번호</label><div>변경하기</div></div>
				<div><label>이름</label><input type="text"/></div>
				<div><label>생일</label><input type="text"/></div>
				<div><label>성별</label><input type="text"/></div>
				<div><label>주소</label><textarea></textarea></div>
			</div>
			<div id="personal_ok_btn"><div>수정완료</div></div>
			<div id="friend_title"><div class="div_title">친구관리</div><div id="add_friend">친구추가하기</div></div>
			<div id="friend_div">
				<div><label>천유정</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
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
</body>
</html>