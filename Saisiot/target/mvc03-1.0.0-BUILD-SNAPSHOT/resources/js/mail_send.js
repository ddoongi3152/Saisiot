


		
	
	function mailchk(){
			
			var email = document.getElementById("yourmail").value;
			var randomcode = Math.floor(Math.random() * (99999 - 10000 + 1)) + 10000;
			
			if(email == null || email == ""){
				alert("이메일 주소를 입력하세요");
				return false;
			}
			
			$.ajax({
				
				type:"POST",
				url:"emailcheck.do",
				data:"email="+email,
				success:function(data){
					//alert(data);
					if(data == "0"){
						alert("중복된 이메일 입니다.");
					}else if(data == "1"){
						
						$.ajax({
							type:"POST",
							url:"mailsend.do",
							data:"email="+email+"&randomcode="+randomcode,
							success:function(data){
								alert("사용가능한 이메일입니다. 인증코드 전송 되었습니다.");
								$('#randomcode').val(randomcode);
							},
							error:function(){
								alert("인증코드 전송실패");
							}					
						})
						
					}
				},
				error:function(){
					alert("이메일 중복확인 실패");
				}
				
			})
		}
		
		function numberchk() {
			
			var randomcode = document.getElementById("randomcode").value;
			var numberchk = document.getElementById("numberchk").value;
			
			if(randomcode == null || randomcode == ""){
				
				alert("인증코드를 입력해주세요")
				return false;
		
			}else if(randomcode == null || randomcode != ""){
				
				if(randomcode == numberchk){
					alert("인증코드가 일치 합니다.");
					window.opener.document.getElementById("insertemail").value = document.getElementById("yourmail").value;
					self.close();
				}else if(randomcode != numberchk){
					alert("인증코드가 일치 하지 않습니다.");
				}
				
			}
		}