<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	파일명 : ${fileobj.filename }
	설  명 : ${fileobj.desc }
	
	<form action="download.do" method="post">
		<input type="hidden" name="filename" value="${fileobj.filename }"/>
		<input type="submit" value="DOWNLOAD"/>
	</form>

</body>
</html>