<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>폴더 삭제</title>
</head>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.js" />" ></script>
<script type="text/javascript">
	function window_close(){
		window.close();
	}
	
	function folder_delete(folderno){
	    opener.window.location.href='folder_delete.do?folderno='+folderno;
	    self.close();
	}


</script>
<body>
	
	<p>정말 삭제 하시겠습니까?</p>
	<input type="button" value="삭제" onclick="folder_delete(${folderno});"  />
	<input type="button" value="취소" onclick="window_close();"/>
</body>
</html>