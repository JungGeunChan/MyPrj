<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>박물관 검색 : 전국 박물관 안내소</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/buttonCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/museum/museumSearch.css">
<link rel="stylesheet" type="text/css" href="/resources/css/paginate.css">
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
			<h2 class="page-title"><strong>박물관 검색</strong></h2>
		</div>
		
		<div class="page-content">
			<form id="searchForm" action="/museum/museumSearch" method="get">
				<div class="form-innerDiv">
					<p class="selectTitle">테마 선택</p>					
					<ul class="ul-theme">
						<li>
							<input type="checkbox" name="themeList" value="100" id="s100" /><label for="s100">종합</label>
						</li>
						<li>
							<input type="checkbox" name="themeList" value="200" id="s200" /><label for="s200">역사</label>
						</li>
						<li>
							<input type="checkbox" name="themeList" value="300" id="s300" /><label for="s300">전쟁</label>
						</li>
						<li>
							<input type="checkbox" name="themeList" value="400" id="s400" /><label for="s400">화폐</label>
						</li>
					</ul>
				</div>
				<div class="form-innerDiv">
					<p class="selectTitle">지역 선택</p>
					<ul class="ul-area">
						<li>
							<input type="checkbox" name="areaList" value="1000" id="s110"><label for="s110">서울</label>
						</li>
						<li>
							<input type="checkbox" name="areaList" value="2000" id="s120"><label for="s120">인천</label>
						</li>
						<li>
							<input type="checkbox" name="areaList" value="3000" id="s130"><label for="s130">부산</label>
						</li>
					</ul>
				</div>				
				<div class="btn-area">
					<input type="hidden" name="amount" value="<c:out value='${pageMaker.cri.amount}'/>"/>
					<button type="submit" class="btn-submit">검색</button>
				</div>
			</form>
			
			<c:forEach items="${list2}" var="list2">
				<input class="museumNo" name="museumNo" type="hidden" value="<c:out value="${list2.museumNo}"></c:out>" />
			</c:forEach>
			<c:forEach items="${themeList}" var="cri">
				<input class="theme" type="hidden" value="<c:out value="${cri}"/>">
			</c:forEach>
			<c:forEach items="${areaList}" var="cri">
				<input class="area" type="hidden" value="<c:out value="${cri}"/>">
			</c:forEach>
				
			<div class="searchResultDiv">
				<c:if test="${result == 0}">
					<c:out value="테마 또는 지역을 선택해 주세요."></c:out>
				</c:if>
				<c:if test="${result == null}">
					<c:out value="검색 결과가 없습니다."></c:out>
				</c:if>
				<c:if test="${result == 1}">
					<p>총 <c:out value="${pageMaker.total}"></c:out>건이 검색되었습니다.</p>
				</c:if>
				<c:forEach items="${list}" var="list" varStatus="status">
					<div class="searchResultInnerDiv">
						<div class="searchResultInnerDiv2">
							<button class="btn-detail" type="button" value="${list.museumNo}">
								<div class="imgWrap" data-museumno="${list.museumNo}"></div>
								<p><c:out value="${list.museumName}"></c:out></p>
								<img src="/resources/img/btn_search_open.png"/>
							</button>
						</div>
					</div>
				</c:forEach>
			</div>
			
			<div class="paginate-area">
				<ul class="paginate">
					<c:if test="${pageMaker.prev}">
						<li class="btn-paginate prev"><a href="${pageMaker.startPage -1}">이전</a></li>
					</c:if>
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class="btn-paginate num ${pageMaker.cri.pageNum == num ? 'active' : ''}">
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>
					<c:if test="${pageMaker.next}">
						<li class="btn-paginate next"><a href="${pageMaker.endPage +1}">다음</a></li>
					</c:if>
				</ul>
			</div>
			
			<form id="actionForm" action="/museum/museumSearch" method="get">
				<c:forEach items="${themeList}" var="cri">
					<input type="hidden" name="themeList" value="<c:out value="${cri}"/>">
				</c:forEach>
				<c:forEach items="${areaList}" var="cri">
					<input type="hidden" name="areaList" value="<c:out value="${cri}"/>">
				</c:forEach>
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			</form>
		</div>
	</div>
