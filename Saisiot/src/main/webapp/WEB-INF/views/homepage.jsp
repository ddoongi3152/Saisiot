<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Locale" %>
<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script type="text/javascript" src="<c:url value="resources/js/jquery-3.3.1.js"/>"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#friend_select > select").change(function() {
			location.href = "otherhome.do?email="+this.value
		});
	});

</script>
<script type="text/javascript"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="resources/js/bgm.js?ver=3"></script>
<link rel="stylesheet" href="resources/css/homepage_mob.css">
<link rel="stylesheet" href="resources/css/homepage_web.css">
<!-- d3 import 하기 -->
<script src="https://d3js.org/d3.v5.js"></script>
<title>Insert title here</title>
</head>
<body>
<%
	String whos = (String)session.getAttribute("whos");
	UserinfoDto dto;
	if(whos.equals("mine")){
		dto = (UserinfoDto)session.getAttribute("login");
	}else{
		dto = (UserinfoDto)session.getAttribute("others");
	}
	
	List<String> friendList = (List<String>)session.getAttribute("friendList");
	
	if(dto.getAddr() == null){
		response.sendRedirect("user_info_plus.do");
	}


	//방문자수와 통계 그래프를 위한 코드 - 유정

	//일주일간 방문자 통계 리스트
	List<Object> week_visit_date = new ArrayList<Object>();
	week_visit_date = (ArrayList)session.getAttribute("week_visit_date");

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
	
	// juke count
%>

	<div id="left_wrapper1">
	<div id="left_wrapper2">
	<div id="left_wrapper3">
	<div id="left_wrapper4">
		<div id="left_wrapper5_1">${todayCount} today | total  ${totalCount}</div>
		<div id="left_wrapper5_2">
		<div id="left_wrapper6">
			<div id="mob_top">${pdto.p_title}&nbsp; <%=dto.getUsername() %></div>
			<div id="tmpdiv">탭목록</div>
			<div id="profile_pic"><img alt="profile_img" src=${pdto.p_picurl }></div>
			<hr id="profile_hr1">
			<div id="profile_content">
			${pdto.p_content}
			</div>
			<div id="profile_edit"><a>▶Edit</a> <a>▶History</a></div>
			<hr id="profile_hr2">
			<div id="owner_name"><%=dto.getUsername()%><input type="button" value="로그아웃" onclick="location.href='logout.do'"></div>
			<div id="friend_select">
				<select>
					<option value=<%=dto.getEmail() %>><%=dto.getUsername()%></option>
					<c:forEach items="${friendList}" var="dtos">
					<option value=${dtos.email }>${dtos.username }</option>
					</c:forEach>
				</select>
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
		<div id="right_wrapper4_1">${pdto.p_title}</div>

		<!-- right_wrapper4_2: right contentbox start -->
		<div id="right_wrapper4_2">
			<div id="right_wrapper4_2_1">
				<div id="right_wrapper4_2_1l">
					<div class="title">Updated News</div>
					<hr>
					<div id="listbox">
						<ul>
							<li>sample text</li>
							<li>sample text</li>
							<li>sample text</li>
							<li>sample text</li>
							<li>sample text</li>
							<li>sample text</li>
							<li>sample text</li>
						</ul>
					</div>
				</div>
				<div id="right_wrapper4_2_1r">
					<div class="title">Content</div>
					<hr>
					<table>
						<tr>
							<td>다이어리 1/2</td><td onclick="location.href='jukebox.do?email=<%=dto.getEmail()%>'">쥬크박스  ${jukenum }</td>
						</tr>
						<tr>
							<td>친구 1</td><td>채팅방 1</td>
						</tr>
					</table>
				</div>
			</div>
			<div id="right_wrapper4_2_2">
				<div class="title">Photo</div>
				<hr>
				<div id="photo_zone">
					<div class="photos"><img alt="profile_img" src="resource/home/img/checkbox.PNG"/><p>!!!</p></div>
					<div class="photos"><img alt="profile_img" src=""/><p>!!!</p></div>
					<div class="photos"><img alt="profile_img" src="resource/home/img/checkbox.PNG"/></div>
					<div class="photos"><img alt="profile_img" src="resource/home/img/checkbox.PNG"/></div>
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
		<div onclick="location.href='homepage.do'">home</div>
		<div onclick="location.href='gallery.do'">gallery</div>
		<div onclick="location.href='diary.do'">diary</div>
		<div onclick="location.href='jukebox.do?email=<%=dto.getEmail()%>'" style="display:<%=(!session.getAttribute("whos").equals("mine"))?"none":""%>">jukebox</div>
		<div onclick="location.href='profile.do'" style="display:<%=(!session.getAttribute("whos").equals("mine"))?"none":""%>">profile</div>
		<div onclick="location.href='chat.do'">chat</div>
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
var svgG = svg.append("g")
    .attr("transform", "translate(20, 0)");

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
			<audio id="musicplayer" autoplay="autoplay" controls controlsList="nodownload">
				<source src="" type="audio/mpeg" >
				Your browser does not support the audio tag.
			</audio>
		</div>
		<div id="audio_list">
			<table>
				<c:choose>
					<c:when test="${empty background }">
						<tr>
							<td align="center">- 선택된 배경음악이 없습니다 -</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${background }" var="back">
							<tr>
								<td class="musictitle"><a>${back.musictitle}</a></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
		<div id="tracks" style="display: none;">
			<input type="hidden" id="firstSong" value="">
			<input type="hidden" id="songindex" value="">
			<input type="hidden" id="repeat" value="">
		</div>
	</div>

</body>
</html>