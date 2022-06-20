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
<title>비밀번호 찾기 : 전국 박물관 안내소</title>
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
					<span>비밀번호 찾기</span>
					<p>아래 정보를 입력한 후 확인버튼을 클릭하시면 회원가입시 등록하신 이메일로 인증번호를 보내드립니다.</p>
				</div>
			</div>
			
			<form class="frm-recoverMember" action="/main/recover/recoverMemberPassword" method="post" onsubmit="return formSubmit();">
				<div class="frm-recoverMember-inner-div">
					<table class="recoverMember-table">
						<tbody>
							<tr>
								<th scope="row"><p>이름</p></th>
								<td>
									<input type="text" id="memberName" name="memberName">
								</td>
							</tr>
							<tr>
								<th scope="row"><p>아이디</p></th>
								<td>
									<input type="text" id="memberId" name="memberId">
								</td>
							</tr>
							<tr>
								<th scope="row"><p>이메일</p></th>
								<td>
									<input type="text" id="memberEmail" name="memberEmail"/>
								</td>
							</tr>
							<tr>
								<th scope="row"></th>
								<td><p class="tr-p">회원가입시 등록하신 이메일을 입력해 주세요.</p></td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="btn-area">
					<button type="submit" class="btn-submit">확인</button>
				</div>
			</form>
		</div>
	</div>
	
	<c:if test="${result == false}">
		<script type="text/javascript">
			alert("회원정보가 존재하지 않습니다.");
		</script>
	</c:if>
	
</body>
<%@include file="../../includes/footer.jsp" %>
<script src="/resources/js/common.js"></script>
<script src="/resources/js/main/mypage/mypageCommon.js"></script>
<script src="/resources/js/main/recover/recoverMemberCommon.js"></script>
<script src="/resources/js/main/recover/recoverMemberPassword.js"></script>
<script type="text/javascript">
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
	
	//1. 이메일 주소 시작은 숫자나 알파벳(소문자/대문자).
	//2. 이메일 첫째자리 뒤에는 "-" or "_" or "." 을 포함하여 입력가능.
	//3. 도메인 주소 전에는 반드시 @ 입력.
	//4. "." 이 최소한 하나는 있어야 하며 마지막 마디는 2-3자리여야 한다. (ex : jkchappy@naver.com)
	
	var emailRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
	if(!emailRegExp.test(memberEmail)) {
		alert("이메일 형식이 올바르지 않습니다.");
		return false;
	} else {
		return true;
	}
}

function formSubmit() {
	if (!checkName()) {
		return false;
	} else if(!reg_checkEmail($("#memberEmail").val())) {
		return false;
	} else {
		return true;
	}
}
/* 
var code = "";
$(".btn-sendCertNum").on("click", function() {
	var memberName = $("#memberName").val();
	var memberId = $("#memberId").val();
	var memberEmail = $("#memberEmail").val();
	console.log(memberName);
	console.log(memberId);
	console.log(memberEmail);
	
	$.ajax({
		type : "get",
		url : "emailCheck?memberName=" + memberName + "&memberId=" + memberId + "&memberEmail=" + memberEmail,
		success : function(data) {
			console.log("data : " + data);
			if(data == "false") {
				alert("입력하신 정보와 일치하는 회원정보가 존재하지 않습니다.")
			} else {
				code = data;	
			}
		}
	});	
});
 */
function checkCertNum() {
	$(".inputCertNum").blur(function() {
		var inputCode = $(".inputCertNum").val();
		var certNumResult = $("#certNumResult");
		
		if(inputCode == code) {
			certNumResult.html("인증번호가 일치.");
			return true;
		} else {
			certNumResult.html("인증번호가 불일치.");
			return false;
		}
	});
}


/* 
$(".inputCertNum").blur(function() {
	var inputCode = $(".inputCertNum").val();
	var certNumResult = $("#certNumResult");
	
	if(inputCode == code) {
		certNumResult.html("인증번호가 일치.");
	} else {
		certNumResult.html("인증번호가 불일치.");
	}
});
 */
</script>
</html>