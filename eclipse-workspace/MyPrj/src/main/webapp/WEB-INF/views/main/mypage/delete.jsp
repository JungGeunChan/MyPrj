<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/buttonCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/table.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/mypage/mypageCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/mypage/delete.css">
<title>회원탈퇴 : 전국 박물관 안내소</title>
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
			<h2 class="page-title"><strong>회원탈퇴</strong></h2>
		</div>
		<div class="page-content">
			<form class="form-delete" action="/main/mypage/delete" method="post">
				<div class="mypage-content-header-wrap">
					<ul class="ul-mypage-content-header">
						<li class="li-update"><a href="/main/mypage/update"><span id="span-update">회원정보관리</span></a></li>
						<li class="li-passwordUpdate"><a href="/main/mypage/passwordUpdate"><span id="span-passwordUpdate">비밀번호변경</span></a></li>
						<li class="li-delete"><a href="/main/mypage/delete"><span id="span-delete">회원탈퇴</span></a></li>
					</ul>
				</div>
				<div class="delete-title">
					<img src="/resources/img/mypage/ico_member_delete.png">
					<span>회원탈퇴</span>
				</div>

				<div class="join-form-inner-div">
					<table class="join-table">
						<tbody>
							<tr>
								<th scope="row"><p>비밀번호 입력</p></th>
								<td>
									<input type="password" id="memberPassword" name="memberPassword">
									<p id="tbl-p">본인확인을 위하여 비밀번호를 입력해 주세요.</p>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="delete-info-box">
					<ul>
						<li>회원탈퇴를 하시면 회원으로 누릴 수 있는 다양한 혜택을 제공 받으실 수 없습니다.</li>
						<li>탈퇴 후 회원님의 정보는 회원 DB에서 완전히 삭제 됩니다.</li>
						<li>탈퇴된 아이디는 본인과 타인 모두 재사용 및 복구가 불가 하오니 신중하게 선택해 주세요.</li>
						<li>탈퇴하여도 회원님이 작성한 글은 삭제되지 않으므로 삭제를 원하시면 탈퇴 전에 하셔야합니다.</li>
					</ul>
				</div>
				<div class="btn-area">
					<button type="submit" class="btn-submit">회원탈퇴</button>
				</div>
			</form>
		</div>
	</div>
	
	<c:if test="${encodeResult == false}">
		<script type="text/javascript">
			alert("기존 비밀번호가 일치하지 않습니다.");
		</script>
	</c:if>
	
	<c:if test="${memberDeleteResult == 0}">
		<script type="text/javascript">
			alert("오류가 발생했습니다.");
		</script>
	</c:if>
	
</body>
<%@include file="../../includes/footer.jsp" %>

<script src="/resources/js/common.js"></script>
<script src="/resources/js/main/mypage/delete.js"></script>

</html>