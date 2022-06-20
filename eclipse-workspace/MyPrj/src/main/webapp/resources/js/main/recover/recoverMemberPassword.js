/*$("input[type=radio][name=recoverMemberIdMethod]").on("click", function() {		
	let checkValue = $("input[type=radio][name=recoverMemberIdMethod]:checked").val();

	if(checkValue == "chk_memberPhone") { // 핸드폰 확인방식
		$(".tr3").css({"display" : "block"});
		$(".tr4").css({"display" : "none"});
		$(".frm-recoverMember").prop("action", "/main/mypage/recoverMemberPassword_toPhone");
	} else if(checkValue == "chk_memberEmail") { // 이메일 확인 방식
		$(".tr3").css({"display" : "none"});
		$(".tr4").css({"display" : "block"});
		$(".frm-recoverMember").prop("action", "/main/mypage/recoverMemberPassword_toEmail");
	}
});*/

