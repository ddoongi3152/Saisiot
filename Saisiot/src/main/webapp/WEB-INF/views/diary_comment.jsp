<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function listReply(num){
	$.ajax({
		type: "get",
		url: "${path}//mvc03/diary_comment_list.do?bno=${dto.bno}&curPage="+num,
		success: function(result){
		// responseText가 result에 저장됨.
			$("#listReply").html(result);
		}
	});
}
</script>
</head>
<body>
			<!-- 댓글 작성 영역 -->	
			<div style="width:650px; text-align: center;">
				<br>
				<!-- 로그인 한 회원에게만 댓글 작성폼이 보이게 처리 -->
				<%-- <c:if test="${sessionScope.userId != null}"> --%>	
					<textarea rows="5" cols="80" id="replytext" placeholder="댓글을 작성해주세요"></textarea>
					<br>
					<!-- 비밀댓글 체크박스 -->
					<input type="checkbox" id="secretReply">비밀 댓글
					<button type="button" id="btnReply">댓글 작성</button>
				<%-- </c:if> --%>
			</div>
			<!-- 댓글 작성 영역 -->
</body>
</html>