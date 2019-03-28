<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%
	response.setHeader("Pragma", "no-chche");
	response.setHeader("Cache-control", "no-store");
	response.setHeader("Expries", "0");
	/* 데이터가 변경되었을 떄, 이전 내용을 화면에 보여주는 이유 -> 서버의 값이  아닌 캐시에 저장된 내용을 가져오기 때문
	
	브라우저가 캐시에 응답결과를 저장하지 않도록 설
	response.setHeader("Pragma", "no-chche");			// http 1.0
	response.setHeader("Cache-control", "no-store");	// http 1.1
	response.setHeader("Expries", "0");					// proxy server	
	 */ 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src='https://www.google.com/recaptcha/api.js'></script>
<script type="text/javascript" src="resources/js/login.js"></script>
<link rel="stylesheet" href="resources/css/login_web.css">
<link rel="stylesheet" href="resources/css/login_mob.css">
</head>
<body>

	<div id="left_wrapper1">
	<div id="left_wrapper2">
	<div id="left_wrapper3">
	<div id="left_wrapper4">
		<div id="left_wrapper5_1">
			로그인
			<div id="left_wrapper6_1" align="center">
				<form action="logingo.do" method="post" onsubmit="return loginchk();">
					<label>EMAIL</label>
						<input type="text" id="email" name="email" placeholder="이메일을 입력해주세요">
					<label>PASSWORD</label>
						<input type="password" id="pw" name="pw" placeholder="비밀번호를 입력해주세요">
					<!-- <div id="login_apis"> -->
					
				
						<div align="center"><a id="custom-login-btn" href="javascript:loginWithKakao()"><img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/></a></div>
						
				
						<div id="naver_id_login" align="center"></div>
						<script type="text/javascript">
						var naver_id_login = new naver_id_login("FyagxD4aXpcrDC2Hvgos", "http://localhost:8787/mvc03/callback.do");
					  	var state = naver_id_login.getUniqState();
					  	naver_id_login.setButton("green", 60,50);
					  	naver_id_login.setDomain("http://localhost:8787/mvc03/");
					  	naver_id_login.setState(state);
					  	naver_id_login.setPopup();
					  	naver_id_login.init_naver_id_login();	
						</script>
					
						<div align="center"><input type="submit" class="btn" value="로그인"/>&nbsp;<input type="button" class="btn" value="EMAIL/PW찾기" onclick="emailpwFind();"/> </div>
				
				</form>
			</div>
		</div>
		<div id="left_wrapper5_2">
			회원가입
			<div id="left_wrapper6_2" align="center">
				<form action="userinsert.do" method="post" name="userinfo" onsubmit="return notnull();">
					<label>EMAIL</label>
						<input type="text" id="insertemail" name="email" placeholder="이메일을 입력해주세요" readonly="readonly" onclick="mailcon();"/>					
					<label>PASSWORD</label>			
						<input type="password" id="insertpassword" name="password" placeholder="비밀번호를 입력해주세요" onchange="pwchk();">
						<span id="same01"></span>
					<label>PASSCHECK</label>
						<input type="password" id="insertpasswordchk" placeholder="비밀번호를 다시 입력해주세요" onchange="pwchk();">
						<span id="same02"></span>
					<label>GENDER</label>		
						<div>
							<input type="checkbox" class="checkbox" name="gender" value="M" onclick="gendercheckbox(this);"><label>남</label><input type="checkbox" class="checkbox" name="gender" value="W" onclick="gendercheckbox(this);"><label>여</label>
						</div>
					<label>BIRTHDAY</label>	
						<input type="date" id="birthdate" name="birthdate" placeholder="생년월일을 입력해주세요" />
					<label>NAME</label>
						<input type="text" id="insertname" name="username" placeholder="이름을 입력해주세요">
					<label>ADDRESS</label>	
						<input type="text" id="insertaddress" name="addr" placeholder="주소를 입력해주세요" readonly="readonly" onclick="goPopup();">
						<input type="hidden" id="recaptcha_chk">
						<div><input type="submit" class="btn" id="recaptcha_btn" value="가입"></div>							
				</form>
					<div class="g-recaptcha" data-sitekey="6LfiDJcUAAAAADcFYZpJvash2bUuQrFwky-zgQwx" >
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
		<!-- right_wrapper4_2: right contentbox start -->
			<div id="right_wrapper4_2">
				<img alt="임시이미지" src="resources/img/99E7B933599BF9DD16.jpg">
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

</body>
</html>