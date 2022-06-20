$(document).ready(function() {
	let thisWidth = $(".page-wrapper").width();
	let maxWidth = 1351;
	let res = maxWidth * 45 / 100;
	
	if(thisWidth < res) { // 최초 실행시 브라우저 크기가 전체의 45%보다 작을 떄
		$(".join-step-content").css({"width" : "calc(100% - 30px)"});
		$(".join-step-content > p").css({"font-size" : "1.3em"});
		$(".email-input").css({"display" : "block"});
		$(".first").css({"display" : "block", "width" : "100%", "margin-bottom" : "15px"});
		$(".second").css({"display" : "block", "width" : "100%"});
		$(".find-btn-area").css({"text-align" : "left", "margin-top" : "10%"});
	} else {
		$(".join-step-content").css({"width" : "70%"});
		$(".join-step-content > p").css({"font-size" : "1.7em"});
		$(".email-input").css({"display" : "table"});
		$(".first").css({"display" : "table-cell", "width" : "110px", "margin" : "0"});
		$(".second").css({"display" : "table-cell", "width" : "calc(100% - 110px)"});
		$(".find-btn-area").css({"text-align" : "center", "margin-top" : "5%"});
	}
});
	
$(window).resize(function() {
	let maxWidth = 1351;
	let width = $(".page-content").width();
	let res = maxWidth * 45 / 100; // 전체 크기의 45%
	if(width <= res) { // 줄어들었을 때
		$(".join-step-content").css({"width" : "calc(100% - 30px)"});
		$(".join-step-content > p").css({"font-size" : "1.3em"});
		$(".email-input").css({"display" : "block"});
		$(".first").css({"display" : "block", "width" : "100%", "margin-bottom" : "15px"});
		$(".second").css({"display" : "block", "width" : "100%"});
		$(".find-btn-area").css({"text-align" : "left", "margin-top" : "10%"});
	} else { // 늘어났을 때
		$(".join-step-content").css({"width" : "70%"});
		$(".join-step-content > p").css({"font-size" : "1.7em"});
		$(".email-input").css({"display" : "table"});
		$(".first").css({"display" : "table-cell", "width" : "110px", "margin" : "0"});
		$(".second").css({"display" : "table-cell", "width" : "calc(100% - 110px)"});
		$(".find-btn-area").css({"text-align" : "center", "margin-top" : "5%"});
	}
});