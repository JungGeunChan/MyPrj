<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/buttonCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/join/joinCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main/join/joinMember.css">
<link rel="stylesheet" type="text/css" href="/resources/css/table.css">
<title>회원 가입 : 전국 박물관 안내소</title>
</head>
<%@include file="../../includes/header.jsp" %>
<body class="body">
	<div class="page-wrapper">
		<div class="page-header">
			<div class="nav-location">
				<ul>
					<li class="home">
						<a href="/main/main"><img src="/resources/img/icon1.png"></a>
					</li>
					<li>
						<a href="#">마이페이지</a>
					</li>
					<li>
						<a href="/main/join/joinEmailCheck">회원가입</a>
					</li>
				</ul>
			</div>
			<h2 class="page-title"><strong>회원가입</strong></h2>
		</div>
		<div class="page-content">
			<div class="desktop-join-step">
				<img src="/resources/img/join/bg_join03_on.png">
			</div>
			<div class="mobile-join-step">
				<img src="/resources/img/join/m_bg_join03_on.png">
			</div>
			<div class="join-step-content">
				<form class="join-form" action="/main/join/joinMember" method="post" onsubmit="return formSubmit()">
					<div class="join-form-inner-div">
						<table class="join-table">
							<tbody>
								<tr>
									<th scope="row"><p>이름</p></th>
									<td>
										<input id="memberName" name="memberName" type="text">
									</td>
								</tr>
								<tr>
									<th scope="row"><p>아이디</p></th>
									<td>
										<input id="memberId" name="memberId" type="text" required oninput="checkId()">
										<p class="tbl-p result-id">아이디를 입력해주세요.</p>										
										<p class="tbl-p">
											아이디는 4자~12자 이내의 영문과 숫자로 공백 없이 입력하시면 됩니다. 영문 대소문자를 구분하지 않습니다.
										</p>
									</td>
								</tr>
								<tr>
									<th scope="row"><p>비밀번호</p></th>
									<td>
										<input id="memberPassword" name="memberPassword" type="password" required oninput="checkPw()">
										<p class="tbl-p result-pw">
											비밀번호를 입력해 주세요.
										</p>
										<p class="tbl-p">
											비밀번호는 영문, 숫자, 특수문자(~,!,@,#,$,%,^,* 등) 1자 이상 조합으로 8자~20자 사이로 공백없이 입력하시면 됩니다.
											<br>영문 대소문자를 구분합니다.
										</p>
									</td>
								</tr>
								<tr>
									<th scope="row"><p>비밀번호 확인</p></th>
									<td class="a">
										<input id="memberPasswordChk" type="password" required oninput="checkPw()">
										<p class="tbl-p check-result-pw">비밀번호를 입력해 주세요.</p>
									</td>
								</tr>
								<tr>
									<th scope="row"><p>출생연도</p></th>
									<td>
										<select id="memberBornyear" name="memberBornyear">
											<option value="2021">2021</option>
											<option value="2020">2020</option>
											<option value="2019">2019</option>
											<option value="2018">2018</option>
											<option value="2017">2017</option>
											<option value="2016">2016</option>
											<option value="2015">2015</option>
											<option value="2014">2014</option>
											<option value="2013">2013</option>
											<option value="2012">2012</option>
											<option value="2011">2011</option>
											<option value="2010">2010</option>
											<option value="2009">2009</option>
											<option value="2008">2008</option>
											<option value="2007">2007</option>
											<option value="2006">2006</option>
											<option value="2005">2005</option>
											<option value="2004">2004</option>
											<option value="2003">2003</option>
											<option value="2002">2002</option>
											<option value="2001">2001</option>
											<option value="2000">2000</option>
											<option value="1999">1999</option>
											<option value="1998">1998</option>
											<option value="1997">1997</option>
											<option value="1996">1996</option>
											<option value="1995">1995</option>
											<option value="1994">1994</option>
											<option value="1993">1993</option>
											<option value="1992">1992</option>
											<option value="1991">1991</option>
											<option value="1990">1990</option>
											<option value="1989">1989</option>
											<option value="1988">1988</option>
											<option value="1987">1987</option>
											<option value="1986">1986</option>
											<option value="1985">1985</option>
											<option value="1984">1984</option>
											<option value="1983">1983</option>
											<option value="1982">1982</option>
											<option value="1981">1981</option>
											<option value="1980">1980</option>
											<option value="1979">1979</option>
											<option value="1978">1978</option>
											<option value="1977">1977</option>
											<option value="1976">1976</option>
											<option value="1975">1975</option>
											<option value="1974">1974</option>
											<option value="1973">1973</option>
											<option value="1972">1972</option>
											<option value="1971">1971</option>
											<option value="1970">1970</option>
											<option value="1969">1969</option>
											<option value="1968">1968</option>
											<option value="1967">1967</option>
											<option value="1966">1966</option>
											<option value="1965">1965</option>
											<option value="1964">1964</option>
											<option value="1963">1963</option>
											<option value="1962">1962</option>
											<option value="1961">1961</option>
											<option value="1960">1960</option>
											<option value="1959">1959</option>
											<option value="1958">1958</option>
											<option value="1957">1957</option>
											<option value="1956">1956</option>
											<option value="1955">1955</option>
											<option value="1954">1954</option>
											<option value="1953">1953</option>
											<option value="1952">1952</option>
											<option value="1951">1951</option>
											<option value="1950">1950</option>
											<option value="1949">1949</option>
											<option value="1948">1948</option>
											<option value="1947">1947</option>
											<option value="1946">1946</option>
											<option value="1945">1945</option>
											<option value="1944">1944</option>
											<option value="1943">1943</option>
											<option value="1942">1942</option>
											<option value="1941">1941</option>
											<option value="1940">1940</option>
											<option value="1939">1939</option>
											<option value="1938">1938</option>
											<option value="1937">1937</option>
											<option value="1936">1936</option>
											<option value="1935">1935</option>
											<option value="1934">1934</option>
											<option value="1933">1933</option>
											<option value="1932">1932</option>
											<option value="1931">1931</option>
											<option value="1930">1930</option>
											<option value="1929">1929</option>
											<option value="1928">1928</option>
											<option value="1927">1927</option>
											<option value="1926">1926</option>
											<option value="1925">1925</option>
											<option value="1924">1924</option>
											<option value="1923">1923</option>
											<option value="1922">1922</option>
										</select>
										<p class="tbl-p">
											주민등록번호에 사용되는 출생년도를 입력해주세요.
										</p>
									</td>
								</tr>
								<tr>
									<th scope="row"><p>연락처</p></th>
									<td>
										<input id="memberPhone" name="memberPhone" type="hidden" required oninput="checkPhone()">
										<select id="memberPhone1" required oninput="checkPhone()">
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="018">018</option>
											<option value="019">019</option>
										</select>
										<input id="memberPhone2" type="text" maxlength="4" required oninput="checkPhone()">
										<input id="memberPhone3" type="text" maxlength="4" required oninput="checkPhone()">
									</td>
								</tr>
								<tr>
									<th scope="row"><p>이메일</p></th>
									<td>
										<input id="memberEmail" name="memberEmail" type="text" readonly="readonly" value="${memberEmail}">
									</td>
								</tr>
								<tr>
									<th scope="row"><p>성별</p></th>
									<td>
										<input type="radio" id="man" name="memberGender" value="남">
										<label for="man">남</label>
										<input type="radio" id="woman" name="memberGender" value="여">
										<label for="woman">여</label>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="btn-area">
						<button type="submit" class="btn-submit">가입완료</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<%-- 
	<c:if test="${chkIdResult == 1}">
		<script type="text/javascript">
			alert("아이디가 중복되었습니다.");
		</script>
	</c:if>
	<c:if test="${chkPhoneResult == 1}">
		<script type="text/javascript">
			alert("핸드폰 번호가 중복되었습니다.");
		</script>
	</c:if> --%>
	
	<c:if test="${pwCheckResult == false}">
		<script type="text/javascript">
			alert("비밀번호가 일치하지 않습니다.");
		</script>
	</c:if>
</body>
<%@include file="../../includes/footer.jsp" %>
<script src="/resources/js/common.js"></script>
<script src="/resources/js/join/joinCommon.js"></script>
<script src="/resources/js/join/joinMember.js"></script>
</html>