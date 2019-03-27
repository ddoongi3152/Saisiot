<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	function callbackVideoUrl(){
		var selectvideo = $("#selectvideo").val();
		var selectvideo_url = selectvideo.substring(32,43);
		var selectvideo_res = "https://www.youtube.com/embed/"+selectvideo_url;
		
		opener.videoCallBack(selectvideo_res);
		 
		window.close();
	}
</script>
</head>
<body>

	<input type="text" id="selectvideo" name="selectvideo"/>
	<input type="button" value="추가하기" onclick="callbackVideoUrl();"/>

</body>
</html>