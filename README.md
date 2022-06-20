# MyPrj (개인 프로젝트) - By JungGeunChan
전국 박물관 안내소 개인 프로젝트 입니다.
## 개발 환경
#### 공통 사항
+ 운영체제 : Windows11
+ 개발 툴 : Eclipse IDE (2022-03)
+ WAS : Apache Tomcat v9.0
+ 데이터 베이스 : Oracle Database 11g XE
---
## 사용한 기술 스택
#### 프론트엔드
+ 언어 : HTML5, CSS3, Javascript
+ 프레임워크 : Jquery, Ajax
#### 백엔드
+ 언어 : JavaSE-11, XML
+ 프레임워크 : Spring4, MyBatis, Lombok, HikariCP
---
## 구현기능 (FrontEnd)
1. 공통사항
+ 작업 실패시 alert 경고창
+ 브라우저 사이즈가 줄어들면 인터페이스 변경.
```
@media screen and (max-width:768px)
@media screen and (min-width:769px)
```
2. 회원가입
	+ 이메일 중복검사
		+ 이미 회원으로 가입된 이메일이 존재하는 경우 가입 불가
	+ 이메일 입력 (정규식을 통한 이메일 유효성 검사 -> joinEmailCheck.js)
		+ 이메일 주소 시작은 숫자나 알파벳(소문자/대문자).
		+ 이메일 첫째자리 뒤에는 "-" or "_" or "." 을 포함하여 입력가능.
		+ 도메인 주소 전에는 반드시 @ 입력.
		+ "." 이 최소한 하나는 있어야 하며 마지막 마디는 2-3자리여야 함. (ex : jkchappy@naver.com)
	+ 회원약관
		+ 체크박스와 라디오버튼으로 구현된 필수 체크항목 2가지를 반드시 체크해야 다음단계로 진행 가능.
		+ 라디오버튼의 경우 아니오를 체크할시 진행 불가.
	+ 가입정보 입력
		+ 전체
			+ 하위 항목중 하나라도 입력이 올바르지 않은 항목이 있을 시, 가입 불가.
		+ 이름 입력 (정규식을 통한 이름 유효성 검사)
			+ 이름은 반드시 두글자부터 시작
		+ 아이디 입력 (정규식을 통한 이름 유효성 검사)
			+ 아이디는 4자~12자 이내의 영문과 숫자로 공백 없이 입력해야 함.
			+ Ajax를 사용하여 데이터베이스에 이미 가입된 동일한 아이디가 존재할 시, 안내 문구가 나타남.
			+ 한 단어 입력할 때마다 유효성 검사
			+ 영문 대소문자를 구분하지 않음.
		+ 비밀번호 입력 (정규식을 통한 비밀번호 유효성 검사)
			+ 비밀번호는 영문, 숫자, 특수문자의 1자 이상 조합으로 8자~20자 사이로 공백없이 입력해야 함.
			+ 영문 대소문자를 구분함.
			+ Ajax를 사용하여 비밀번호, 비밀번호 확인 체크
		+ 비밀번호 확인
			+ 비밀번호 입력란과 비밀번호 확인 입력란이 일치 하지 않을 시 가입 불가.
		+ 출생연도
			+ select box로 선택하게 함.
		+ 연락처 (정규식을 통한 연락처 유효성 검사)
			+ 오직 숫자만 입력가능
			+ 첫번째 입력란은 select box로 구현
			+ 두번째 입력란은 3자리 또는 4자리 숫자 입력
			+ 세번째 입력란은 반드시 4자리 숫자 입력
			+ Ajax를 사용하여 중복된 번호 가입체크
		+ 성별
			+ radio button으로 선택
	+ 회원가입 성공
3. 로그인
	+ 전체
		+ 정규식을 통한 유효성 검사 적용(이름, 휴대전화번호, 이메일)
	+ 로그인
		+ 로그인 성공시 header영역 로그인 버튼 사라지고 '(아이디)님 방문을 환영합니다.' 로 변경.
	+ 아이디 찾기(핸드폰, 이메일을 통한 아이디 찾기)
		+ 본인확인 방법 radio button에 따라 나타나고, 실행되는 action을 다르게 함
	+ 비밀번호 찾기(이메일을 통한 아이디 찾기)

