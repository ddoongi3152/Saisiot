<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" src="resources/js/emailpw_find.js"></script>
<body>

		<table>
			<tr>
				<th>MAIL을 입력해주세요</th>
				<td><input type="text" id="mail"/> </td>
			</tr>
			<tr>
				<td>
					<input type="button" value="입력" onclick="find();"/>	
				</td>
			</tr>
			<tr>
				<td>
					<span id="yourinformation"></span>
				</td>
			</tr>
		</table>
		
		
</body>
</html>