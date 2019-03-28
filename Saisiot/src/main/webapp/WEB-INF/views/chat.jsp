<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="<c:url value="resources/js/jquery-3.3.1.js"/>"></script>
<script type="text/javascript" src="<c:url value="resources/js/sockjs-0.3.4.js"/>"></script>
<script type="text/javascript">
<%
	UserinfoDto dto = (UserinfoDto)session.getAttribute("login");
%>

	var sock;
    //웸소켓을 지정한 url로 연결한다.
    sock = new SockJS("<c:url value="/echo"/>");
    //자바스크립트 안에 function을 집어넣을 수 있음.
    //데이터가 나한테 전달되읐을 때 자동으로 실행되는 function
    sock.onmessage = onMessage;
    //데이터를 끊고싶을때 실행하는 메소드
    sock.onclose = onClose; 
    
    function sendMessage() {
        /*소켓으로 보내겠다.  */
        sock.send(JSON.stringify({
        	  id: "<%=dto.getEmail()%>",
        	  text: $(".input-text").text()
        }));
        $(".input-text").text("");
    }
    //evt 파라미터는 웹소켓을 보내준 데이터다.(자동으로 들어옴)
    function onMessage(evt) {
        var data = evt.data;
        var jsonobj = JSON.parse(data);
        if(jsonobj.id == "<%=dto.getEmail()%>"){
        	$("#chatground").append("<div class='chat_me'><div class='chatbox'>"+jsonobj.text+"</div></div>");
        }else {
        	$("#chatground").append("<div class='chat_you'><div class='chatbox'>"+jsonobj.text+"</div></div>");
		}
        
    }

    function onClose(evt) {
    	alert("웹소켓 연결끊김");
        $("#chatground").append("연결 끊김");
    }
	$(window).resize(function(){
		if ($(window).width() > 769) {
			  $("#chat_list_div").show()
		}else {
			$("#chat_list_div").hide()
		}
	})
	
	$(document).on('keypress',function(e) {
	    if(e.which == 13) {
	    	sendMessage();
	    }
	});
	
	$(document).ready(function(){
		$(".input-submit").click(function() {
			if($(".input-submit").text!=""){
				sendMessage();
			}
        });

	  $("#chat_list_drop").click(function(){
	    $("#chat_list_div").toggle()
	  });
	  
	  $("#chat_list_div>ul").click(function(){
		  
	  })
	});
	 

	    
</script>
<link rel="stylesheet" href="resources/css/chat_web.css">
<link rel="stylesheet" href="resources/css/chat_mob.css">
<title>Insert title here</title>
</head>
<body>

	<div id="left_wrapper1">
	<div id="left_wrapper2">
	<div id="left_wrapper3">
	<div id="left_wrapper4">
		<div id="left_wrapper5_1">today | total</div>
		<div id="left_wrapper5_2">
		<div id="left_wrapper6">
			<div id="mob_top">사이좋은 사람들 사이시옷</div>
			<div id="tmpdiv">|프로필|다이어리|갤러리|쥬크박스|</div>
			<div id="chat_list_drop" checked="true">채팅목록보기</div>
			<div id="chat_list_div">
				<ul>
					<li><img src="resources/img/folder_icon.png"><a>친구목록</a></li>
					<c:forEach items="${friendList }" var="dtos">
					<li><a>${dtos.username}</a></li>
					</c:forEach>
					<li><a>순서변경</a></li>
				</ul>
			</div>

		</div>
		</div>
		<!-- left_wrapper5 end -->
	</div>
	<!-- left_wrapper4 end(white box) -->
	</div>
	<!-- left_wrapper3 end(gray box) -->
	</div>
	<!-- left_wrapper2 end(dashed box) -->
	</div>
	<!-- left_wrapper1 end(blue box) -->


	<div id="right_wrapper1">
	<div id="right_wrapper2">
	<div id="right_wrapper3">
	<div id="right_wrapper4">
		<div id="right_wrapper4_1">사이좋은 사람들 사이시옷</div>

		<!-- right_wrapper4_2: right contentbox start -->
			<div id="right_wrapper4_2">
				<div id="chattitle">천유정</div>
				<div id="chatground">
					<div class="chat_me"><div class="chatbox">너 어디로 나갈 예정?</div></div>
					<div class="chat_you"><div class="chatbox">집으로 갈 예정..</div></div>

				</div>
				<div class="inputwrapper">
					<div class="input-text" contentEditable="true"></div>
					<div class="input-submit">작성</div>
				</div>
			</div>
		</div>
		<!-- right_wrapper4_2 end -->
	</div>
	<!-- right_wrapper4 end(white box) -->
	</div>
	<!-- right_wrapper3 end(gray box) -->
	</div>
	<!-- right_wrapper2 end(dashed box) -->
	</div>
	<!-- right_wrapper1 end(blue box) -->


	<!-- -webtabs start(desktop only) -->
	<div id="web_tabs">
		<div>home</div>
		<div>gallery</div>
		<div>diary</div>
		<div>jukebox</div>
		<div>profile</div>
		<div>chat</div>
	</div>
	<!--webtabs end(desktop only)-->


	<div id="right_sidebar">
		<div id="to_home">메인홈으로</div>
		<div id="graph">그래프표시영역</div>
		<div id="audio">
			<audio controls controlsList="nodownload" loop>
			  <source src="test.mp3" type="audio/mpeg">
			  Your browser does not support the audio tag.
			</audio>
		</div>
		<div id="audio_list">
			<table>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
			</table>
		</div>
	</div>

</body>
</html>
