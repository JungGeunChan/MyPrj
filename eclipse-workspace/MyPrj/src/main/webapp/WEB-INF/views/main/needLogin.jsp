<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/needLogin.css">
<title>로그인이 필요한 서비스 : 전국 박물관 안내소</title>
</head>
<%@include file="../includes/header.jsp" %>
<body>
	<div class="page-wrapper">
			<div class="page-header">
				
			</div>
			<div class="page-content">
				<div class="join-content">
					<div class="login-content">
						<div class="login-title">
							<img src="/resources/img/login_icon.png">
							<div class="login-t">					
								<p class="login-p1"><strong>로그인이 필요한 서비스입니다.</strong></p>
								<p class="login-p2">서비스를 이용하시려면 로그인을 선택해주세요.</p>
							</div>
						</div>
						<div class="login-box">
							<a href="/main/login">로그인</a>
						</div>
					</div>
				</div>
			</div>
		
	</div>
</body>
<%@include file="../includes/footer.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		var thisWidth = $(".page-wrapper").width();
		var maxWidth = 1351;
		var res = maxWidth * 45 / 100;
		
		if(thisWidth < res) { // 최초 실행시 브라우저 크기가 전체의 45%보다 작을 떄
			$(".join-content").css({"width" : "100%", "margin" : "0"});
			$(".login-content").css({"width" : "100%", "margin": "0"});
			$(".login-title").css({"display" : "block", "text-align" : "center"});
			$(".login-t").css({"width" : "100%", "margin" : "0", "padding" : "0"});
			$(".login-p1").css({"font-size" : "2em", "margin-top" : "5%"});
		} else {
			$(".join-content").css({"width" : "80%", "margin" : "0 auto"});
			$(".login-content").css({"width" : "65%", "margin" : "0 auto"});
			$(".login-title").css({"display" : "flex", "width" : "100%", "text-align" : "left"});
			$(".login-t").css({"flex" : "80%", "width" : "80%", "padding-left" : "7%", "vertical-align" : "top"});
			$(".login-p1").css({"font-size" : "2.5em", "margin" : "2% 0 4% 0"});
		}
	});
	
	$(window).resize(function() {
		var maxWidth = 1351;
		var width = $(".join-content").width();
		var res = maxWidth * 45 / 100; // 전체 크기의 45%
		if(width <= res) { // 줄어들었을 때
			$(".join-content").css({"width" : "100%", "margin" : "0"});
			$(".login-content").css({"width" : "100%", "margin": "0"});
			$(".login-title").css({"display" : "block", "text-align" : "center"});
			$(".login-t").css({"width" : "100%", "margin" : "0", "padding" : "0"});
			$(".login-p1").css({"font-size" : "2em", "margin-top" : "5%"});
		} else { // 늘어났을 때
			$(".join-content").css({"width" : "80%", "margin" : "0 auto"});
			$(".login-content").css({"width" : "65%", "margin" : "0 auto"});
			$(".login-title").css({"display" : "flex", "width" : "100%", "text-align" : "left"});
			$(".login-t").css({"flex" : "80%", "width" : "80%", "padding-left" : "7%", "vertical-align" : "top"});
			$(".login-p1").css({"font-size" : "2.5em", "margin" : "2% 0 4% 0"});
		}
	});
</script>
</html>