<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/buttonCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/join/joinCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/join/joinSuccess.css">
<title>회원 가입 완료 : 전국 박물관 안내소</title>
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
						<a href="/main/login">로그인</a>
					</li>
				</ul>
			</div>
			<h2 class="page-title"><strong>로그인</strong></h2>	
		</div>
		<div class="page-content">
			<div class="desktop-join-step">
				<img src="/resources/img/join/bg_join04_on.png">
			</div>
			<div class="mobile-join-step">
				<img src="/resources/img/join/m_bg_join04_on.png">
			</div>
			<div class="join-step-content">
				<div class="joinSuccess-info-box1">
					<p id="p1">전국 박물관 안내소</p>
					<p id="p2">인터넷 회원가입을 축하드립니다</p>
					<p id="p3">회원님의 <strong>아이디</strong>는 <span>${memberId}</span> 입니다.</p>
				</div>
			</div>
			<div class="joinSuccess-info-box2">
				<ul>
					<li>마이페이지를 통해 회원님의 맞춤정보를 제공합니다.</li>
					<li>로그인 후 사용하는 서비스에 별도로 개인정보를 입력하실 필요가 없습니다.(단, 로그인이 되어있는 경우)</li>
					<li>회원가입 즉시 회원 서비스를 받으실 수 있습니다.</li>
				</ul>
				<div class="btn-area">
					<button type="button" class="btn-submit" onclick="location.href='/main/login'">로그인</button>
					<button type="button" class="btn-submit btn-black" onclick="location.href='/main/main'">메인화면으로 이동</button>
				</div>
			</div>
		</div>	
	</div>
</body>
<%@include file="../../includes/footer.jsp" %>
<script src="/resources/js/common.js"></script>
<script src="/resources/js/join/joinCommon.js"></script>
<script src="/resources/js/join/joinSuccess.js"></script>
</html>
