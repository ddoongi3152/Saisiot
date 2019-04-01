<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>폴더 추가</title>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.js" />" ></script>
<script type="text/javascript">
	function window_close(){
		window.close();
	}
	
	function closeWithSubmit(){
		var f= document.forms.folder_frm;
	    opener.name = "openerNames";
	    f.target = opener.name;
	    f.submit();
	    self.close();
	}


</script>
</head>
<%
	UserinfoDto dto = (UserinfoDto)session.getAttribute("login");
%>

<body>

	<p>생성할 폴더 명</p>
	<form:form action="folder_insert.do" method="post" name="folder_frm" modelAttribute="DiaryRootDto" >
	<input type="text" name="foldername" id="foldername"></input>
	<br/>
	<input type="hidden" value="<%=dto.getEmail()%>" name="email"/>
	<input type="button" onclick="closeWithSubmit();" value="만들기"/>
	</form:form>
	<input type="button" value="취   소" onclick="window_close();"/>
</body>
</html>