4. 마이페이지
	+ 전체
		+ 유효성 검사
	+ 휴대전화 변경
	+ 비밀번호 변경
	+ 회원 탈퇴
5. 관리자 페이지
	+ 공통
		+ 공백만 입력하지 못하게 함.
	+ 박물관 등록
		+ 분류 코드
		+ 지역 코드
		+ 박물관 이름
		+ 박물관 주소
		+ 박물관 전화번호
		+ 박물관 홈페이지
		+ 박물관 사진
			+ jQuery는 파일업로드 처리를 FormData라는 객체를 이용한다. (가상의 폼)
			+ Ajax를 사용해서 사진 섬네일 출력.
			+ 데이터베이스에 이미지 파일을 저장하기 위해 별도의 hidden태그를 생성함.
			+ Ajax를 이용하였기 때문에 이미 어떤 파일을 첨부할 것인지에 대한 처리는 끝났고,
			+ 남은 작업은 데이터베이스에 보낼 첨부파일에 관련된 정보를 처리하는 부분이기 때문에, data-uuid, data-filename, data-type를 추가함.
			+ MuseumVO로 수집되는 자료는 List<MuseumVO> attachList라는 이름으로 첨부파일 정보를 수집하기 때문에,
			+ name='attachList[인덱스번호]'로 사용한다.
	+ 박물관 관리
		+ 공통
			+ 박물관 이름을 클릭하면 박물관 상세 페이지로 이동
			+ 페이징 처리
			+ 모든 작업 수행시 이전 검색결과와 페이지 번호 정보를 가지고 이동. (form 태그 ㅎhidde
			+ 브라우저의 뒤로가기 버튼 클릭시 BFCache 삭제 (뒤로가기 시 페이지의 데이터가 최신화되지 않는 문제 해결)
			+ data-oper 속성을 사용하여 클릭한 버튼에 따라 다른 작업 수행 (수정, 삭제, 목록)
		+ 조회 페이지
			+ 키워드를 통한 검색(박물관 이름, 박물관 주소)
		+ 상세 페이지
			+ $.getJSON을 사용하여 박물관 번호에 해당하는 사진을 가져옴.
			+ 슬라이드 이미지로 구현 (swiper 슬라이더 사용)
		+ 수정 페이지
			+ 삭제 버튼
			+ 목록 버튼
6. (사용자) 박물관 검색 페이지
	+ 체크박스를 이용한 검색 (분류 코드, 지역코드)
	+ 페이징 처리
	+ 해당 박물관 대표 이미지 출력
	+ 모든 작업 수행시 이전 검색결과와 페이지 번호 정보를 가지고 이동.
------------	
## 구현기능 (BackEnd)
1. 테이블 설계
  ![테이블](https://user-images.githubusercontent.com/97310975/174588724-540cde74-eb1f-4006-9116-d9195a38414d.png)
2. 회원가입 (MemberController.java)
	+ 이메일 중복검사 ("/joinEmailCheck")
		+ 이미 가입된 이메일이 존재 할 때 (1개 이상) 가입불가
		+ 중복된 값이 없을시 세션에 이메일을 담아서 다음페이지로 넘겨줌.
	+ 회원약관 ("/joinMemberAgreememt")
	+ 가입정보 입력 ("/joinMember")
		+ 아이디 중복 처리 ("/idCheck")
			+ 아이디 입력형식 정규식 작성
		+ 비밀번호, 비밀번호 확인 일치여부 처리 ("/pwCheck")
		+ 중복된 핸드폰 번호 처리 ("/phoneCheck")
	+ 회원가입 성공 ("/joinSuccess")
		+ 비밀번호 암호화해서 DB에 저장
		+ 세션에 있던 이메일 삭제

3. 로그인 (LoginController.java)
	+ 로그인 ("/login")
	+ 로그아웃 ("/logout")

4. 계정 찾기 (RecoverMemberController.java)
	+ 아이디 찾기 ("/recoverMemberId", "/recoverMemberId_toPhone", "/recoverMemberId_toEmail", "/recoverMemberIdSuccess")
		+ 회원 이름과 휴대폰 번호 또는 이메일을 입력해서 일치하는 정보가 존재 시 가입한 이메일로 전체 아이디 전송
		+ 화면 상에는 마스킹 처리
	+ 비밀번호 찾기 ("/recoverMemberPassword", "/recoverMemberPasswordResult", "/recoverMemberPasswordChange")
		+ 회원 이름과 휴대폰 번호 또는 이메일을 입력해서 일치하는 정보가 존재 시 가입한 이메일로 인증번호 전송
		+ 인증번호가 일치할 시 비밀번호 변경 페이지로 이동

5. 마이페이지 (MemberController.java)
	+ 전화번호 변경 ("/update")
		+ 로그인한 사용자의 휴대전화 번호 변경
	+ 비밀번호 변경 ("/passwordUpdate")
	+ 회원 탈퇴 ("/delete")
  
6. 관리자 페이지 (AdminController.java)
	+ 박물관 등록 ("/adminCreate")
	+ 박물관 관리 ("/adminRead")
		+ 검색
			+ 페이징 처리 (PageDTO.java)
			+ 검색 기준 (Criteria.java)
			+ 동적 sql 사용 (키워드를 통한 검색-> 박물관이름, 박물관주소, 박물관이름or박물관주소)
			+ 검색 후 상세페이지 이동 시 검색 결과 유지 (Criteria.java)
		+ 상세 페이지 ("/adminDetail")
			- 검색에서 박물관 이름을 클릭
		+ 수정 페이지 ("/adminUpdate")
		+ 삭제 페이지 ("/adminDelete")
	+ 이미지 처리 (UploadController.java)
		+ 이미지 등록, 이미지 수정  : @PostMapping("/uploadImgAjax")
			+ getFolder() : 폴더 생성 이름 지정 (현재 날짜의 년/월/일)
			+ 이미지 파일일 경우 원본파일과 섬네일 파일 두가지 생성 : checkImageType()으로 파일 타입 체크
			+ @GetMapping("/display") : 섬네일 파일 미리보기
			+ 이미지 수정시, 이미지를 삭제하고 다른 이미지로 변경하였을 경우 FileCheckTask.java가 실행됨.

		+ jsp화면 이미지 조회 (AdminController.java)
			+ @GetMapping("/getAttachList")
				+ $.getJSON으로 박물관 번호를 받으면 MuseumServiceImpl의 getAttachList를 리턴함.
			  	+ MuseumService의 getAttachList 메소드는 MuseumMapper의 findByMuseum를 리턴함.
			+ findByMuseum은 박물관 번호를 이용해서 박물관 이미지에 대한 정보를 가져옴. (museumNo, museumImgFileName, museumImgUploadPath, museumImgUuid, museumImgFileType)
		+ 이미지 삭제
			+ AdminController.java -> deleteFiles() : 박물관 삭제 시 폴더에 존재하는 파일 삭제
			+ UploadController.java -> @PostMapping("/deleteFile") : jsp화면에서 보여주는 이미지 삭제
			+ FileCheckTask.java -> 잘못 업로드 된 파일 삭제, 불일치 파일 삭제
				(최종적으로 submit를 안하고 게시물을 등록 하지 않은 경우, 폴더에는 이미지 파일이 생성됐지만 DB에는 저장이 되어있지 않은데, 
					매일 새벽2시에 어제 날짜 폴더 경로에 있는 이미지 파일 존재여부를 비교하여 일치하지 않을 경우 이미지를 삭제함.)
				(또는, 박물관 이미지를 수정하는 과정에서 이미지를 삭제하고 다른 이미지로 변경하였을 경우에 동작)

7. (사용자) 박물관 검색 페이지
	+ 동적 sql 사용 (체크박스를 통한 검색 -> 테마별, 지역별, 테마별or지역별)
		+ 검색 후 대표이미지 하나를 출력하기 위해 ROW_NUMBER() OVER(PARTITION BY museumNo order by museumNo) AS RNUM 사용.
	+ 페이징 처리
	+ 검색 후 상세페이지 이동 시 검색 결과 유지
	+ 상세정보 페이지
