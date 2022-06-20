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
<link rel="stylesheet" type="text/css" href="/resources/css/main/recover/recoverMemberIdSuccess.css">

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
						<a href="/main/recover/recoverMemberId">아이디 찾기</a>
					</li>
				</ul>
			</div>
			<h2 class="page-title"><strong>아이디 찾기</strong></h2>
		</div>
		<div class="page-content">
			<div class="recoverMember-page-content-wrapper">
				<div class="recoverMember-content-header">
					<div class="recoverMember-title">
						<img src="/resources/img/mypage/ico_login_find_img.png">
						<p id="recoverMemberId-Result"><span><c:out value="${memberName}"></c:out></span>님의 아이디는 <span><c:out value="${memberId}"></c:out></span>입니다.</p>
					</div>
					<div>
						<p>개인정보 보안을 위해서 전체 아이디는 가입하신 이메일로 전송하였습니다.</p>
						<p>전송한 이메일 : <c:out value="${receiveEmail}"></c:out></p>
					</div>
				</div>

				
				<div class="btn-area">
					<button type="button" class="btn-submit" onclick="location.href='/main/login'">로그인</button>
					<button type="button" class="btn-submit" onclick="location.href='/main/recover/recoverMemberPassword'">비밀번호 찾기</button>
					<button type="button" class="btn-submit btn-black" onclick="location.href='/main/main'">메인화면으로 이동</button>
				</div>
			</div>
		</div>
	</div>
	
	<c:if test="${result == false}">
		<script type="text/javascript">
			alert("입력하신 회원정보와 일치하는 아이디가 없습니다.");
		</script>
	</c:if>
</body>
<%@include file="../../includes/footer.jsp" %>

<script src="/resources/js/common.js"></script>