</body>
<%@include file="../includes/footer.jsp" %>
<script src="/resources/js/common.js"></script>
<script src="/resources/js/paginate.js"></script>
<script type="text/javascript">
var actionForm = $("#actionForm");
$(".btn-paginate a").on("click", function(e) {
	e.preventDefault();
	actionForm.find("input[name='pageNum']").val($(this).attr("href"));
	actionForm.submit();
});

$(".btn-detail").on("click", function(e) {
	e.preventDefault();
	actionForm.append("<input type='hidden' name='museumNo' value='" + $(this).attr("value") + "' />");
	actionForm.attr("action", "/museum/museumDetail");
	actionForm.submit();
});

$(document).ready(function() {
	// BFCache 새로고침
	window.addEventListener('pageshow', (event) => {
		if (event.persisted) {
			location.reload();
		} 
	});
	
	var themeSize = $(".theme").length;
	var areaSize = $(".area").length;
	
	var themeList = new Array(themeSize);
	var areaList = new Array(areaSize);
	
	for(var i=0; i<themeSize; i++) {
		themeList[i] = $(".theme").eq(i).val();
	}
	for(var i=0; i<areaSize; i++) {
		areaList[i] = $(".area").eq(i).val();
	}
	
	$("input[name='themeList']").prop("checked", false);
	$("input[name='areaList']").prop("checked", false);
	
	if(themeList.includes('100')) {
		$("input[name='themeList'][value='100']").prop("checked", true);
	}
	if(themeList.includes('200')) {
		$("input[name='themeList'][value='200']").prop("checked", true);
	}
	if(themeList.includes('300')) {
		$("input[name='themeList'][value='300']").prop("checked", true);
	}
	if(themeList.includes('400')) {
		$("input[name='themeList'][value='400']").prop("checked", true);
	}
	
	if(areaList.includes('1000')) {
		$("input[name='areaList'][value='1000']").prop("checked", true);
	}
	if(areaList.includes('2000')) {
		$("input[name='areaList'][value='2000']").prop("checked", true);
	}
	if(areaList.includes('3000')) {
		$("input[name='areaList'][value='3000']").prop("checked", true);
	}
	
	if(themeList.length == 0) {
		themeList = ['100', '200', '300', '400'];
	}
	if(areaList.length == 0) {
		areaList = ['1000', '2000', '3000'];
	}

	(function() {
		jQuery.ajaxSettings.traditional = true; // 체크박스 배열 데이터 직렬화
		
		$.ajax({
			url : "/museum/getAttachList",
			type : "POST",
			data : {"themeList" : themeList, "areaList" : areaList},
			async : false,
			dataType : "json",
			success : function(arr) {
				var str = "";
				var length = $(arr).length;
				
				$(arr).each(function(i, obj) {
					if(obj.museumImgFileType) {
						var museumImgFileCallPath = encodeURIComponent(obj.museumImgUploadPath + "/s_" + obj.museumImgUuid + "_" + obj.museumImgFileName);
						$(".imgWrap").attr("data-path", obj.museumImgUploadPath);
						$(".imgWrap").attr("data-uuid", obj.museumImgUuid);
						$(".imgWrap").attr("data-fileName", obj.museumImgFileName);
						$(".imgWrap").attr("data-type", obj.museumImgFileType);
						
						str = "<img class='img-thumbnail' src='/admin/display?museumImgFileName=" + museumImgFileCallPath+"'></div>";
						$("div[data-museumno=" + obj.museumNo +"]").append(str);
					} else {
						console.log("이미지 파일이 아님");
					}
				});
			}
		});
	})();
});

$(".btn-submit").on("click", function() {
	$("#searchForm").submit();
});
</script>
</html>