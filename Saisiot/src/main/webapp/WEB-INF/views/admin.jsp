<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%
	response.setHeader("Pragma", "no-chche");
	response.setHeader("Cache-control", "no-store");
	response.setHeader("Expries", "0");
	/* 데이터가 변경되었을 떄, 이전 내용을 화면에 보여주는 이유 -> 서버의 값이  아닌 캐시에 저장된 내용을 가져오기 때문
	
	브라우저가 캐시에 응답결과를 저장하지 않도록 설
	response.setHeader("Pragma", "no-chche");			// http 1.0
	response.setHeader("Cache-control", "no-store");	// http 1.1
	response.setHeader("Expries", "0");					// proxy server	
	 */ 
%>
<meta charset="UTF-8">
<title>관리자 페이지 입니다.</title>
<%
	String whos = (String)session.getAttribute("whos");
	UserinfoDto dto;
	if(whos.equals("mine")){
		dto = (UserinfoDto)session.getAttribute("login");
	}else{
		dto = (UserinfoDto)session.getAttribute("others");
	}
%>
</head>
<body>
<div align="center">
	<h1>회원 리스트</h1>
	<table border="1">
		<col width="150" />	
		<col width="100" />
		<col width="800" />
		<col width="300" />
		<col width="100" />
		<col width="100" />
		<col width="100" />		
		
		<tr>
			<th>EAMIL</th>
			<th>USERNAME</th>
			<th>ADDR</th>
			<th>VISITDATE</th>
			<th>유저 상태</th>
			<th>이용정지</th>
			<th>유저복귀</th>
		</tr>
		
		<c:choose>
			<c:when test="${empty list }">
				<tr>
					<td colspan="7">*****회원정보가 없습니다*****</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${list }" var="dto">
					<tr>	
						<td align="center">${dto.email }</td>
						<td align="center">${dto.username }</td>
						<td align="center">${dto.addr }</td>
						<td align="center">${dto.visitdate}</td>
						<c:choose>
							<c:when test="${dto.usercondition == 0 }">
							<td align="center">관리자</td>
							</c:when>
							<c:when test="${dto.usercondition == 1 }">
							<td align="center">일반 유저</td>
							</c:when>
							<c:when test="${dto.usercondition == 2 }">
							<td align="center">휴면 계정</td>
							</c:when>
							<c:when test="${dto.usercondition == 3 }">
							<td align="center">이용 정지</td>
							</c:when>							
						</c:choose>
						<c:choose>
							<c:when test="${dto.usercondition == 0 }">
								<td colspan="2" align="center">관리자 입니다.</td>
							</c:when>
							<c:otherwise>
								<td align="center"><a href="userstop.do?email=${dto.email }">이용 정지</a></td>
								<td align="center"><a href="usercome.do?email=${dto.email }">복귀</a></td>	
							</c:otherwise>
						</c:choose>			
					</tr>				
				</c:forEach>			
			</c:otherwise>		
		</c:choose>
			<tr>
				<td colspan="5" align="center">
				<input type="button" value="로그아웃" onclick="location.href='logout.do'" />
				<input type="button" value="메인으로" onclick="location.href='homepage.do'" />
				</td>
			</tr>
	</table>
</div>
</body>
</html>