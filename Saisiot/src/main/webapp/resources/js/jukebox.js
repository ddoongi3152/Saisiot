/**
 * 
 */

	// 음악 검색 function, maniaDB
	function searchMusic() {
		$("#music_table > tbody").empty();
		var name = $("#search").val();
		var str = "<tr>";
		$.ajax({
			type : "post",
			url : "searchMusic.do",
			data : "name=" + name,
			dataType : "json",
			async : false,
			success : function(data) {
				var num = 0;
				$.each(data, function(key, value) {
					var list = value;
					if(list.name==null||list.name==""){
						list.name = "-";
					}
					str += "<td><a class='name'>"
						+ list.name
						+ "</a></td><td><a class='title'>"
						+ list.title
						+ "</a></td><td><a>"
						+ list.time
						+ "</a></td><td><a>"
						+ list.album
						+ "</a></td><td><div onclick='buySong(this);'><input type='hidden' value='"+list.name+'#'+ list.title +'#'+list.time+'#'+list.album+"'>구매</div></td></tr>";
				})
				$("#music_table > tbody").append(str);
			},
				error : function() {
					alert("검색 오류!");
				}
			})
	}

	// 검색한 목록에서 구매하기 누르면 이어지는 function. 구매 후 리스트 추가까지
	function buySong(e) {
		var songOne = $(e).children('input').val();
		var email = $("#email").val();
		$.ajax({
			type : "post",
			url : "buysong.do",
			data : "email=" + email + "&songOne=" + songOne,
			async : false,
			success : function() {
				console.log("구매 성공");
				$("#searchForm").submit();
			},
			error : function() {
				console.log("구매 실패");
			}
		})
	}