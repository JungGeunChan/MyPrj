let res = 768; // px

$(document).ready(function() {
	let thisWidth = $(".body").width();

	if(thisWidth <= res) {
		$(".desktop-td-btn").hide();
		$(".mobile-td-btn").show();
	} else {
		$(".desktop-td-btn").show();
		$(".mobile-td-btn").hide();
	}
});
	
$(window).resize(function() {
	let thisWidth = $(".body").width();
	if(thisWidth <= res) {
		$(".desktop-td-btn").hide();
		$(".mobile-td-btn").show();
	} else {
		$(".desktop-td-btn").show();
		$(".mobile-td-btn").hide();
	}
});
	
$("#btn-submit").on("click", function() {
	$(".form-login").submit();
});