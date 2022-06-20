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

function checkId() {
	let memberId = $("#memberId").val();
	let len = $("#memberId").val().length;
	let min = 4;
	let max = 12;
	var result;
	$.ajax({
		url : "/main/join/idCheck",
		type : "post",
		data : {memberId : memberId},
		dataType : "json",
		async: false,
		success : function(idRes) { // Controller에서 넘어온 값
			console.log("idRes : " + idRes);
			if(idRes == 2) { // 정규식 표현에 맞지 않는 경우. (ex : 특수문자가 존재 또는 공백만 입력)
				$(".result-id").html("사용하실 수 없는 아이디 입니다.");
				$(".result-id").css("color", "#97000F");
				result = 2;
			} else if(idRes == 1){ // 중복된 아이디가 존재 (개수가 1개)
				$(".result-id").html("이미 사용중인 아이디 입니다.");
				$(".result-id").css("color", "#97000F");
				result = 1;
			} else {
				console.log("checkId len : " + len);
				if(len == 0) { // 입력하지 않았을 때
					$(".result-id").html("아이디를 입력해 주세요.");
					$(".result-id").css("color", "black");
					result = 3;
				} else if(min > len) { // 입력한 아이디가 4자리 미만
					$(".result-id").html("사용하실 수 없는 아이디 입니다.");
					$(".result-id").css("color", "#97000F");
					result = 2;
				} else if(max < len) { // 입력한 아이디가 12자리 초과
					$(".result-id").html("사용하실 수 없는 아이디 입니다.");
					$(".result-id").css("color", "#97000F");
					result = 2;
				} else { 
					$(".result-id").html("사용하실 수 있는 아이디 입니다.");
					$(".result-id").css("color", "#3F0B9F");
					result = 0;
				}
			}
		},
		error : function() {
			alert("에러입니다.");
		}
	});
	console.log("result : " + result);
	return result;
}

function reg_checkId(memberId) {
	let idRegExp = /^[a-zA-z0-9]{4,12}$/;
	if(!idRegExp.test(memberId)) {
		alert("아이디는 4자~12자 이내의 영문과 숫자로 공백 없이 입력하셔야 됩니다.");
        $("#memberId").val("");
        return false;
	}
	return true;
}
	
function reg_checkPw(memberPassword) {
	let password1RegExp = /^(?=.*[a-zA-Z])(?=.*[`~!@@#$%^&*|₩₩₩'₩";:₩/?])(?=.*[0-9]).{8,20}$/;
	
	if(!password1RegExp.test(memberPassword)) {
		alert("비밀번호는 영어와 특수문자, 숫자를 하나씩 포함한 8~20자리로 입력하셔야 됩니다.");
        return false;
	}
	return true;
}
	
$("#memberPassword").on("propertychange change keyup paste input", function() {
	let memberPassword = $("#memberPassword").val();
	let len = $("#memberPassword").val().length;
	// 유효성 검사 정규식 (숫자, 영어, 특문)
	let num = memberPassword.search(/[0-9]/g);
	let eng = memberPassword.search(/[a-z]/ig);
	let spe = memberPassword.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	
	if(len < 8 || len > 20) {
		if(len == 0) {
			$(".result-pw").html("비밀번호를 입력해주세요.");
			$(".result-pw").css("color", "black");
		}
		$(".result-pw").html("8자리 ~ 20자리 이내로 입력해주세요.");
		$(".result-pw").css("color", "#97000F");
	} else if(memberPassword.search(/\s/) != -1) {
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

function checkPw() {
	var memberPassword = $("#memberPassword").val();
	var memberPasswordChk = $("#memberPasswordChk").val();
	var data = {"memberPassword" : memberPassword, "memberPasswordChk" : memberPasswordChk};
	var result;
	$.ajax({
		url : "/main/join/pwCheck",
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

function checkPhone() {
	var memberPhone = $("#memberPhone1").val() + "-" + $("#memberPhone2").val() + "-" + $("#memberPhone3").val();
	$("#memberPhone").val(memberPhone);
	
	var result;
	$.ajax({
		url : "/main/join/phoneCheck",
		type : "post",
		data : {memberPhone : memberPhone},
		dataType : "json",
		async: false,
		success : function(res) { // Controller에서 넘어온 값
			console.log("checkPhone res : " + res);
			console.log(memberPhone);
			if(res == 0) {
				console.log("가입 가능한 핸드폰 번호 입니다.");
				result = true;
			} else {
				console.log("가입 불가능한 핸드폰 번호 입니다.");
				result = false;
			}
		},
		error : function() {
			alert("에러입니다.");
		}
	});
	console.log("checkPhoneResult : " + result);
	return result;
}

function reg_checkPhone(memberPhone2, memberPhone3) {
	let phoneRegExp2 = /^([0-9]{3,4})$/;
	let phoneRegExp3 = /^([0-9]{4})$/;
	
	if(!phoneRegExp2.test(memberPhone2)) {
		console.log("phoneRegExp2.test : false");
		alert("핸드폰번호 입력이 올바르지 않습니다(2).");
		$("#memberPhone2").val("");
		return false;
	} else if(!phoneRegExp3.test(memberPhone3)) {
		console.log("phoneRegExp3.test : false");
		alert("핸드폰번호 입력이 올바르지 않습니다(3).");
		$("#memberPhone3").val("");
		return false;
	}
	return true;
}

function checkGender() {
	if(!$("input[type=radio][name=memberGender]").is(":checked")) {
		alert("성별을 체크해 주세요.");
		return false;
	}
	return true;
}
	
function formSubmit() {
	let memberPhone1 = $("#memberPhone1").val();
	let memberPhone2 = $("#memberPhone2").val();
	let memberPhone3 = $("#memberPhone3").val();
	let memberPhone = memberPhone1 + "-" + memberPhone2 + "-" + memberPhone3;
	$("#memberPhone").val(memberPhone);
	
	if (!checkName()) {
		return false;
	}  else if(checkId() == 3) {
		alert("아이디를 입력해 주세요.");
		return false;
	} else if(checkId() == 2) {
		alert("사용하실 수 없는 아이디 입니다.");
		return false;
	} else if(checkId() == 1) {
		alert("이미 사용중인 아이디 입니다.");
		return false;
	} else if(!reg_checkId($("#memberId").val())) {
		return false;
	} else if(!reg_checkPw($("#memberPassword").val(), $("#memberPasswordChk").val())) {
		return false;
	} else if(!reg_checkPhone($("#memberPhone2").val(), $("#memberPhone3").val())) {
		return false;
	} else if(!checkPhone()) {
		alert("이미 가입된 핸드폰번호 입니다.");
		return false;
	} else if(!checkPw()) {
		alert("비밀번호를 확인해 주세요.");
		return false;
	} else if(!checkGender()) {
		return false;
	} else {
		return true;
	}
}