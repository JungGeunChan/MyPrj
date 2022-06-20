<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>박물관 조회-관리자 : 전국 박물관 안내소</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/buttonCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/paginate.css">
<link rel="stylesheet" type="text/css" href="/resources/css/admin/adminRead.css">
</head>
<%@include file="../includesAdmin/admin.jsp" %>
<body class="body">
	<div class="menu-content">
		<form id="readForm" action="/admin/adminRead" method="get">
			<div class="admin-desktop">
				<p class="title-adminPage">(관리자) 박물관 관리</p>
				
				<table class="admin-table">
					<c:if test="${result == 0}">
						<tbody>
							<tr>
								<td>검색 결과가 없습니다.</td>
							</tr>
						</tbody>
					</c:if>
					<c:if test="${result == 1}">
						<tbody>
							<tr>
								<th scope="row">번호</th>
								<th scope="row">박물관 이름</th>
								<th scope="row">박물관 주소</th>
								<th scope="row">박물관 전화번호</th>
								<th scope="row">박물관 홈페이지</th>
							</tr>
							<c:forEach items="${list}" var="list" varStatus="status">
								<tr>
									<td><c:out value="${pageMaker.total - (pageMaker.cri.pageNum-1) * pageMaker.cri.amount - status.index}"></c:out></td>
									
									<td>
										<a class="move" href="<c:out value='${list.museumNo}'/>"><c:out value="${list.museumName}"></c:out></a>
									</td>
									<td><c:out value="${list.museumAddress}"></c:out></td>
									<td><c:out value="${list.museumTel}"></c:out></td>
									<td><c:out value="${list.museumHomepage}"></c:out></td>
								</tr>
							</c:forEach>
						</tbody>
					</c:if>
				</table>
			</div>
			
			<div class="admin-mobile">
				<p class="title-adminPage">(관리자) 박물관 관리</p>
				<ul>
					<c:if test="${result == 0}">
						<li>검색 결과가 없습니다.</li>
					</c:if>
					<c:if test="${result == 1}">
						<c:forEach items="${list}" var="list" varStatus="status">
							<li>
								<span class="listNo"><c:out value="${pageMaker.total - (pageMaker.cri.pageNum-1) * pageMaker.cri.amount - status.index}"></c:out></span>
								<span>
									<a href="/admin/adminDetail?museumNo=<c:out value='${list.museumNo}'/>"><c:out value="${list.museumName}"></c:out></a></span>
							
								<p><c:out value="${list.museumAddress}"></c:out></p>
								<p><c:out value="${list.museumTel}"></c:out></p>
								<p><c:out value="${list.museumHomepage}"></c:out></p>
							</li>
						</c:forEach>
					</c:if>
				</ul>
			</div>
		
			<div class="wrapper">
				<c:if test="${result == 1}">
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
				</c:if>
				<div class="btn-area">
					<select name="type">
						<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}"/>>--</option>
						<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : ''}"/>>박물관이름</option>
						<option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}"/>>박물관주소</option>
						<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : ''}"/>>박물관이름or박물관주소</option>
					</select>
					<input id="keyword" type="text" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>">
				
					<input type="hidden" name="pageNum" value="<c:out value='${pageMaker.cri.pageNum}'/>"/>
					<input type="hidden" name="amount" value="<c:out value='${pageMaker.cri.amount}'/>"/>
					<button type="submit" class="btn-submit">검색</button>
				</div>
			</div>
		</form>
		<!-- 페이지 번호 클릭해서 이동시 검색조건과 키워드 같이 전달 -->
		<form id="actionForm" action="/admin/adminRead" method="get">
			<input type="hidden" name="type" value="${pageMaker.cri.type}">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
		</form>
	</div>
</body>
<script src="/resources/js/paginate.js"></script>
<script type="text/javascript">	
	let readForm = $("#readForm");
	let actionForm = $("#actionForm");
	$(".btn-paginate a").on("click", function(e) {
		e.preventDefault();
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	$(".btn-submit").on("click", function(e) {
		if(!readForm.find("option:selected").val()) {
			alert("검색 종류를 선택하세요.");
			return false;
		}
		
		if(!readForm.find("input[name='keyword']").val()) {
			alert("검색어를 입력하세요.");
			return false;
		}

		/* 검색은 1페이지부터 하고 화면에 검색 조건과 키워드가 보이게 설정*/
		
		var pageNum = $("input[name='pageNum']").val();
		var amount = $("input[name='amount']").val();
		var type = $("input[name='type']").val();
		var keyword = $("input[name='keyword']").val();
		
		console.log("pageNum : " + pageNum);
		console.log("amount : " + amount);
		console.log("type : " + type);
		console.log("keyword : " + keyword);
		
		readForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		readForm.submit();
	});
	
	$(".move").on("click", function(e) {
		e.preventDefault();
		actionForm.append("<input type='hidden' name='museumNo' value='" + $(this).attr("href") + "' />");
		actionForm.attr("action", "/admin/adminDetail");
		actionForm.submit();
	});
	
	$(document).ready(function() {
		// BFCache 새로고침
		window.addEventListener('pageshow', (event) => {
			if (event.persisted) {
				location.reload();
			} 
		});
	});
</script>
</html>