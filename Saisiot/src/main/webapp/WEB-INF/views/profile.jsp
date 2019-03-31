<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Locale" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/profile_mob.css">
<link rel="stylesheet" href="resources/css/profile_web.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<!-- d3 import 하기 -->
<script src="https://d3js.org/d3.v5.js"></script>
<script type="text/javascript">

	function update_p(){
		var email = $("#email").val();
		var p_picurl = $("#profile_pic").children().attr('src');
		var p_content = $("#profile_content").val();
		var p_title_bf = $("#p_title").val();
		var p_title_web = $("#p_title_web").val();
		var p_title_mob = $("#p_title_mob").val();
		
		if(p_title_web == p_title_mob){
			var p_title = p_title_web;
		}else{
			if(p_title_web != p_title_bf){
				var p_title = p_title_web;
			}else{
				var p_title = p_title_mob;
			}
		}
		location.href="updateprofile.do?p_picurl="+p_picurl+"&p_content="+p_content+"&p_title="+p_title+"&email="+email;
	}
	
	var g_oWindow = "";
	function charge_coin(){
	// 팝업창 종료시점 감지하기
		var g_oWindow = window.open("charge_coin.do", "도토리 충전소", "width=850, height=600, toolbar=no");
		pop_close();
	}
	
	function pop_close() {
	
	    // 0.5초 마다 감지
	    var g_oInterval = window.setInterval(function() {
	        try {
	        	var dotory_amount = $("#addcoin").val();
	        	if(dotory_amount != ""){
	                location.href="update_coin.do?dotory_amount="+dotory_amount;
	                clearInterval(g_oInterval);
	        	}
	        } catch (e) { }
	    }, 500);
	}
	
	function readURL(input) {
		alert(input);
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $('#image_section').attr('src', e.target.result);
	        }
	 
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	 

	 function change_pic(this_1){
		readURL(this_1);
	 }
	 
</script>
</head>
<body>
<body>
<%
//방문자수와 통계 그래프를 위한 코드 - 유정
//일주일간 방문자 통계 리스트
List<Object> week_visit_date = new ArrayList<Object>();
week_visit_date = (ArrayList) session.getAttribute("week_visit_date");

Object one_date_visit = week_visit_date.get(0);
Object two_date_visit = week_visit_date.get(1);
Object three_date_visit = week_visit_date.get(2);

//오늘 기준으로 3일전까지 날짜 설정
SimpleDateFormat formatter = new SimpleDateFormat("MM-dd");
Date today = new Date();
String today_date = formatter.format(today);
Date setDate = formatter.parse(today_date);
Calendar cal = new GregorianCalendar(Locale.KOREA);
cal.setTime(setDate);

String one_date = "";
String two_date = "";
String three_date = "";

for (int i = 1; i < 4; i++) {
	cal.add(Calendar.DATE, -1);
	String ago_date = formatter.format(cal.getTime());
	if (i == 1) {
		one_date = ago_date;
	} else if (i == 2) {
		two_date = ago_date;
	} else if (i == 3) {
		three_date = ago_date;
	}
}
%>	

	<div id="left_wrapper1">
	<div id="left_wrapper2">
	<div id="left_wrapper3">
	<div id="left_wrapper4">
		<div id="left_wrapper5_1">${todayCount} today | total  ${totalCount}</div>
		<div id="left_wrapper5_2">
		<div id="left_wrapper6">
			<div id="mob_top"><input type="text" id="p_title_mob" value="${pdto.p_title }"/></div>
			<div id="tmpdiv">|프로필|다이어리|갤러리|쥬크박스|</div>
			<div id="profile_title">프로필 수정</div>
			<div id="profile_pic"><img id="image_section" alt="profile_img" src=${pdto.p_picurl }></div>


		<form:form method="post" enctype="multipart/form-data" modelAttribute="uploadFile" action="upload.do">
			<input type="file" name="file" id="profile_pic" onchange="change_pic(this);" />
			<input type="submit" value="전송">
		</form:form>


			<hr id="profile_hr1">
			<textarea id="profile_content">${pdto.p_content }</textarea>
			<div id="profile_edit" onclick="update_p()">수정완료</div>
			<hr id="profile_hr2">
			<div id="owner_name">${login.username }</div>
			<input type="hidden" id="email" value=${login.email }>
			<input type="hidden" id="p_title" value="${pdto.p_title }">

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
		<div id="right_wrapper4_1"><input type="text" id="p_title_web" value="${pdto.p_title }"/></div>

		<!-- right_wrapper4_2: right contentbox start -->
		<div id="right_wrapper4_2">
			<div class="div_title">개인정보관리</div>
			<div id="personal_div">
				<div><label>도토리</label><label>${login.coinno }</label><div onclick="charge_coin()">충전</div></div>
				<div><label>비밀번호</label><div>변경하기</div></div>
				<div><label>이름</label><input type="text"/></div>
				<div><label>생일</label><input type="text"/></div>
				<div><label>성별</label><input type="text"/></div>
				<div><label>주소</label><textarea></textarea></div>
			</div>
			<div id="personal_ok_btn"><div>수정완료</div></div>
			<div id="friend_title"><div class="div_title">친구관리</div><div id="add_friend">친구추가하기</div></div>
			<div id="friend_div">
				<div><label>천유정</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
				<div><label>김무년</label><div>x</div></div>
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
		<div id="graph" style="height: 150px; padding-top: 15px">
			<svg width="170" height="60"></svg>
		</div>	
		<!-- 방문자 그래프에 대한 연산을 수행하는 script -->
		<script type="text/javascript">

