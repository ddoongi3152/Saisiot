<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<%@page import="com.saisiot.diary.biz.*"%>
<%@page import="com.saisiot.diary.dto.DiaryRootDto"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#choosefolder").click(function() {
			var folderno = $("#selectfolder option:selected").val();
			if(folderno==null||folderno==-1){
				alert("다이어리에 생성된 폴더가 있어야 합니다.\n폴더를 생성해주세요.");
				opener.godiary();
			}else{
				opener.addValue(folderno);
			}
			window.close();
		})
	})
</script>
<title>Insert title here</title>
</head>
<body>
<%
		UserinfoDto dto = (UserinfoDto)session.getAttribute("login");
%>
	
	<table style="text-align: center;margin-left: auto; margin-right: auto; vertical-align: middle;">
		<tr style="height: 20px;">
		</tr>
		<tr align="center">
			<td colspan="2"><a style="font-size: 12px">저장할 폴더를 선택해주세요.</a></td>
		</tr>
		<tr align="center">
			<td>
				<select id="selectfolder" style="width:150px; font-size: 12px">
					<c:choose>
						<c:when test="${empty folderList }">
							<option value="-1">생성된 폴더가 없습니다.</option>
						</c:when>
						<c:otherwise>
							 <c:forEach var="list" items="${folderList }">
                      			  <option value="${list.folderno}">${list.foldername }</option>
                    		 </c:forEach>
						</c:otherwise>
					</c:choose>
               </select>
			</td>
			<td><input type="button" id="choosefolder" value="선택" style="font-size: 12px"></td>
		</tr>
	</table>

</body>
</html>