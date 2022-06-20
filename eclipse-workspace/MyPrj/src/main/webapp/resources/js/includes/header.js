$(function() {
	$(".desktop-topMenu-bar > li").on("mouseover", function() {
		var index = $(this).index();
		
		if(index == 0) {
			$(this).children('.desktop-subMenu-wrap').show();
		} else if(index == 1) {
			$(this).children('.desktop-subMenu-wrap').show();
		} else {
			$(this).children('.desktop-subMenu-wrap').show();
		}
	});
	
	$(".desktop-topMenu-bar > li").on("mouseout", function() {
		var index = $(this).index();
		
		if(index == 0) {
			$(this).children('.desktop-subMenu-wrap').hide();
		} else if(index == 1) {
			$(this).children('.desktop-subMenu-wrap').hide();
		} else {
			$(this).children('.desktop-subMenu-wrap').hide();
		}
	});
});

$(function() {
	var idx = [0, 0, 0];
	var count = 0;
	
	$(".mobile-menu").on("click", function() {
		$(".mobile-topMenu-wrap").slideToggle(500, "linear").css({"display" : "block"});
	
		$(".disable").show().css({"display" : "block"});
		if(count == 0) {
			count++;
			$(".ico_lg_open").show();
			$(".ico_lg_close").hide();
		}
	});
	
	$(".mobile-topMenu-title").on("click", function(e) {
		e.preventDefault();
		
		let idxNum = $(this).parent("li").index();

		if(idx[idxNum] == 0) {
			idx[idxNum]++;
			$(this).next().children(".mobile-subMenu-bar").toggle("1000", "linear");
			$(this).children("a").children(".ico_lg_close").show();
			$(this).children("a").children(".ico_lg_open").hide();
		} else {
			idx[idxNum]--;
			$(this).next().children(".mobile-subMenu-bar").toggle("1000", "linear");
			$(this).children("a").children(".ico_lg_close").hide();
			$(this).children("a").children(".ico_lg_open").show();
		}
	});
});