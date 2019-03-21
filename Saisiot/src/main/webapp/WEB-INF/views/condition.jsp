/<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴면계정입니다.</title>
<script type="text/javascript">

	function conditionupdate() {
		
		var password = document.getElementById("password").value;
		
		if(password == null || password == ""){
			alert("변경하실 비밀번호를 입력해주세요");
		}
	}

</script>

</head>
<%
	UserinfoDto dto = (UserinfoDto)session.getAttribute("login");
%>
<body>
	<h1><%=dto.getUsername() %>님의 계정은 휴면상태입니다.</h1>
	<h2>비밀번호를 변경하세요!</h2>
	
	<table>
		<tr>
			<th>회원님의 EMAIL</th>
			<td><input type="text" value="<%=dto.getEmail() %>" readonly="readonly"> </td>
		</tr>
		<tr>
			<th>변경하실 비밀번호</th>
			<td><input type="text" id="password"> </td>
		</tr>
		<tr>
			<td><input type="button" value="비밀번호 변경" onclick="conditionupdate();"> </td>
		</tr>
		<tr>
			<td><input type="button" value="돌아가기" onclick="location.href='logout.do'"> </td>
		</tr>
	</table>
	
</body>
</html>