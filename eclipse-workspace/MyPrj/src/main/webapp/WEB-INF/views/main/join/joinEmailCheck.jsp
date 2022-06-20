<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/buttonCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/join/joinCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/join/joinEmailCheck.css">
<title>가입 여부 확인 : 전국 박물관 안내소</title>
</head>
<%@include file="../../includes/header.jsp" %>
<body class="body">
	<div class="page-wrapper">
		<div class="page-header">
			<div class="nav-location">
				<ul>
					<li class="home">
						<a href="/main/main"><img src="/resources/img/icon1.png"></a>
					</li>
					<li>
						<a href="#">마이페이지</a>
					</li>
					<li>
						<a href="/main/join/joinEmailCheck">회원가입</a>
					</li>
				</ul>
			</div>
			<h2 class="page-title"><strong>회원가입</strong></h2>
		</div>
		
		<div class="page-content">
			<div class="desktop-join-step">
				<img src="/resources/img/join/bg_join01_on.png">
			</div>
			<div class="mobile-join-step">
				<img src="/resources/img/join/m_bg_join01_on.png">
			</div>
			<div class="join-step-content">
				<p>가입여부확인을 위하여 <span>이메일 주소</span>를 입력하시고 중복확인을 해주세요.</p>
				<ul class="email-input">
					<li class="first">이메일주소</li>
					<li class="second">
						<form class="frm-email" action="/main/join/joinEmailCheck" method="post" onsubmit="return formSubmit()">
							<input type="email" id="memberEmail" name="memberEmail">
							<button type="submit" class="btn-submit">중복확인</button>
						</form>
						<c:if test="${chkEmailResult == 1}">
							<div class="login-warn">이메일 주소가 중복되었습니다.</div>
							<script type="text/javascript">
								alert("이메일 주소가 중복되었습니다.");
							</script>
						</c:if>
					</li>
				</ul>
				
				<div class="btn-area">
					<button type="button" class="btn-submit" onclick="location.href='/main/login'">로그인</button>
					<button type="button" class="btn-submit" onclick="location.href='/main/recover/recoverMemberId'">아이디 찾기</button>
					<button type="button" class="btn-submit" onclick="location.href='/main/recover/recoverMemberPassword'">비밀번호 찾기</button>
				</div>
			</div>
		</div>
	</div>
</body>
<%@include file="../../includes/footer.jsp" %>
<script src="/resources/js/common.js"></script>
<script src="/resources/js/join/joinCommon.js"></script>



<script type="text/javascript">
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
		}
		return true;
	}
	
	function formSubmit() {
		if(!reg_checkEmail($("#memberEmail").val())) {
			return false;
		}
		return true;
	}

</script>
</html>