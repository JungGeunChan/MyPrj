<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/buttonCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/join/joinCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/join/joinMemberAgreement.css">
<title>이용 약관 확인 : 전국 박물관 안내소</title>
</head>
<body class="body">
<%@include file="../../includes/header.jsp" %>
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
				<img src="/resources/img/join/bg_join02_on.png">
			</div>
			<div class="mobile-join-step">
				<img src="/resources/img/join/m_bg_join02_on.png">
			</div>
			<div class="join-step-content">
				<form class="form-agreement" action="/main/join/joinMemberAgreement" method="post">
					<div class="agreement-content">
						<div class="content-title">
							<h3>이용약관</h3>
						</div>
						<div class="groupbox">
							<div class="groupbox-content">
								<h4>Developement Enviroment</h4>
								<h5>Commons</h5>
								<ol>
									<li>Operating System : Windows11</li>
									<li>Source Tools : Eclipse IDE (2022-03)</li>
									<li>WAS : Apache Tomcat v9.0
									<li>Database : Oracle Database 11g XE</li>
								</ol>
								<h5>Frontend</h5>
								<ol>
									<li>Language : HTML5, CSS3, Javascript</li>
									<li>Framework : Jquery, Ajax</li>
								</ol>s
								<h5>Backend</h5>
								<ol>
									<li>Language : JavaSE-11, XML</li>
									<li>Framework : Spring4, MyBatis, Lombok, HikariCP</li>
								</ol>
							</div>
							<div class="agreeLbl">
								<input type="checkbox" id="serviceAgreement" name="serviceAgreement" value="true">
								<label for="serviceAgreement">[필수 항목] 서비스 제공을 위한 필수 사항이므로 동의 거부 시 회원가입이 불가합니다. 위 사항에 동의하십니까?</label>
							</div>
						</div>
						<div class="content-title">
							<h3>개인정보 취급방침</h3>
						</div>
						<div class="groupbox">
							<div class="groupbox-content">
								<h4>프로젝트 소개</h4>
								<h5>소개1</h5>
								<ol>
									<li>가나다라마바사아자차카타파하</li>
									<li>가나다라마바사아자차카타파하</li>
								</ol>
								<h5>소개2</h5>
								<ol>
									<li>가나다라마바사아자차카타파하</li>
									<li>가나다라마바사아자차카타파하</li>
								</ol>
							</div>
							<div class="agreeLbl">
								<ul class="agreeLbl-ul">
									<li>
										<div class="agreeLbl-div">
											<p>[필수 항목] 개인정보 취급 방침에 동의하십니까?</p>
											<input type="radio" id="privacyAgreement1" name="privacyAgreement" value="true">
											<label for="privacyAgreement1">동의함</label>
											<input type="radio" id="privacyAgreement2" name="privacyAgreement" value="false">
											<label for="privacyAgreement2">동의하지 않음</label>
										</div>
									</li>
								</ul>
							</div>
						</div>
						<div class="btn-area">
							<a href="javascript:formSubmit();" class="btn-submit">네, 동의합니다.</a>
							<button type="button" class="btn-submit btn-black" onclick="location.href='/main/main'">아니오, 동의하지 않습니다.</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<%@include file="../../includes/footer.jsp" %>
<script src="/resources/js/common.js"></script>
<script src="/resources/js/join/joinCommon.js"></script>
<script src="/resources/js/join/joinMemberAgreement.js"></script>
</html>