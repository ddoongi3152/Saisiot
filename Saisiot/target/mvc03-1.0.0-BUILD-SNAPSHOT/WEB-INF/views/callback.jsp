<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<head>
<title>네이버로그인</title>
</head>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
	<script type="text/javascript">
  var naver_id_login = new naver_id_login("FyagxD4aXpcrDC2Hvgos", "http://localhost:8787/mvc03/callback.do");
  // 접근 토큰 값 출력
  //alert(naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
    //alert(naver_id_login.getProfileData('email'));
    //alert(naver_id_login.getProfileData('nickname'));
    //alert(naver_id_login.getProfileData('id'));
    
    var email = naver_id_login.getProfileData('email');
    var nickname = naver_id_login.getProfileData('nickname');
    var id = naver_id_login.getProfileData('id');

    $.ajax({
		type:"POST",
		url:"naverloginajax.do",
		data:"email="+email+"&password="+"naveruser"+"&name="+nickname,
		success:function(data){
			//alert("네이버 전송 성공");
			//alert(data);
			if(data == "1"){
				opener.parent.window.location.href="homepage.do";
				self.close();
			}else if(data =="2"){
				opener.parent.window.location.href="condition.do";
				self.close();
			}
			
			
		},
		error:function(){
			alert("네이버 로그인 실패");
		}
		 
	 })
	 
  }
					
</script>
</body>
</html>

