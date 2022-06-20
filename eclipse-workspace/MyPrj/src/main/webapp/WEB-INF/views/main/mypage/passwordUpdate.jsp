<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/buttonCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/table.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/mypage/mypageCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/mypage/passwordUpdate.css">
<title>비밀번호변경 : 전국 박물관 안내소</title>
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
						<a href="/main/mypage/passwordUpdate">비밀번호변경</a>
					</li>
				</ul>
			</div>
			<h2 class="page-title"><strong>비밀번호변경</strong></h2>
		</div>
		<div class="page-content">
			<form class="form-passwordUpdate" action="/main/mypage/passwordUpdate" method="post" onsubmit="return formSubmit()">
				<div class="mypage-content-header-wrap">
					<ul class="ul-mypage-content-header">
						<li class="li-update"><a href="/main/mypage/update"><span id="span-update">회원정보관리</span></a></li>
						<li class="li-passwordUpdate"><a href="/main/mypage/passwordUpdate"><span id="span-passwordUpdate">비밀번호변경</span></a></li>
						<li class="li-delete"><a href="/main/mypage/delete"><span id="span-delete">회원탈퇴</span></a></li>
					</ul>
					<div class="passwordUpdate-title">
						<img src="/resources/img/mypage/ico_pw_change.png">
						<span>비밀번호 변경</span>
					</div>
					<p id="title-p">기존 비밀번호와 새로운 비밀번호를 입력하고 <span>[저장]</span>버튼을 클릭하세요.</p>
				</div>

				<div class="join-form-inner-div">
					<table class="join-table">
						<tbody>
							<tr>
								<th scope="row"><p>아이디</p></th>
								<td><span>${member.memberId}</span></td>
							</tr>
							<tr>
								<th scope="row"><p>기존 비밀번호</p></th>
								<td>
									<input type="password" id="memberPassword" name="memberPassword">
								</td>
							</tr>
							<tr>
								<th scope="row"><p>새로운 비밀번호</p></th>
								<td>
									<input type="password" id="changePassword" name="changePassword" required oninput="changePwCheck()">
									<p class="tbl-p result-pw">
										비밀번호를 입력해 주세요.
									</p>
									<p id="tbl-p">
										비밀번호는 영문, 숫자, 특수문자(~,!,@,#,$,%,^,* 등) 1자 이상 조합으로 8자~20자 사이로 공백없이 입력하시면 됩니다.
										<br>영문 대소문자를 구분합니다.
									</p>
								</td>
							</tr>
							<tr>
								<th scope="row"><p>비밀번호 확인</p></th>
								<td>
									<input type="password" id="changePasswordCheck" name="changePasswordCheck" required oninput="changePwCheck()">
									<p class="tbl-p check-result-pw">비밀번호를 입력해 주세요.</p>
								</td>
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
	
	<c:if test="${encodeResult == false}">
		<script type="text/javascript">
			alert("기존 비밀번호가 일치하지 않습니다.");
		</script>
	</c:if>
	
	<c:if test="${encodeResult2 == false}">
		<script type="text/javascript">
			alert("변경하시려는 비밀번호끼리 일치하지 않습니다.");
		</script>
	</c:if>
	
	<c:if test="${updatePasswordResult == 0}">
		<script type="text/javascript">
			alert("오류가 발생했습니다.");
		</script>
	</c:if>
	
	<c:if test="${updatePasswordResult == 1}">
		<script type="text/javascript">
			alert("저장되었습니다.");
		</script>
	</c:if>
</body>
<%@include file="../../includes/footer.jsp" %>
<script src="/resources/js/common.js"></script>
<script src="/resources/js/main/mypage/passwordUpdate.js"></script>
</html>