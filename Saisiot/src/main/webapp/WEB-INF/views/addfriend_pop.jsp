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
	var searchEmail;
	$(document).ready(function(){
		$("#search").click(function() {
			
			searchEmail = $("#search_email").val();
			alert(searchEmail)
	    	 $.ajax({	
					type:"POST",
					url:"findfriend.do",
					data:"email="+searchEmail,
					success:function(data){
						$("#search_res>div").remove();
						$("#search_res").append('<div>'+data+'</div>');	
						searchEmail = $("#search_email").val();
					},
					error:function(){
						searchEmail = 0;
						alert("ajax실패");
					}
	
				})
		});
		
		$("#submit").click(function(){
			alert(searchEmail)
	    	 $.ajax({	
					type:"POST",
					url:"insertfriend.do",
					data:"email="+searchEmail,
					success:function(data){
						window.opener.reset();
						window.close();
					},
					error:function(){
						alert("ajax실패");
					}
	
				})
			
		})
	});

</script>
</head>
<body>

	<label>친구 검색 : 이메일 주소를 입력하세요</label>
	<input id="search_email" type="text"/><button id="search">검색</button>
	<div id="search_res"></div>
	<button id="submit">친구추가</button>
</body>
</html>