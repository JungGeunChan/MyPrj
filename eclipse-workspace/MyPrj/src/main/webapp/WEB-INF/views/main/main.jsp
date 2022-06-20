<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/main.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/swiper-bundle.min.css">
<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>

<title>메인 : 전국 박물관 안내소</title>
</head>

<%@include file="../includes/header.jsp" %>

<body class="body">
	<div class="page-wrapper">
		<div class="page-content">
			<div class="swiper-container">	<!-- td -->
				<div class="swiper-wrapper"> <!-- uploadResult -->
					<div class="swiper-slide">
						<img id="slides-img-main" src="/resources/img/main/slide_img_main(1).png" alt="첫번째 슬라이드이미지">
					</div>
					<div class="swiper-slide">
						<img id="slides-img-main" src="/resources/img/main/slide_img_main(2).png" alt="두번째 슬라이드이미지">
					</div>
					<div class="swiper-slide">
						<img id="slides-img-main" src="/resources/img/main/slide_img_main(3).png" alt="세번째 슬라이드이미지">
					</div>
					<div class="swiper-slide">
						<img id="slides-img-main" src="/resources/img/main/slide_img_main(4).png" alt="네번째 슬라이드이미지">
					</div>
				</div>
				<div class="visual-pagination">
					<div class="swiper-pagination"></div>
					<div class="controller">
						<button id="btn-slide">
							<img class="btn-stop" src="/resources/img/main/main_btn_stop.png" alt="stop"/>
							<img class="btn-play" src="/resources/img/main/main_btn_play.png" alt="play"/>
						</button>
					</div>
				</div>
				<div class="swiper-button-prev-unique"></div>
				<div class="swiper-button-next-unique"></div>
			</div>
			
			<div class="main-page-inner-content">
				<div class="main-recommend-museum">
					<div class="main-page-inner-content-title-wrap">
						<div class="main-page-inner-content-title">
							<img class="ico_recommend" src="/resources/img/main/ico_recommend.png" alt="추천박물관아이콘">
						</div>
						<div class="main-page-inner-content-title2">
							<ul class="ul-main-page-inner-content">
								<li>추천 박물관</li>
								<li>전국 박물관 안내소에서 무작위로 추천하는 박물관 Top 5 입니다.</li>
							</ul>
						</div>
					</div>
					
					<div class="main-page-inner-content-wrap">
						<ul class="dot">
							<c:forEach items="${list}" var="museumlist">
								<li><a class="move" href="<c:out value='${museumlist.museumNo}'/>"><c:out value="${museumlist.museumName}"></c:out></a></li>
							</c:forEach>
						</ul>
					</div>
				</div>				
			</div>
		</div>
	</div>
	
	<c:if test="${recoverPwResult == true}">
		<script type="text/javascript">
			alert("비밀번호가 변경되었습니다.");
		</script>
	</c:if>
	
	<c:if test="${memberDeleteResult == 1}">
		<script type="text/javascript">
			alert("회원을 탈퇴하였습니다.");
		</script>
	</c:if>
</body>

<%@ include file="../includes/footer.jsp" %>

<script src="/resources/js/main/main.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	for(var i=0; i<=2; i++) {
		$(".dot > li:eq(" + i + ")").attr("class", "top"+(i+1));	
	}
});

$(".move").on("click", function(e) {
	e.preventDefault();
	var museumNo = $(this).attr("href");
	console.log("museumNo : " + museumNo);
	location.href = "/museum/museumDetail?museumNo=" + museumNo;
});

</script>
</html>