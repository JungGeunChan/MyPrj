<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/buttonCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/mypage/mypageCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/recover/recoverMemberCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/recover/recoverMemberId.css">
<title>아이디 찾기 : 전국 박물관 안내소</title>
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
						<a href="/main/recover/recoverMemberId">아이디 찾기</a>
					</li>
				</ul>
			</div>
			<h2 class="page-title"><strong>아이디 찾기</strong></h2>
		</div>
		<div class="page-content">
			<form class="frm-recoverMember" action="/main/recover/recoverMemberId_toPhone" method="post" onsubmit="return formSubmit()">
				<div class="recoverMember-content-header">
					<div class="recoverMember-title">
						<img src="/resources/img/mypage/ico_login_find_img.png">
						<span>아이디 찾기</span>
						<p>아래 정보를 입력한 후 확인버튼을 클릭하시면 선택하신 본인확인방법으로 아이디를 알려드립니다.</p>
					</div>
				</div>

				<div class="frm-recoverMember-inner-div">
					<table class="recoverMember-table">
						<tbody>
							<tr>
								<th scope="row"><p>본인확인 방법</p></th>
								<td>
									<input type="radio" id="phone" name="recoverMemberIdMethod" value="chk_memberPhone" checked/>
									<label for="phone">휴대전화번호</label>
						
									<input type="radio" id="email" name="recoverMemberIdMethod" value="chk_memberEmail"/>
									<label for="email">이메일</label>
								</td>
							</tr>
							<tr>
								<th scope="row"><p>이름</p></th>
								<td>
									<input type="text" id="memberName" name="memberName">
								</td>
							</tr>
							<tr class="tr3">
								<th scope="row"><p>휴대전화 번호</p></th>
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
									<input id="memberPhone2" type="text" maxlength="4">
									<input id="memberPhone3" type="text" maxlength="4">
								</td>
							</tr>
							<tr class="tr3">
								<th scope="row"></th>
								<td><p class="tr-p">회원가입시 등록하신 휴대전화 번호를 입력해 주세요.</p></td>
							</tr>
							<tr class="tr4">
								<th scope="row"><p>이메일</p></th>
								<td>
									<input type="text" name="memberEmail" id="memberEmail"/>
								</td>
							</tr>
							<tr class="tr4">
								<th scope="row"></th>
								<td><p class="tr-p">회원가입시 등록하신 이메일을 입력해 주세요.</p></td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="btn-area">
					<button type="submit" class="btn-submit">확인</button>
				</div>
			</form>
		</div>
	</div>
	
	<c:if test="${result == false}">
		<script type="text/javascript">
			alert("입력하신 회원정보와 일치하는 아이디가 없습니다.");
		</script>
	</c:if>
</body>
<%@include file="../../includes/footer.jsp" %>

<script src="/resources/js/common.js"></script>
<script src="/resources/js/main/mypage/mypageCommon.js"></script>
<script src="/resources/js/main/recover/recoverMemberId.js"></script>
</html>