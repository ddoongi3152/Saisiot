<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 인증 코드 발송</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="resources/js/mail_send.js"></script>
<body>
		<table border="1">
			<tr>
				<td>
					<input type="text" id="yourmail"/>
					<input type="button" value="이메일 중복 체크" onclick="mailchk();"/>
					<input type="hidden" readonly="readonly" id="randomcode"/>
					<br>
					<input type="text" id="numberchk"/>
					<input type="button" value="인증코드 확인" onclick="numberchk();"/>
				</td>
			</tr>			
		</table>


</body>
</html>