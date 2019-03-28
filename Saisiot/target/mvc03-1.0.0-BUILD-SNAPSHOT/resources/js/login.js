


	function emailpwFind() {
		window.open("emailpwFind.do", "ID/PW찾기", "width=500,height=300");
	}
	
	

	Kakao.init('2dd32590814325a32811f6f978ff4224');
	function loginWithKakao() {
	  // 로그인 창을 띄웁니다.
	 Kakao.Auth.loginForm({
	    success: function(authObj) {
	      alert(JSON.stringify(authObj));
	      
	      Kakao.API.request({
	
	     url: '/v2/user/me',
	     success: function(res) {
	    	 
	    	// alert(res.id);
	    	// alert(res.kakao_account.email);
	    	// alert(res.properties.nickname);
	    	 
	    	 $.ajax({	
					type:"POST",
					url:"kakaologinajax.do",
					data:"email="+res.kakao_account.email+"&password="+"kakaouser"+"&name="+res.properties.nickname,
					//data:kakaoemail,
					success:function(data){
						//alert("로그인 성공");
						
						if(data=="1"){
							location.href='homepage.do';
						}else if(data=="2"){
							location.href='condition.do';
						}			
					},
					error:function(){
						alert("로그인실패");
					}
	
				})
	          
	         }
	       })
	
	    },
	    fail: function(err) {
	      alert(JSON.stringify(err));
	    }
	  });
	};


	$(document).ready(function() {
	    $("#recaptcha_btn").click(function() {
	        $.ajax({
	            url: 'VerifyRecaptcha.do',
	            type: 'post',
	            data: {
	                recaptcha: $("#g-recaptcha-response").val()
	            },
	            success: function(data) {
	                switch (data) {
	                    case 0:
	                       	//alert("자동 가입 방지 봇 통과");
	                        $('#recaptcha_chk').val('1');
	                        break;
	
	                    case 1:
	                        //alert("자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.");
	                        break;
	
	                    default:
	                        alert("자동 가입 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(data) + "]");
	                        break;
	                }
	            }
	        });
	    });
	});

	
	

	$(window).resize(function(){
		if ($(window).width() > 460) {
			  $("#folder_list_div").show()
		}else {
			$("#folder_list_div").hide()
		}
	})
	$(document).ready(function(){
	  $("#folder_list_drop").click(function(){
	    $("#folder_list_div").toggle()
	  });
	});

	function mailcon() {
		
		window.open("mailgo.do", "이메일 인증", "width=500,height=300");
		
	}
	
	function goPopup(){
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	    var pop = window.open("jusoPopup.do","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	    
		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
	    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}
	
		
	function pwchk(){
			
			if(document.getElementById('insertpassword').value.length >= 6 && document.getElementById('insertpasswordchk').value.length <= 12){
				document.getElementById('same01').innerHTML='사용가능한 비밀번호 입니다.';
				document.getElementById("same01").style.color="blue";
	    		
	    	} 
			else {
	    		document.getElementById('same01').innerHTML='비밀번호는 6글자 이상 12글자 이하로 설정해주세요';
	    		document.getElementById("same01").style.color="red";
	    	}
	    	
	    	if(document.getElementById('insertpassword')!='' && document.getElementById('insertpasswordchk').value!=''){
	    		if(document.getElementById('insertpassword').value==document.getElementById('insertpasswordchk').value){
	    			document.getElementById('same02').innerHTML='비밀번호가 일치 합니다.';
	    			document.getElementById('same02').style.color='blue';
	    		}
	    		else{
	    			document.getElementById('same02').innerHTML='비밀번호가 일치하지않습니다.';
	    			document.getElementById('same02').style.color='red';
	    		}
	    	}
	    }
	
	
	function notnull(){
		
		
		var date = document.getElementById("birthdate").value;

		var year = date.substr(0,4);

		var month = date.substr(5,2);

		var day = date.substr(8,2);

		var fullday = year+month+day;

		var datechange = parseInt(fullday);
		
		var yyyy = new Date().getFullYear().toString();

		var mm = (new Date().getMonth()+1).toString();

		var dd = (new Date().getDate()).toString();;
		
		var mmint = parseInt(mm);
		if(mmint < 10){
			var today = parseInt(yyyy + "0" + mm + dd);
		}else{
			var today = parseInt(yyyy + mm + dd);
		}
		
		var yourdate = parseInt(fullday);
		
		if(document.getElementById("insertemail").value == null){
			alert("이메일을 입력해주세요");
			return false;
		}
		if(document.getElementById("insertemail").value == ""){
			alert("이메일을 입력해주세요");
			return false;
		}
		if(document.getElementById("insertpassword").value == null){
			alert("비밀번호를 입력해주세요");
			return false;
		}
		if(document.getElementById("insertpassword").value == ""){
			alert("비밀번호를 입력해주세요");
			return false;
		}
		if(document.getElementById("insertpassword").value == "123456789"){
			alert("사용할 수 없는 비밀번호 입니다.");
			return false;
		}
		if(document.getElementById("insertpassword").value == document.getElementById("insertemail").value){
			alert("이메일과 비밀번호는 같을 수 없습니다.");
			return false;
		}
		if(document.getElementById("insertpassword").value == document.getElementById("insertname").value){
			alert("이름과 비밀번호는 같을 수 없습니다.");
			return false;
		}
		if(document.getElementById("birthdate").value == null){
			alert("생년월일을 입력해주세요");
			return false;
		}
		if(document.getElementById("birthdate").value == ""){
			alert("생년월일을 입력해주세요");
			return false;
		}
		if(document.getElementById("insertname").value == null){
			alert("이름을 입력해주세요");
			return false;
		}
		if(document.getElementById("insertname").value == ""){
			alert("이름을 입력해주세요");
			return false;
		}
		if(document.getElementById("insertaddress").value == null){
			alert("주소를 입력해주세요");
			return false;
		}
		if(document.getElementById("insertaddress").value == ""){
			alert("주소를 입력해주세요");
			return false;
		}
		
		if(document.getElementById("recaptcha_chk").value == null){
			alert("자동입력방지를 확인해주세요");
			return false;
		}
		
		if(document.getElementById("recaptcha_chk").value == ""){
			alert("자동입력방지를 확인해주세요");
			return false;

		}
		
		if(today - yourdate <= 0){
			alert("현재날짜보다 생일이 더 늦을수는 없습니다.")
			return false;
		}
			
		return true;
	}
	
	function loginchk() {
		
		if(document.getElementById("email").value == ""){
			alert("이메일을 입력해주세요");
			return false;
		}
		if(document.getElementById("email").value ==null){
			alert("이메일을 입력해주세요");
			return false;
		}
		
		if(document.getElementById("pw").value == ""){
			alert("비밀번호를 입력해주세요");
			return false;
		}
		
		if(document.getElementById("pw").value == null){
			alert("비밀번호를 입력해주세요");
			return false;
		}
		
		
	return true;
	}
	
	function gendercheckbox(chk){
			
		var check = document.getElementsByName("gender");
		
			if(check[0]==chk){
				check[1].checked = false;
			}else if(check[1]==chk){
				check[0].checked = false;
			}
	
	}
	
	
	
	
	