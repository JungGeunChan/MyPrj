$(document).ready(function() {
	$(".btn-paginate").hover(function() {
		$(this).css({"border-color" : "#7D78FF", "color" : "#7D78FF"});
		$(this).children("a").css({"font-weight" : "bold", "color" : "#7D78FF"});
	}, function() {
		$(this).css({"border-color" : "#E5E5E5", "color" : "black"});
		$(this).children("a").css({"font-weight" : "normal" ,"color" : "black"});
	});
});