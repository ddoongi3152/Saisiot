/**
 * canvas
 */
var picture = {
 canvas : null,
 context : null,
 context1 : null,
 context2 : null
};
/**
 * 0 : 펜
 * 1 : 직선
 * 2 : 사각형
 * 3 : 타원
 */
var eventObject = {
 mode: 0,
 click : false,
 x: -355,
 y: -133,
};

var fixedX = -355;
var fixedY = -133;
 
// 초기화
$(document).ready(function() {
 
 picture.canvas =document.getElementById("canvas");
 picture.context = picture.canvas.getContext("2d");
 picture.context.lineWidth = 3;
 mouseListener();
 
 	$(function() {
 		//선 색상 변경
		 $("#selectColor").change(function() {
			var selectColor = $("#selectColor").val();
			
			picture.context.strokeStyle = selectColor;
			picture.context.beginPath();
			picture.context.stroke();
		})
		$(".color > div").click(function() {
			var idx = $(".color > div").index(this);
			var selectColor = $(".color > div:eq("+idx+")").attr("id");
			picture.context.strokeStyle = selectColor;
			picture.context.beginPath();
			picture.context.stroke();
		})
	})
})
 
// 현재 클릭중인지 아닌지 구분?하기위한 변수 세팅
function setClickTrue(){
 eventObject.click = true;
}
function setClickFalse(){
 eventObject.click = false;
}

// 새로그리기 이벤트
function clearCanvas() {
	picture.canvas = document.getElementById("canvas");
	picture.context = picture.canvas.getContext("2d");
	picture.context.beginPath();
	picture.context.clearRect(0, 0, picture.canvas.width, picture.canvas.height);
	picture.context.stroke();
	
}

// 이미지 배경으로 가져오기
function selectImg(value) {
 	var reader = new FileReader();
 	
 	reader.onload = function(e) {
 		picture.canvas = document.getElementById("canvas");
		picture.context = picture.canvas.getContext("2d");
		mouseListener();
		var background = new Image();
		background.onload = function() {
			picture.context.beginPath();
			picture.context.drawImage(background, 0, 0, canvas.width, canvas.height);
			picture.context.stroke();
		}
		background.src = e.target.result;
	}
 	reader.readAsDataURL(value.files[0]);
}

//굵기 변경
function selectWidth() {
	var selectWidth = $("#selectWidth").val();
	picture.context = picture.canvas.getContext("2d");
	picture.context.beginPath();
	picture.context.lineWidth = selectWidth;
	picture.context.stroke();
}

// 펜일 경우의 이벤트
function dragEvent(event) {
 var g = picture.context;
 g.moveTo(eventObject.x, eventObject.y);

 eventObject.x = event.x+fixedX;
 eventObject.y = event.y+fixedY;

 if (eventObject.click) {
  g.lineTo(event.x+fixedX, event.y+fixedY);
  g.stroke();
 }
 
}
 
// 좌표 출력
function printXY(e){
 var g = picture.context;
/* document.getElementById("x").innerHTML = e.x;
 document.getElementById("y").innerHTML = e.y;*/
}
 
// 라인, 사각형 등 이전 좌표가 필요할 경우 이전좌표 세팅
function setBeforeXY(e){
 
 var g = picture.context;
 eventObject.x = e.x+fixedX;
 eventObject.y = e.y+fixedY;
 g.moveTo(e.x+fixedX, e.y+fixedY);
}
 
// setBeforeXY 에서 세팅한 좌표부터 현재 좌표까지 직선을 그림
function drawLine(e){
 
 var g = picture.context;
 g.lineTo(e.x+fixedX, e.y+fixedY);
 g.stroke();
}
 
// setBeforeXY 에서 세팅한 좌표부터 현재 좌표까지 사각형을 그림
function drawRect(e){
 var g = picture.context;
 g.rect(eventObject.x, eventObject.y, (e.x+fixedX)-eventObject.x, (e.y+fixedY)-eventObject.y);
 g.stroke();
 // g.fill(); 을 g.stroke() 대신 사용하면 속이 꽉찬 사각형을 그린다.
}

// setBeforeXY에서 세팅한 좌표부터 현재 좌표까지 타원을 그림
function drawCircle(e){
	var g = picture.context;
	g.beginPath();
	g.arc(e.x+fixedX, e.y+fixedY, (e.x+fixedX)-eventObject.x, 0, 2*Math.PI, false);
	g.stroke();
}
 
// 각 경우에 따라서 이벤트리스너를 달아준다.
function mouseListener(){
 var mode = Number(eventObject.mode);
 picture.canvas.addEventListener("mousemove", printXY, false);
 switch(mode){
 
 case 0:
  document.getElementById("mode").innerHTML = $("#pen > input").val();
  picture.canvas.addEventListener("mousedown",setClickTrue, false);
  picture.canvas.addEventListener("mouseup", setClickFalse, false);
  picture.canvas.addEventListener("mousemove", dragEvent, false);
  break;
  
 case 1:
  document.getElementById("mode").innerHTML = $("#line > input").val();
  picture.canvas.addEventListener("mousedown",setBeforeXY, false);
  picture.canvas.addEventListener("mouseup", drawLine, false);
  break;
  
 case 2:
  document.getElementById("mode").innerHTML = $("#rect > input").val();
  picture.canvas.addEventListener("mousedown",setBeforeXY, false);
  picture.canvas.addEventListener("mouseup", drawRect, false);
  break;
  
 case 3:
	  document.getElementById("mode").innerHTML = $("#circ > input").val();
	  picture.canvas.addEventListener("mousedown",setBeforeXY, false);
	  picture.canvas.addEventListener("mouseup", drawCircle, false);	
	  break;
  
 default:
  break;
 }
 
}
 
// 이벤트 리스너 제거
function removeEvent(){
 picture.canvas.removeEventListener("mousedown",setClickTrue, false);
 picture.canvas.removeEventListener("mouseup", setClickFalse, false);
 picture.canvas.removeEventListener("mousemove", dragEvent, false);
 picture.canvas.removeEventListener("mousedown",setBeforeXY, false);
 picture.canvas.removeEventListener("mouseup", drawLine, false);
 picture.canvas.removeEventListener("mouseup", drawRect, false);
 picture.canvas.removeEventListener("mouseup", drawCircle, false);
}
 
// 모드 체인지
function changeMode(mode){
 removeEvent();
 eventObject.mode = mode;
 mouseListener();
}

//canvas에 그려진 그림을 파일로 저장
function save(){ 
	var myImage = document.getElementById('myImage');
	myImage.src = canvas.toDataURL();//canvas를 이미지파일로 옮김 
		
	document.getElementById('save').setAttribute('href',canvas.toDataURL());	
}

	