<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
$(function(){
	
	$("#check_module").click(function(){
		
		var price = $("input:radio[name=dotory]:checked").val();

		IMP.init('imp71312172');
		IMP.request_pay({
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : '도토리',
			amount : price,
			buyer_email : '${login.email}',
			buyer_name : '${login.username}',
			//buyer_tel : '010-4994-6280',
			buyer_addr : '${login.addr}',
			//buyer_postcode : '456-456'
		}, function(rsp) {
			if ( rsp.success ) {
				var msg = '결제가 완료되었습니다.';
				msg += '고유ID : ' + rsp.imp_uid;
				msg += '상점 거래ID : ' + rsp.merchant_uid;
				msg += '결제 금액 : ' + rsp.paid_amount;
				msg += '카드 승인번호 : ' + rsp.apply_num;
				
				var dotory_amount = price/100;
				
				alert("도토리 구매 성공 :)");
				$(opener.document).find("#addcoin").val(dotory_amount);
				close();
				
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
			}
		});
	})	
});

</script>
</head>
<body>

<p>도토리 결제창</p>
<button id="check_module">충전</button>
<input type="radio" name="dotory" value="1000"/>10개(1000원)
<input type="radio" name="dotory" value="2000"/>20개(2000원)
<input type="radio" name="dotory" value="3000"/>30개(3000원)

<a>내가가진 도토리 갯수 : ${login.coinno }</a>
</body>
</html>