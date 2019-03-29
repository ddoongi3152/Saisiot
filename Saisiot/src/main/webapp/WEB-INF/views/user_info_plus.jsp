<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 추가 정보</title>
</head>
<script type="text/javascript">
	function addr_popup(){
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	    var pop = window.open("addr_popup.do","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	    
		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
	    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 	
	}
	
	function gendercheckbox(chk){
		
		var check = document.getElementsByName("gender");
		
			if(check[0]==chk){
				check[1].checked = false;
			}else if(check[1]==chk){
				check[0].checked = false;
			}	
			
	}
	
	function notnull() {
		
		if(document.getElementById("gender").value==null){
			alert("성별을 입력해주세요");
			return false;
		}
		if(document.getElementById("gender").value==""){
			alert("성별을 입력해주세요");
			return false;
		}
		if(document.getElementById("addr").value==null){
			alert("주소를 입력해주세요");
			return false;
		}
		if(document.getElementById("addr").value==""){
			alert("주소를 입력해주세요");
			return false;
		}
		return true;
	}
</script>
<%
	UserinfoDto dto = (UserinfoDto)session.getAttribute("login");
	String whos = (String)session.getAttribute("whos");
%>

<body>
	<div align="center">
	<h1>추가정보가 필요합니다. </h1>
		<form action="info_plus.do" method="post" onsubmit="return notnull();">
		<label>회원님의 EMAIL</label>
		<input type="text" name="email" readonly="readonly" value="<%=dto.getEmail()%>"/>
		<label>성별</label>
		<input type="checkbox" id="gender" class="checkbox" name="gender" value="M" onclick="gendercheckbox(this);"/><label>남</label>
		<input type="checkbox" id="gender" class="checkbox" name="gender" value="W" onclick="gendercheckbox(this);"/><label>여</label>
		<label>주소</label>
		<input type="text" id="addr" name="addr" readonly="readonly" onclick="addr_popup();"/>
		<input type="submit" value="추가정보 입력"/>
		<input type="button" value="돌아가기" onclick="location.href='delete.do?email=<%=dto.getEmail()%>'"/>
		</form>
	</div>
</body>
</html>