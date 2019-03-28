<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
		UserinfoDto dto = (UserinfoDto)session.getAttribute("login");
%>
	
	<table>
		<tr align="center">
			<td colspan="2"><a style="font-size: 11px">저장할 폴더를 선택해주세요.</a></td>
		</tr>
		<tr align="center">
			<td>
				<select>
					<option></option>
				</select>
			</td>
			<td><input type="button" value="선택"></td>
		</tr>
	</table>

</body>
</html>