$(document).ready(function() {
	$(".home").nextAll().before("<p>></p>");
	$(".nav-location > ul > p").css({"display" : "inline-block", "margin" : "0", "padding-left" : "5px"});
	$(".home").nextAll().css({"padding-left" : "5px"});
	$(".frm-email, #email-input").outerHeight(40);
});