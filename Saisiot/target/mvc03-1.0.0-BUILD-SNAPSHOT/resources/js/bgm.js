/**
 * 
 */

	$(document).ready(function() {
		// 배경음악 목록 == mp3파일, 재생 func
		var titlelist = $(".musictitle");
		var mp3list = [{name: 'Another Day Of Sun'},{name: '딱 죽기 좋은밤이네'},{name: '아버지'},{name: '활주'}];
		var playlist = new Array();
		var appendSong = "";
		$.each(titlelist, function(index, item) {
			var song = $(item).text();
			$.each(mp3list, function(index, item) {
				var mp3 = item.name;
				if(song.indexOf(mp3)!=-1){
					playlist.push(mp3);
				}
			})
		})
		if(playlist == null||playlist == ""){
			$("#musicplayer").attr("src","");
		}else{
			// 한곡만 있는 경우 설정
			if(playlist.length == 1){
				var first = playlist[0];
				$("#musicplayer").attr({src: "resources/bgm/"+first+".mp3", autoplay: "autoplay", loop: "loop"});
			}else{
				// 첫 곡 셋팅 후 첫 곡 잘라내고 리스트 a태그에 뿌림
				var first = playlist[0];
				firstSong(first);
				playlist.splice(0,1);
				$.each(playlist, function(index, item) {
					appendSong += "<a>"+ item +"</a>";
				})
			}
		}
		$("#tracks").append(appendSong);
	})
	
	// 첫번째 곡 듣기 설정
	function firstSong(song) {
		var firstsong = song;
		$("#firstSong").val(firstsong);
		var audio = $("#musicplayer");
		audio.attr({src: "resources/bgm/"+firstsong+".mp3", autoplay: "autoplay", onended: "playBack()"});
		playSongStyle(firstsong);
	}
	
	// 인덱스로 리스트 다음곡, 여러곡 설정
	function nextSong() {
		var tracks = new Array();
		$("#tracks > a").each(function(i) {
			var nextSongText = $("#tracks > a").eq(i).text();
			tracks.push(nextSongText);
		})
		
		var idx = $("#songindex").val();
		var song = tracks[idx];
		var audio = $("#musicplayer");
		audio.attr({src: "resources/bgm/"+song+".mp3", autoplay: "autoplay", onended: "playBack()"});
		playSongStyle(song);
		audio.play();
	}
	
	var cnt = 0;
	// 반복 설정
	function playBack() {
		
		var len = $("#tracks > a").length;
		
		// 마지막 곡 이후 첫 곡으로 다시 재생시키기
		if($("#repeat").val()==-1){
			$("#repeat").val(0);
			var first = $("#firstSong").val();
			firstSong(first);
		}else{
			// 첫 곡 제외 리스트가 한 곡일 경우
			if(len==1){
				$("#songindex").val(cnt);
				$("#repeat").val(-1); // 한 곡 재생 후 첫 곡으로 다시 재생시키기 위한 값
				nextSong();
			}else {
				// a태그 길이만큼 nextSong
				if(cnt == len){
					
					cnt = 0;
					var first = $("#firstSong").val();
					firstSong(first);
				}else{
					for(var i=0; i < len; i++){
						$("#songindex").val(cnt);
						cnt++;
						nextSong();
					}
				}
			}	
		}
	}
	
	// 현재 재생되는 곡, list에서 style 주기
	function playSongStyle(name) {
		var title = $(".musictitle > a");
		$.each(title, function(i, value) {
			var tdtext = title.eq(i).text();
			if(tdtext.indexOf(name)!=-1){
				title.eq(i)
				.css("font-weight","bold")
				.css("text-decoration","underline");
			}else{
				title.eq(i)
				.css("font-weight","normal")
				.css("text-decoration","none");
			}
		})
	}
	