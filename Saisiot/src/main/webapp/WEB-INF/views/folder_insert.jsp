<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>폴더 추가</title>
<script type="text/javascript">
	function window_close(){
		window.close();
	}
</script>
</head>
<body>

	<p>생성할 폴더 명</p>
	<input type="text" name="foldername" id="foldername"></input>
	<br/>
	<input type="button" value="만들기" onclick="location.href='folder_insert.do'"/>
	<input type="button" value="취   소" onclick="window_close();"/>
</body>
</html>