<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/buttonCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/mypage/mypageCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/mypage/update.css">
<link rel="stylesheet" type="text/css" href="/resources/css/table.css">
<title>회원정보관리 : 전국 박물관 안내소</title>
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
						<a href="/main/mypage/update">마이페이지</a>
					</li>
					<li>
						<a href="#">회원정보</a>
					</li>
					<li>
						<a href="/main/mypage/update">회원정보관리</a>
					</li>
				</ul>
			</div>
			<h2 class="page-title"><strong>회원정보관리</strong></h2>
		</div>
		<div class="page-content">
			<form class="update-form" action="/main/mypage/update" method="post" onsubmit="return formSubmit()">
				<div class="mypage-content-header-wrap">
					<ul class="ul-mypage-content-header">
						<li class="li-update"><a href="/main/mypage/update"><span id="span-update">회원정보관리</span></a></li>
						<li class="li-passwordUpdate"><a href="/main/mypage/passwordUpdate"><span id="span-passwordUpdate">비밀번호변경</span></a></li>
						<li class="li-delete"><a href="/main/mypage/delete"><span id="span-delete">회원탈퇴</span></a></li>
					</ul>
				</div>
				<div class="join-form-inner-div">
					<table class="join-table">
						<tbody>
							<tr>
								<th scope="row"><p>이름</p></th>
								<td><span>${member.memberName}</span></td>
							</tr>
							<tr>
								<th scope="row"><p>아이디</p>
								<td><span>${member.memberId}</span></td>	
							</tr>
							<tr>
								<th scope="row"><p>연락처</p></th>
								
								<td>
									<input id="memberPhone" name="memberPhone" type="hidden">
										<select id="memberPhone1">
											<option value="010" <c:if test="${memberPhone0==010}">selected</c:if>>010</option>
											<option value="011" <c:if test="${memberPhone0==011}">selected</c:if>>011</option>
											<option value="016" <c:if test="${memberPhone0==016}">selected</c:if>>016</option>
											<option value="017" <c:if test="${memberPhone0==017}">selected</c:if>>017</option>
											<option value="018" <c:if test="${memberPhone0==018}">selected</c:if>>018</option>
											<option value="019" <c:if test="${memberPhone0==019}">selected</c:if>>019</option>
										</select> 
									<input id="memberPhone2" type="tel" value="${memberPhone1}" maxlength="4">
									<input id="memberPhone3" type="tel" value="${memberPhone2}" maxlength="4">
								</td>
							</tr>
							<tr>
								<th scope="row"><p>이메일</p></th>
								<td><span>${member.memberEmail}</span></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="btn-area">
					<button type="submit" class="btn-submit">저장</button>
				</div>
			</form>
		</div>
	</div>
	<c:if test="${updatePhoneResult == 0}">
		<script type="text/javascript">
			alert("변경에 실패하였습니다.");
		</script>
	</c:if>
	<c:if test="${updatePhoneResult == 1}">
		<script type="text/javascript">
			alert("성공적으로 변경되었습니다.");
		</script>
	</c:if>
</body>
<%@include file="../../includes/footer.jsp" %>
<script src="/resources/js/common.js"></script>
<script src="/resources/js/main/mypage/update.js"></script>

<script type="text/javascript">
	function formSubmit() {
		var memberPhone1 = $("#memberPhone1").val();
		var memberPhone2 = $("#memberPhone2").val();
		var memberPhone3 = $("#memberPhone3").val();
		
		if(memberPhone1.length < 3 || memberPhone2.length < 4 || memberPhone3.length < 4) {
			alert("올바른 연락처를 입력해주세요.");
			return false;
		} else if($.isNumeric(memberPhone1) == false || $.isNumeric(memberPhone2) == false || $.isNumeric(memberPhone3) == false) {
			alert("올바른 연락처를 입력해주세요.");
			return false;
		}
		
		var memberPhone = memberPhone1 + "-" + memberPhone2 + "-" + memberPhone3;
		console.log(memberPhone);
		
		$("#memberPhone").val(memberPhone);
		return true;
	}	
</script>
</html>