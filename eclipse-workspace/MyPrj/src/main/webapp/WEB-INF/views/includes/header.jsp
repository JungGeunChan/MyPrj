<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css" href="/resources/css/includes/header.css">
<style>
@import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap');
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="/resources/js/includes/header.js"></script>
</head>
<body class="body">
	<header class="desktop-header">
		<div class="desktop-head">
			<div class="desktop-header-title">
				<h1 id="desktop-header-logo">
					<a href="/main/main">
						<img id="desktop-img-header-logo" src="/resources/img/header_logo.png" alt="홈페이지아이콘">
					</a>
				</h1>
			</div>
			<div class="desktop-topMenu-wrap">
				<ul class="desktop-topMenu-bar">
					<li>
						<strong>홈</strong>
						<div class="desktop-subMenu-wrap">
							<ul class="desktop-subMenu-bar">
								<li><a href="/main/intro">홈페이지 소개</a></li>
							</ul>
						</div>
					</li>
					<li>
						<strong>박물관 테마</strong>
						<div class="desktop-subMenu-wrap">
							<ul class="desktop-subMenu-bar">
								<li><a href="/museum/museumSearch">검색</a></li>
							</ul>
						</div>
					</li>
					<li>
						<strong>관리자</strong>
						<div class="desktop-subMenu-wrap">
							<ul class="desktop-subMenu-bar">
								<li><a href="/admin/adminRead">박물관 정보 관리</a></li>
							</ul>
						</div>
					</li>
				</ul>
			</div>
				<c:if test="${member == null}">
					<div class="desktop-login">
						<a href="/main/login" id="desktop-login-link">로그인</a>
						<a href="/main/join/joinEmailCheck" id="desktop-join-link">회원가입</a>
					</div>
				</c:if>
				<c:if test="${member != null}">
					<div class="desktop-logout">
						<span><strong>${member.memberId}</strong>님 방문을 환영합니다.</span>
						<a href="/main/logout" id="desktop-logout-link">로그아웃</a>
						<a href="/main/mypage/update" id="desktop-mypage-link">마이페이지</a>
					</div>
				</c:if>
		</div>
	</header>
	
	<header class="mobile-header">
		<div class="mobile-head">
			<div class="mobile-header-title">
				<h1 id="mobile-header-logo">
					<a href="/main/main">
						<img id="mobile-img-header-logo" src="/resources/img/header_logo.png" alt="홈페이지아이콘">
					</a>
				</h1>
			</div>
			<div class="mobile-menu">
				<img id="mobile-menubar-icon" src="/resources/img/menubar_icon.png" alt="메뉴">
			</div>
			<div class="mobile-topMenu-wrap">
				<div class="mobile-login">
					<c:if test="${member == null}">
						<a class="mobile-login-link" href="/main/login"><strong>로그인</strong></a>
						<a class="mobile-join-link" href="/main/join/joinEmailCheck">회원가입</a>
					</c:if>
					<c:if test="${member != null}">
						<span id="span-memberId"><strong>${member.memberId}</strong></span>
						<div class="mobile-logout">
							<a href="/main/logout" id="mobile-logout-link">로그아웃</a>
							<a href="/main/mypage/update" id="mobile-mypage-link">마이페이지</a>
						</div>
					</c:if>
				</div>
				<ul class="mobile-topMenu-bar">
					<li>
						<div class="mobile-topMenu-title">
							<a href="#">
								<strong>홈</strong>
								<img class="ico_lg_open" src="/resources/img/ico_lg_black_open.png">
								<img class="ico_lg_close" src="/resources/img/ico_lg_black_close.png">
							</a>
						</div>
						<div class="mobile-subMenu-wrap">
							<ul class="mobile-subMenu-bar">
								<li><a href="/main/intro">홈페이지 소개</a></li>
							</ul>
						</div>
					</li>
					<li>
						<div class="mobile-topMenu-title">
							<a href="#">
								<strong>박물관 테마</strong>
								<img class="ico_lg_open" src="/resources/img/ico_lg_black_open.png">
								<img class="ico_lg_close" src="/resources/img/ico_lg_black_close.png">
							</a>
						</div>
						<div class="mobile-subMenu-wrap">
							<ul class="mobile-subMenu-bar">
								<li><a href="/museum/museumSearch">검색</a></li>
							</ul>
						</div>
					</li>
					<li>
						<div class="mobile-topMenu-title">
							<a href="#">
								<strong>관리자</strong>
								<img class="ico_lg_open" src="/resources/img/ico_lg_black_open.png">
								<img class="ico_lg_close" src="/resources/img/ico_lg_black_close.png">
							</a>
						</div>
						<div class="mobile-subMenu-wrap">
							<ul class="mobile-subMenu-bar">
								<li><a href="/admin/adminRead">박물관 정보 관리</a></li>
							</ul>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</header>
</body>
</html>