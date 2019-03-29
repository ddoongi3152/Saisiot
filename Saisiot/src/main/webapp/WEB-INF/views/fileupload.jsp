<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript"> 
function readURL(input) { 
	if (input.files && input.files[0]) { 
		var reader = new FileReader(); reader.onload = function (e) 
		{ $('#blah').attr('src', e.target.result); } 
		reader.readAsDataURL(input.files[0]); } } 
		</script>

</head>
<body>

<form:form method="post" enctype="multipart/form-data" modelAttribute="uploadFile" action="upload.do">
	<h1>업로드 할 파일 선택</h1>
		파일 : <input type="file" name="file" onchange="readURL(this);"/><br/>
		<p style="color:red;font-weight:bold;">
			<form:errors path="file"/>
		</p>
		<img id="blah" src="#" alt="your image" />
		<input type="submit" value="전송">
</form:form>

</body>
</html>