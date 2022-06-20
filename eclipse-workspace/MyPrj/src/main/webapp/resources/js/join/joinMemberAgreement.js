function agreement_Chk() {
	if($("#serviceAgreement").is(":checked") == true && $("#privacyAgreement1").is(":checked")) {
		return true;
	} else {
		return false;
	}
}

function formSubmit() {
	if(agreement_Chk()) {
		location.replace("/main/join/joinMember");
	} else {
		alert("필수항목에 모두 동의해주셔야 서비스 이용이 가능합니다.");
		return false;
	}
}