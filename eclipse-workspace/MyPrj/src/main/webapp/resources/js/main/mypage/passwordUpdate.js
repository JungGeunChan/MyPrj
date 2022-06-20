function check_pw(changePassword) {
	var password1RegExp = /^(?=.*[a-zA-Z])(?=.*[`~!@@#$%^&*|₩₩₩'₩";:₩/?])(?=.*[0-9]).{8,20}$/;

	if(!password1RegExp.test(changePassword)) {
		alert("비밀번호는 영문, 숫자, 특수문자(~,!,@,#,$,%,^,* 등) 1자 이상 조합으로 8자~20자 사이로 공백없이 입력하셔야 합니다.");
           return false;
	}
	return true;
}
	
$("#changePassword").on("propertychange change keyup paste input", function() {
	var changePassword = $("#changePassword").val();
	var len = $("#changePassword").val().length;
	var num = changePassword.search(/[0-9]/g);
	var eng = changePassword.search(/[a-z]/ig);
	var spe = changePassword.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	
	if(len < 8 || len > 20) {
		if(len == 0) {
			$(".result-pw").html("비밀번호를 입력해주세요.");
			$(".result-pw").css("color", "black");
		}
		$(".result-pw").html("8자리 ~ 20자리 이내로 입력해주세요.");
		$(".result-pw").css("color", "#97000F");
	} else if(changePassword.search(/\s/) != -1) {
		$(".result-pw").html("공백없이 입력해주세요.");
		$(".result-pw").css("color", "#97000F");
	} else if(num < 0 || eng < 0 || spe < 0) {
		$(".result-pw").html("영문, 숫자, 특수문자를 혼합해서 입력해주세요.");
		$(".result-pw").css("color", "#97000F");
	} else {
		$(".result-pw").html("사용하실 수 있는 비밀번호 입니다.");
		$(".result-pw").css("color", "#3F0B9F");
	}
});

function changePwCheck() {
	var changePassword = $("#changePassword").val();
	var changePasswordCheck = $("#changePasswordCheck").val();
	var data = {"changePassword" : changePassword, "changePasswordCheck" : changePasswordCheck};
	var result;
	$.ajax({
		url : "/main/mypage/changePwCheck",
		type : "post",
		data : data,
		dataType : "json",
		async: false,
		success : function(passwordCheckResult) { // Controller에서 넘어온 값
			if(passwordCheckResult == false){
				$(".check-result-pw").html("비밀번호가 일치하지 않습니다.");
				$(".check-result-pw").css("color", "#97000F");
				result = false;
			} else {
				$(".check-result-pw").html("비밀번호가 일치합니다.");
				$(".check-result-pw").css("color", "#3F0B9F");
				result = true;
			}
		},
		error : function() {
			alert("에러입니다.");
		}
	});
	console.log("passwordCheckResult : " + result);
	return result;
}

function formSubmit() {
	var changePassword = $("#changePassword").val();
	
	if(!check_pw(changePassword)) {
		return false;
	} else if(!changePwCheck()) {
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	} else {
		return true;
	}
}