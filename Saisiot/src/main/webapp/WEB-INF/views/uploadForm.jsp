<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- request -->
	<form:form method="post" enctype="multipart/form-data" modelAttribute="uploadFile" action="upload.do">
		<h1>업로드 할 파일 선택</h1>
		파일 : <input type="file" name="file"/><br/>
		<p style="color:red;font-weight:bold;">
			<form:errors path="file"/>
		</p>
		설명 : <br/>
		<textarea rows="10" cols="60" name="desc"></textarea>
		<input type="submit" value="전송">
	</form:form>
	
<!-- 
 form tag의 enctype 속성
 1. application/www-form-urlencoded : (default) 문자(form안에 존재하는)들이 encoding 됨
 2. multipart/form-data : file upload가능 (post)
 3. text/plain : encoding 하지 않음 
 -->	

<!-- 
 form:-> spring이 지원하는 form태그
 form:form, form:input...
 form:errors -> Errors, BindingResult 를 사용할 때
                command객체의 특정 field 에서 발생하는 에러 메세지를 출력 가능 


 -->

</body>
</html>





















