<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경해주세요</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	
	
	function passreset(){
		
		var email = document.getElementById("email").value;
		var password = document.getElementById("password").value;
		
		//alert(email);
		//alert(password);
		
		
		if(password =="123456789"){
			alert("사용할 수 없는 비밀번호 입니다.");
		}else{
		
		$.ajax({
			
			type:"POST",
			url:"passreset.do",
			data:"email="+email+"&password="+password,
			success: function(data){
				alert("비밀번호가 변경되었습니다. 다시 로그인 해주세요");
				location.href="login.do";
			},
			
			error: function(){
				alert("비밀번호 변경 실패");
				
			}
			
			
		})
		
		}
		
	}
	
</script>
</head>
<%
	UserinfoDto dto = (UserinfoDto)session.getAttribute("login");
%>
<body>
	
	<div>
		<label>비밀번호를 변경해 주세요</label>	
		<span>회원님의 EMAIL</span>
		<input type="text" id="email" name="email" readonly="readonly" value="<%=dto.getEmail()%>">
		<input type="password" id="password" name="password">
		<button onclick="passreset();" id="button">비밀번호 변경</button>	
	</div>
	
	
</body>
</html>