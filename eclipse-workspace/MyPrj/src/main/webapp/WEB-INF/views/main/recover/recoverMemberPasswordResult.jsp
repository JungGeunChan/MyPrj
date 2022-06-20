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
<link rel="stylesheet" type="text/css" href="/resources/css/main/recover/recoverMemberPasswordResult.css">


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
					<p id="p3"><strong>전송받으신 인증번호를 입력해주세요.</strong></p>
				</div>
			</div>
			<form class="frm-recoverMember" action="/main/recover/recoverMemberPasswordResult" method="post">
				<div class="frm-innerDiv">
					<input type="hidden" name="encodeCertNumber" value="${encodeCertNumber}"/>
					<input type="text" id="input-certNumber" name="inputCertNumber"/>
				</div>
				<div class="btn-area">
					<button type="submit" class="btn-submit">확인</button>
				</div>
			</form>
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
<script src="/resources/js/main/mypage/mypageCommon.js"></script>
<script src="/resources/js/main/recover/recoverMemberCommon.js"></script>