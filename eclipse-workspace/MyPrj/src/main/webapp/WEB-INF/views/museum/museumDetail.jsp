<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>박물관 상세 : 전국 박물관 안내소</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/buttonCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/swiper-bundle.min.css">
<link rel="stylesheet" type="text/css" href="/resources/css/museum/museumDetail.css">
<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
</head>
<%@include file="../includes/header.jsp" %>
<body class="body">
	<div class="page-wrapper">
		<div class="page-header">
			<div class="nav-location">
				<ul>
					<li class="home">
						<a href="/main/main"><img src="/resources/img/icon1.png"></a>
					</li>
					<li>
						<a href="#">박물관 테마</a>
					</li>
					<li>
						<a href="/museum/museumSearch">검색</a>
					</li>
				</ul>
			</div>
			<h2 class="page-title"><strong>박물관 상세정보</strong></h2>
		</div>
		
		<div class="page-content">
			<div class="div-result">
				<div class="swiper-container">
					<div class="swiper-wrapper"></div>
					<div class="visual-pagination">
						<div class="swiper-pagination"></div>
					</div>								
					<div class="swiper-button-prev-unique"></div>
					<div class="swiper-button-next-unique"></div>
				</div>
				<table class="admin-table">
					<tbody>	
						<tr>
							<th scope="row">박물관 이름</th>
							<td>
								<c:out value="${list.museumName}"></c:out>
							</td>
						</tr>
						<tr>
							<th scope="row">박물관 주소</th>
							<td><c:out value="${list.museumAddress}"></c:out></td>
						</tr>
						<tr>
							<th scope="row">박물관 전화번호</th>
							<td><c:out value="${list.museumTel}"></c:out></td>
						</tr>
						<tr>
							<th scope="row">박물관 홈페이지</th>
							<td>
								<a href="<c:url value="${list.museumHomepage}"></c:url>" target="_blank">
									<c:out value="${list.museumHomepage}"></c:out>
								</a>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="btn-area">
				<button data-oper="main" class="btn-submit btn-black" onclick="location.href='/main/main'">메인으로</button>
				<button data-oper="list" class="btn-submit" onclick="location.href='/museum/museumSearch'">검색으로</button>
			</div>
	
			<form id="operForm" action="/museum/museumSearch" method="get">
				<c:forEach items="${themeList}" var="cri">
					<input type="hidden" name="themeList" value="<c:out value="${cri}"/>">
				</c:forEach>
				<c:forEach items="${areaList}" var="cri">
					<input type="hidden" name="areaList" value="<c:out value="${cri}"/>">
				</c:forEach>
				<input type="hidden" name="pageNum" value="${cri.pageNum}">
				<input type="hidden" name="amount" value="${cri.amount}">
			</form>
		</div>
	</div>
</body>
<%@include file="../includes/footer.jsp" %>
<script src="/resources/js/common.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	(function() {
		var museumNo = '<c:out value="${list.museumNo}"/>';
		console.log(museumNo);
		
		$.getJSON("/admin/getAttachList", {museumNo : museumNo}, function(arr) {
			console.log("arr : ");
			console.log(arr);
			
			var str = "";
			
			var length = $(arr).length;
			console.log("길이 : " + length);
			
			if(length == 1) {
				$(".swiper-button-prev-unique, .swiper-button-next-unique").hide();
			}
			
			$(arr).each(function(i, obj) {
				console.log(obj.museumImgUploadPath);
				if(obj.museumImgFileType) {
					var museumImgFileCallPath = encodeURIComponent(obj.museumImgUploadPath + "/s_" + obj.museumImgUuid + "_" + obj.museumImgFileName);
					
					str += "<div class='swiper-slide' data-path='" + obj.museumImgUploadPath+ "'";
					str += " data-uuid = '" + obj.museumImgUuid + "' data-filename='" + obj.museumImgFileName + "' data-type='" + obj.museumImgFileType+ "'";
					str += " >";
					str += "<img class='slides-img-main' src='/admin/display?museumImgFileName=" + museumImgFileCallPath+"'>";
					str += "</div>";
				} else {
					console.log("이미지 파일이 아님");
				}
			});
			$(".swiper-wrapper").html(str);
		});
	})();
	
	var pageNum = $("input[name='pageNum']").val();
	var amount = $("input[name='amount']").val();
	var themeList = $("input[name='themeList']").val();
	var areaList = $("input[name='areaList']").val();
	
	console.log("pageNum : " + pageNum);
	console.log("amount : " + amount);
	console.log("themeList : " + themeList);
	console.log("areaList : " + areaList);
	
	var operForm = $("#operForm");
	
	$("button").on("click", function(e) {
		e.preventDefault();
		
		var operation = $(this).data("oper");
		console.log("operation : " + operation);
		
		if(operation === "list") {
			operForm.attr("action", "/museum/museumSearch");
			operForm.submit();
		}
	});
});

let swiper = new Swiper(".swiper-container", {
	slidesPerView : 1,
	spaceBetween : 30,
	loop : true,
	centeredSlides : true,
	speed : 1000,
	pagination : {
		el : ".swiper-pagination",
		clickable : true,
	},
	navigation : {
		nextEl : ".swiper-button-next-unique",
		prevEl : ".swiper-button-prev-unique"
	}
});
</script>
</html>