<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/buttonCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/login.css">
<title>로그인 : 전국 박물관 안내소</title>
</head>
<%@include file="../includes/header.jsp" %>
<body>
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
				<div class="join-content">
					<div class="login-content">
						<div class="login-title">
							<img src="/resources/img/login_icon.png">
							<div class="login-t">					
								<p class="login-t-p1">Login</p>
								<p class="login-t-p2">로그인 정보를 입력해 주세요.</p>
							</div>
						</div>
							<form action="/main/login" class="form-login" method="post">
								<table class="table-login">
									<tbody>
										<tr>
											<th scope="row">
												<p class="tr-p"><label for="memberId">아이디</label></p>
											</th>
											<td>
												<input type="text" id="memberId" name="memberId">
											</td>
										</tr>
										<tr>
											<th scope="row">
												<p class="tr-p"><label for="memberPassword">비밀번호</label></p>
											</th>
											<td>
												<input type="password" id="memberPassword" name="memberPassword">
											</td>
											<td class="desktop-td-btn">
												<button type="submit" class="btn-submit btn-login">로그인</button>
											</td>
										</tr>
										<c:if test="${result == 0}">
											<tr>
												<th scope="row"></th>
												<td><span class="login-warn">아이디 또는 비밀번호가 일치하지 않습니다.</span></td>
											</tr>
										</c:if>
									</tbody>
								</table>
								<div class="mobile-td-btn">
									<button type="submit" class="btn-submit btn-login">로그인</button>
								</div>
							</form>
					</div>
					<div class="btn-area">
						<button type="button" class="btn-submit" onclick="location.href='/main/join/joinEmailCheck'">회원가입</button>
						<button type="button" class="btn-submit" onclick="location.href='/main/recover/recoverMemberId'">아이디 찾기</button>
						<button type="button" class="btn-submit" onclick="location.href='/main/recover/recoverMemberPassword'">비밀번호 찾기</button>
					</div>
					<div class="join-info-box">
						<p>전국 박물관 안내소에 회원가입을 하시면 다음과 같은 혜택을 누릴 수 있습니다.</p>
						<ul>
							<li>마이페이지를 통해 회원님의 맞춤정보를 제공합니다.</li>
							<li>로그인 후 사용하는 서비스에 별도로 개인정보를 입력하실 필요가 없습니다.</li>
							<c:out value="${error}"/>
							<c:out value="${logout}"/>
						</ul>
					</div>
				</div>
			</div>
	</div>
	<!--
	<c:if test="${needLogin == 0}">
		<script type="text/javascript">
			alert("로그인이 필요합니다.");
		</script>
	</c:if>
	-->
</body>
<%@include file="../includes/footer.jsp" %>
<script src="/resources/js/common.js"></script>
<script src="/resources/js/main/login.js"></script>
</html>