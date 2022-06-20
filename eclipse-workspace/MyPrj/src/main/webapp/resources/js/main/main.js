let thisWidth = $(".body").width();
let res = 768;

$(document).ready(function() {
	let btnSwitch = 1;
	$(".btn-play").css({"display" : "none"});
	
	$("#btn-slide").on("click", function() {
		if(btnSwitch == 1) { // 실행중인 상태 : 1
			btnSwitch = 0;
		
			$(".btn-stop").css({"display" : "none"});
			$(".btn-play").css({"display" : "block"});
	
			swiper.autoplay.stop();
		} else if(btnSwitch == 0) { // 정지중인 상태 : 0
			btnSwitch = 1;
			
			$(".btn-stop").css({"display" : "block"});
			$(".btn-play").css({"display" : "none"});	
		
			swiper.autoplay.start();
		}
	});
});

let swiper = new Swiper(".swiper-container", {
	slidesPerView : 1,
	spaceBetween : 30,
	loop : true,
	centeredSlides : true,
	speed : 1000,
	autoplay : {
		delay : 3000,
		disableOnInteraction : false,
	},
	pagination : {
		el : ".swiper-pagination",
		clickable : true,
	},
	navigation : {
		nextEl : ".swiper-button-next-unique",
		prevEl : ".swiper-button-prev-unique"
	}
});

/*$(".dot > li > a").on("mouseover", function() {
	let indexNumber = $(this).parent("li").index();
	let slideSize = $(".ul-img-main-page-inner-content2 > li > img").length;
	let slideHeight = $(".ul-img-main-page-inner-content2 > li").height();
	let slideMove = -slideHeight * indexNumber;
	
	$(".ul-img-main-page-inner-content2 > li").css({"transform":"translateY("+slideMove+"px)", "transition" : "transform 250ms ease-in-out"});
});

$(".dot > li > a").on("mouseout", function() {
	$(".ul-img-main-page-inner-content2 > li").css({"transform":"translateY(0)", "transition" : "transform 250ms ease-in-out"});
});*/