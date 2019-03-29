<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴면계정입니다.</title>
<%
	UserinfoDto dto = (UserinfoDto)session.getAttribute("login");

	if(dto == null){
		response.sendRedirect("login.do");
	}
%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript">

	 function conditionupdate() {
		
		var password = document.getElementById("password").value;
		
		if(password == null || password == ""){
			alert("변경하실 비밀번호를 입력해주세요");
		}else{
			
			$.ajax({
				
				type:"POST",
				data:"email="+"<%=dto.getEmail()%>"+"&password="+password,
				url:"usercondtionupdate.do",
				success:function(data){
					alert("비밀번호가 변경되었습니다.");
					location.href="homepage.do";
				},
				error:function(){
					alert("비밀번호 변경 실패");
					location.href="logout.do";
				}
				
				
				
			})	
			
		}
	}
</script>

</head>

<%
	if(!dto.getPassword().equals("kakaouser") && !dto.getPassword().equals("naveruser")){
%>

<body>
	<h1><%=dto.getUsername() %>님의 계정은 휴면상태입니다.</h1>
	<h2>비밀번호를 변경하세요!</h2>
	
	<table border="1">
		<tr>
			<th>회원님의 EMAIL</th>
			<td><input type="text" value="<%=dto.getEmail() %>" readonly="readonly"> </td>
		</tr>
		<tr>
			<th>변경하실 비밀번호</th>
			<td><input type="password" id="password"> </td>
		</tr>
		<tr>
			<td align="center"><input type="button" value="비밀번호 변경" onclick="conditionupdate();"> </td>
			<td align="center"><input type="button" value="돌아가기" onclick="location.href='logout.do'"> </td>
		</tr>
	</table>
<%
	}else{
%>	
	<h1><%=dto.getUsername() %>님의 계정은 휴면상태입니다.</h1>
	<div><a href="snscomback.do?email=<%=dto.getEmail()%>">당신은 소셜로그인 이용자네요!&nbsp;휴면계정 해제하려면 누르세요</a></div>
	<div><a href="logout.do">돌아가기</a></div>
<%
	}
%>
</body>
</html>