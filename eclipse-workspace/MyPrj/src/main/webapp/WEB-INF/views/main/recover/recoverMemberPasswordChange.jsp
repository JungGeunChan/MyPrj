<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/buttonCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/mypage/mypageCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/recover/recoverMemberCommon.css">
<style type="text/css">
.result-pw, .check-result-pw {
	margin : 0;
}
</style>
<title>아이디 찾기 : 전국 박물관 안내소</title>
</head>
<body>
<%@include file="../../includes/header.jsp" %>
	<div class="page-wrapper">
		<div class="page-header">
			<div class="nav-location">
				<ul>
					<li class="home">
						<a href="/main/main"><img src="/resources/img/icon1.png"></a>
					</li>
					<li>
						<a href="/main/recover/recoverMemberPassword">비밀번호 찾기</a>
					</li>
				</ul>
			</div>
			<h2 class="page-title"><strong>비밀번호 찾기</strong></h2>
		</div>
		<div class="page-content">
			<div class="recoverMember-content-header">
				<div class="recoverMember-title">
					<img src="/resources/img/mypage/ico_login_find_img.png">
					<p id="p3"><strong>새로운 비밀번호를 입력하시고 <span>[저장]</span>버튼을 눌러주세요.</strong></p>
				</div>
			</div>
			<form class="frm-passwordUpdate" action="/main/recover/recoverMemberPasswordChange" method="post">
				<input type="hidden" name="memberEmail" value="${memberEmail}"/>
				<div class="frm-recoverMember-inner-div">
					<table class="recoverMember-table">
						<tbody>
							<tr>
								<th scope="row"><p>새로운 비밀번호</p></th>
								<td>
									<input type="password" id="changePassword" name="changePassword">
								</td>
							</tr>
							<tr>
								<th scope="row"></th>
								<td>
									<p class="result-pw">비밀번호를 입력해 주세요.</p>
								</td>
							</tr>
							<tr>
								<th scope="row"><p>비밀번호 확인</p></th>
								<td>
									<input type="password" id="changePasswordChk" name="changePasswordChk">
								</td>
							</tr>
							<tr>
								<th scope="row"></th>
								<td>
									<p class="check-result-pw">비밀번호를 입력해 주세요.</p>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="btn-area">
					<button type="submit" class="btn-submit">저장</button>
				</div>
			</form>
		</div>
	</div>
</body>
<%@include file="../../includes/footer.jsp" %>

<script src="/resources/js/common.js"></script>
<script src="/resources/js/main/mypage/mypageCommon.js"></script>
<script src="/resources/js/main/recover/recoverMemberCommon.js"></script>
<script src="/resources/js/main/recover/recoverMemberPasswordChange.js"></script>
<script type="text/javascript">
function check_pw(changePassword, changePasswordchk) {
	var password1RegExp = /^(?=.*[a-zA-Z])(?=.*[`~!@@#$%^&*|₩₩₩'₩";:₩/?])(?=.*[0-9]).{8,20}$/;
	
	if(!password1RegExp.test(changePassword)) {
		alert("비밀번호는 영어와 특수문자, 숫자를 하나씩 포함한 8~20자리로 입력하셔야 됩니다.");
        return false;
	} else if (changePassword != changePasswordchk) {
		alert("변경하려는 비밀번호가 일치하지 않습니다.");
		return false;
	}
	return true;
}

$(".btn-submit").on("click", function (changePassword, changePasswordchk) {
	
	var changePassword = $("#changePassword").val();
	var changePasswordChk = $("#changePasswordChk").val();
	
	if(!check_pw(changePassword, changePasswordChk)) {
		return false;
	} else {
		$(".frm-passwordUpdate").submit();
	}
});

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

$("#changePasswordChk").on("propertychange change keyup paste input", function() {
	var changePassword = $("#changePassword").val();
	var changePasswordChk = $("#changePasswordChk").val();
		
	if(changePassword != '' && changePasswordChk != '') {			
		if(changePassword == changePasswordChk) { // 1. 같을 때
			$(".check-result-pw").html("비밀번호가 일치합니다.");
			$(".check-result-pw").css("color", "#3F0B9F");
		} else { // 2. 다를 때
			$(".check-result-pw").html("비밀번호가 일치하지 않습니다.");
			$(".check-result-pw").css("color", "#97000F");
		}
	} else { // 3. 입력하지 않았을 떄
		$(".check-result-pw").html("비밀번호를 입력해 주세요.");
		$(".check-result-pw").css("color", "black");
	}
});	
</script>