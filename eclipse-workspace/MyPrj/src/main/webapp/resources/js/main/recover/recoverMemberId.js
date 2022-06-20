$(document).ready(function() {
	$(".tr3").show();
	$(".tr4").hide();
	
	$("input[type=radio][name=recoverMemberIdMethod]").on("click", function() {		
		let checkValue = $("input[type=radio][name=recoverMemberIdMethod]:checked").val();

		if(checkValue == "chk_memberPhone") { // 핸드폰 확인방식
			$(".tr3").show();
			$(".tr4").hide();
			$(".frm-recoverMember").prop("action", "/main/recover/recoverMemberId_toPhone");
		} else if(checkValue == "chk_memberEmail") { // 이메일 확인 방식
			$(".tr3").hide();
			$(".tr4").show();
			$(".frm-recoverMember").prop("action", "/main/recover/recoverMemberId_toEmail");
		}
	});
});

function checkName() {
	if($("#memberName").val() == "") {
		alert("이름을 입력해주세요.");
		return false;
	} else if($("#memberName").val().length < 2) {
		alert("이름은 최소 두글자부터 입니다.");
		return false;
	}
	return true;
}

function reg_checkEmail(memberEmail) {
	/*
	1. 이메일 주소 시작은 숫자나 알파벳(소문자/대문자).
	2. 이메일 첫째자리 뒤에는 "-" or "_" or "." 을 포함하여 입력가능.
	3. 도메인 주소 전에는 반드시 @ 입력.
	4. "." 이 최소한 하나는 있어야 하며 마지막 마디는 2-3자리여야 한다. (ex : jkchappy@naver.com)
	*/
	var emailRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
	if(!emailRegExp.test(memberEmail)) {
		alert("이메일 형식이 올바르지 않습니다.");
		return false;
	} else {
		return true;
	}
}

function formSubmit() {
	let memberPhone1 = $("#memberPhone1").val();
	let memberPhone2 = $("#memberPhone2").val();
	let memberPhone3 = $("#memberPhone3").val();	
		
	let checkValue = $("input[type=radio][name=recoverMemberIdMethod]:checked").val();
		
	if (!checkName()) {
		return false;
	} else if(checkValue == "chk_memberPhone") {
		if(memberPhone1.length < 3 || memberPhone2.length < 4 || memberPhone3.length < 4) {
			alert("올바른 연락처를 입력해주세요.");
			return false;
		} else if($.isNumeric(memberPhone1) == false || $.isNumeric(memberPhone2) == false || $.isNumeric(memberPhone3) == false) {
			alert("올바른 연락처를 입력해주세요.");
			return false;
		} else {
			let memberPhone = memberPhone1 + "-" + memberPhone2 + "-" + memberPhone3;
			console.log(memberPhone);
			$("#memberPhone").val(memberPhone);
			return true;
		}
	} else if(checkValue == "chk_memberEmail") {
		if(!reg_checkEmail($("#memberEmail").val())) {
			return false;
		} else {
			return true;	
		}
	}
}

