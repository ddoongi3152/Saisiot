<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/email_pw_find.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" src="resources/js/emailpw_find.js"></script>
</head>
<body>
		
		<div>
			<div align="center" id="find" class="container">
				<label>비밀번호 찾기</label>
				<input type="text" id="mail" placeholder="메일을 입력해주세요"/>
				<button id="button" class="btn" onclick="find();">입력</button>		
				<span id="yourinformation"></span>
			</div>
		</div>
</body>
</html>