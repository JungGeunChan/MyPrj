<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>(관리자)박물관 상세 : 전국 박물관 안내소</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/buttonCommon.css">
<!-- <link rel="stylesheet" type="text/css" href="/resources/css/admin/adminCreate.css"> -->
<link rel="stylesheet" type="text/css" href="/resources/css/admin/adminDetail.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/swiper-bundle.min.css">
<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>

</head>
	<%@include file="../includesAdmin/admin.jsp" %>
		<div class="menu-content">
			<p class="title-adminPage">(관리자) 박물관 상세</p>
				<table class="admin-table">
					<!-- <thead>
						<tr>
							<th colspan="3">
								<p>(관리자)박물관 상세</p>
							</th>
						</tr>
					</thead> -->
					
					<tbody>
						<tr>
							<th scope="row">테마 코드</th>
							<td>
								<c:out value="${museumCategory.themeCode}"></c:out>
							</td>							
						</tr>
						<tr>
							<th scope="row">지역코드</th>
							<td>
								<c:out value="${museumCategory.areaCode}"></c:out>
							</td>
						</tr>
						
						<tr>
							<th scope="row">박물관 이름</th>
							<td>
								<c:out value="${museum.museumName}"></c:out>
							</td>
						</tr>
						<tr>
							<th scope="row">박물관 주소</th>
							<td><c:out value="${museum.museumAddress}"></c:out></td>
						</tr>
						<tr>
							<th scope="row">박물관 전화번호</th>
							<td><c:out value="${museum.museumTel}"></c:out></td>
						</tr>
						<tr>
							<th scope="row">박물관 홈페이지</th>
							<td><c:out value="${museum.museumHomepage}"></c:out></td>
						</tr>
						<tr>
							<th scope="row" style="vertical-align: top;">박물관 사진</th>
							<td>
								<div class="swiper-container">
									<div class="swiper-wrapper"></div>
									<div class="visual-pagination">
										<div class="swiper-pagination"></div>
									</div>								
									<div class="swiper-button-prev-unique"></div>
									<div class="swiper-button-next-unique"></div>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				
				<!-- <td rowspan="4" class="td-row4" valign="top"> -->
				
				<div class="btn-area">
					<button data-oper="update" class="btn-submit" onclick="location.href='/admin/adminUpdate?museumNo=<c:out value='${museum.museumNo}'/>'">수정하기</button>
					<button data-oper="list" class="btn-submit btn-black" onclick="location.href='/admin/adminRead'">목록으로</button>
				</div>
				
				<!-- 목록 페이지에서 조회페이지로 이동할 때 검색 조건과 키워드 유지 -->
				<form id="operForm" action="/admin/adminUpdate" method="get">
					<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>" />
					<input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>" />
					<input type="hidden" name="type" value="<c:out value='${cri.type}'/>" />
					<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>" />
					<input type="hidden" id="museumNo" name="museumNo" value="<c:out value='${museum.museumNo}'/>" />
				</form>
		</div>
<script type="text/javascript">

$(document).ready(function() {
	(function() {
		var museumNo = '<c:out value="${museum.museumNo}"/>';
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
	var type = $("input[name='type']").val();
	var keyword = $("input[name='keyword']").val();
	
	console.log("pageNum : " + pageNum);
	console.log("amount : " + amount);
	console.log("type : " + type);
	console.log("keyword : " + keyword);
	
	/* 클릭한 버튼에 따라서 form에서 각각 다른 action을 취함 */
	var operForm = $("#operForm");
	
	$("button").on("click", function(e) {
		e.preventDefault();
		
		var operation = $(this).data("oper");
		console.log("operation : " + operation);
		
		if(operation === "update") { // 수정페이지로
			operForm.attr("action", "/admin/adminUpdate").submit();
		} else { // 목록으로
			operForm.find("#museumNo").remove();
			operForm.attr("action", "/admin/adminRead");
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
