<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<script type="text/javascript">
		function window_close(){
			window.close();
		}
		
		function folder_update(folderno){
			var foldername = document.getElementById('foldername').value;
		    opener.window.location.href='folder_update.do?folderno='+folderno+'&foldername='+foldername;
		    self.close();
		}
	</script>
<body>

	<p>폴더명 바꾸기</p>
	<input type="text" id="foldername" />
	<br/>
	<input type="button" value="변경" onclick="folder_update(${folderno});"  />
	<input type="button" value="취소" onclick="window_close();"/>

</body>
</html>