$(document).ready(function() {
	let thisWidth = $(".body").width();
	let res = 768; // px
	
	if(thisWidth <= res) { // 최초 실행시 브라우저 크기가 전체의 45%보다 작을 떄
		$(".desktop-join-step").hide();
		$(".mobile-join-step").show();
	} else {
		$(".desktop-join-step").show();
		$(".mobile-join-step").hide();
	}
});
	
$(window).resize(function() {
	let thisWidth = $(".body").width();
	let res = 768; // px
	
	if(thisWidth <= res) { // 줄어들었을 때
		$(".desktop-join-step").hide();
		$(".mobile-join-step").show();
	} else { // 늘어났을 때
		$(".desktop-join-step").show();
		$(".mobile-join-step").hide();
	}
});