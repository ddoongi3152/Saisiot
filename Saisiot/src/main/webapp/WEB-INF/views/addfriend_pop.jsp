<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<c:url value="resources/js/jquery-3.3.1.js"/>"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#search").click(function() {
			var searchEmail = $("#search_email").text();
    	 $.ajax({	
				type:"POST",
				url:"findfriend.do",
				data:"email="+searchEmail,
				success:function(data){
					//alert("로그인 성공");
					
					if(data=="1"){
						location.href='homepage.do';
					}else if(data=="2"){
						location.href='condition.do';
					}			
				},
				error:function(){
					alert("로그인실패");
				}

			})
		});
	});

</script>
</head>
<body>

	<label>친구 검색 : 이메일 주소를 입력하세요</label>
	<input id="search_email" type="text"/><button id="search">검색</button>
	<div id="search_res"></div>
	<div></div>
	<button onclick="location.href='profile.do'">친구추가</button>
</body>
</html>