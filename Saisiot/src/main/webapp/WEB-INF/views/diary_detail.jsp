<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>게시글 상세보기</h1>
	
	<table>
		<tr>
			<th>제	목</th>
			<td>${dto.title }</td>
			<th>작성일</th>
			<td>${dto.regdate }</td>
			<th>조회수</th>
			<td>${dto.viewtime }</td>
		</tr>
		<tr>
			<th>내	용</th>
			<td>${dto.content }</td>
		</tr>
		<tr>
			<td>
			<input type="hidden" value="${dto.diaryno }"/>
			<input type="hidden" value="${dto.folderno }"/>
			<input type="file" value="${dto.fileurl }"/>
			<input type="hidden" value="${dto.picurl }"/>
			<input type="hidden" value="${dto.maplati }"/>
			<input type="hidden" value="${dto.maplong }"/>
			<input type="hidden" value="${dto.videourl }"/>
			</td>
		</tr>
	</table>

</body>
</html>