//막대 그래프에 들어갈 데이터들 
var dataset = [{x:'<%=three_date%>', y:<%=three_date_visit%> }, {x:'<%=two_date%>', y:<%=two_date_visit%> }, {x:'<%=one_date%>', y:<%=one_date_visit%> }, {x:'<%=today_date%>', y:${todayCount}}];

//svg의 모든 정보를 가져옴               
var svg = d3.select("svg");
//그래프 오버플로우 방지
var width  = parseInt(svg.style("width"), 10) -30;
var height = parseInt(svg.style("height"), 10) -20;
var svgG = svg.append("g").attr("transform", "translate(20, 0)");


//x축 생성
var xScale = d3.scaleBand()
    .domain(dataset.map(function(d) { return d.x;} ))
    .range([0, width]).padding(0.2);

//y축 생성
var yScale = d3.scaleLinear()
    .domain([0, d3.max(dataset, function(d){ return d.y; })])
    .range([height, 0]);

//막대바와 색상 지정
var scale = d3.scaleOrdinal()
    .range(["#56B3D5", "#56B3D5", "#56B3D5", "#56B3D5"]);
    
//g는 group을 의미하는 태그 /x축
svgG.append("g")            
    .attr("transform", "translate(0," + height + ")")
    .call(d3.axisBottom(xScale)
    );

//y축의 단위를 지정
svgG.append("g")
    .call(d3.axisLeft(yScale)
        .ticks(2)
    );
    
var barG = svgG.append("g");

barG.selectAll("rect")
    .data(dataset)
    .enter().append("rect")
        .attr("class", "bar")
        .attr("height", function(d, i) {return height-yScale(d.y)})
        .attr("width", xScale.bandwidth())
        .attr("x", function(d, i) {return xScale(d.x)})
        .attr("y", function(d, i) {return yScale(d.y)})
		.attr("fill",   function(d) { return scale(d.x); })
        .on("mouseover", function() { tooltip.style("display", null); })
        .on("mouseout",  function() { tooltip.style("display", "none"); })
        .on("mousemove", function(d) {
            tooltip.style("left", (d3.event.pageX+10)+"px");
            tooltip.style("top",  (d3.event.pageY-10)+"px");
            tooltip.html(d.y);
        });        
    
/* barG.selectAll("text")
    .data(dataset)
    .enter().append("text")
    .text(function(d) {return d.y})
        .attr("class", "text")
        .attr("x", function(d, i) {return xScale(d.x)+xScale.bandwidth()/2})
        .style("text-anchor", "middle")
        .attr("y", function(d, i) {return yScale(d.y)+15});
         */
var tooltip = d3.select("#graph").append("div").attr("class", "count").style("display", "none");
    
</script>
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
	
	<input type="hidden" value="" id="addcoin" />

</body>
</body>
</html>