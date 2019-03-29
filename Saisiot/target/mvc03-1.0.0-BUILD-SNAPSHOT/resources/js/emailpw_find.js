
			
		function find() {
			
			var mail = document.getElementById("mail").value;
			
			if(mail == null || mail == ""){
				alert("생년월일을 입력해주세요");
			}else{
			
			//alert(mail);
			
			$.ajax({
			
				type:"POST",
				data:"mail="+mail,
				url:"emailpwFindgo.do",
				success:function(data){
					if(data == "1"){
						document.getElementById("yourinformation").innerHTML =  "입력하신 정보가 일치하지 않습니다.";
					}else if(data == "0"){
						alert("메일전송 실패");
					
					}else if(data == "3"){
						alert("카카오 또는 네이버 로그인 이용자는 사용할 수 없습니다.")
						self.close();
					}else{
						//alert(typeof data);
						alert("메일로 비밀번호가 발송되었습니다.");
						//alert("성공");
						window.close();
					}
					
					
				},
				error:function(){
					alert("실패");
				}
				
			})
			
			
			}
		}
	