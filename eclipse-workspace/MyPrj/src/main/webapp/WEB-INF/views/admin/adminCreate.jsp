<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>박물관 등록-관리자 : 전국 박물관 안내소</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/buttonCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/admin/adminCreate.css">
</head>
<body>
	<%@include file="../includesAdmin/admin.jsp" %>
		<div class="menu-content">
			<p class="title-adminPage">(관리자) 박물관 등록</p>
			<form role="form" action="/admin/adminCreate" method="post" onsubmit="return formSubmit()">
				<table class="admin-table">
					<tbody>
						<tr>
							<th scope="row"><p>분류 코드</p></th>
							<td>
								<select id="code1" name="themeCode">
									<option value="100">100 - 종합</option>
									<option value="200">200 - 역사</option>
									<option value="300">300 - 전쟁</option>
									<option value="400">400 - 화폐</option>
								</select>
							</td>
							<td>
								<p class="p-warn result-categoryCode">박물관 분류 코드를 입력해주세요.</p>
							</td>
						</tr>
						<tr>
							<th scope="row"><p>지역 코드</p></th>
							<td>
								<select id="code2" name="areaCode">
									<option value="1000">1000 - 서울</option>
									<option value="2000">2000 - 인천</option>
									<option value="3000">3000 - 부산</option>
								</select>
							</td>
							<td>
								<p class="p-warn result-categoryCode">박물관 지역 코드를 입력해주세요.</p>
							</td>
						</tr>
						<tr>
							<th scope="row"><p>박물관 이름</p></th>
							<td>
								<input id="museumName" name="museumName" type="text">
							</td>
							<td>
								<p class="p-warn">박물관 이름을 입력해주세요.</p>
							</td>
						</tr>
						<tr>
							<th scope="row"><p>박물관 주소</p></th>
							<td>
								<input id="museumAddress" name="museumAddress" type="text">
							</td>
							<td>
								<p class="p-warn">박물관 주소를 입력해주세요.</p>
							</td>
						</tr>
						<tr>
							<th scope="row"><p>박물관 전화번호</p></th>
							<td>
								<input id="museumTel" name="museumTel" type="text">
							</td>
							<td>
								<p class="p-warn">박물관 전화번호를 입력해주세요.</p>
							</td>
						</tr>
						<tr>
							<th scope="row"><p>박물관 홈페이지</p></th>
							<td>
								<input id="museumHomepage" name="museumHomepage" type="text">
							</td>
							<td>
								<p class="p-warn">박물관 홈페이지 URL을 입력해주세요.</p>
							</td>
						</tr>
						<tr>
							<th scope="row"><p>박물관 사진</p></th>
							<td>
								<div class="uploadDiv">
									<label class="lbl-inputImg" for="museumImg">사진첨부</label>
									<input id="museumImg" name="uploadFile" type="file" multiple="multiple">
									<p class="arrow-box">png, jpg파일만 등록가능합니다.</p>
									<span class="span-circle span-upload">i</span>
								</div>
							</td>
							<td>
								<p class="p-warn">박물관 사진을 등록해주세요.</p>
							</td>
						</tr>
						<tr>
							<td>
								<p style="display : none;"></p>
							</td>
							<td colspan="2">
								<div class="uploadResult">
									<ul>
									</ul>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			<div class="btn-area">
				<button type="submit" class="btn-submit">저장</button>
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
	function showImage(museumImgFileCallPath) {
		$(".uploadResult").css("display", "flex").show();
	}
	
	$(".span-upload").hover(function() {
		$(".arrow-box").show();
	}, function() {
		$(".arrow-box").hide();
	});
	
	$(".uploadResult").on("click", "span", function(e) {
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url : "deleteFile", // 파일 삭제를 수행하는 url
			data : {museumImgFileName : targetFile, museumImgFileType : type}, // 파일경로, 타입
			dataType : "text", // 전송되는 museumImgFileName은 문자
			type : "POST",
			success : function(result) {
				alert(result);
				targetLi.remove();
				$("input[type='file']").val("");
			}
		});
	});
	
	$(document).ready(function(e) {
		var formObj = $("form[role='form']");
		
		var regex = new RegExp("(.*?)\.(png|jpg)$");
		var maxSize = 5242880; // 1024 * 1024 * 5 = 5MB
		
		
		
		function checkExtension(museumImgFileName, museumImgFileSize) {
			if(museumImgFileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}
			if(!regex.test(museumImgFileName)) {
				alert("해당 종류의 파일은 업로드 할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		function showUploadedResult(uploadResultArr) {
			var str = "";
			var uploadResult = $(".uploadResult ul");
			
			$(uploadResultArr).each(function(i, obj) {
				if(obj.museumImgFileType) {
					console.log("이미지 파일이 맞음");
					var museumImgFileCallPath = encodeURIComponent(obj.museumImgUploadPath + "/s_" + obj.museumImgUuid + "_" + obj.museumImgFileName);
					str += "<li data-path='" + obj.museumImgUploadPath + "'";
					str += " data-uuid = '" + obj.museumImgUuid + "' data-filename='" + obj.museumImgFileName + "' data-type='" + obj.museumImgFileType + "'";
					str += " ><div>";
					str += "<img class='imgThumbnail' src='/admin/display?museumImgFileName=" + museumImgFileCallPath+"'><span class='span-circle span-delete' data-file=\'" + museumImgFileCallPath + "\' data-type='image'>x</span>";
					str += "</div>";
					str += "</li>";
					console.log("str : " + str);
				} else {
					console.log("이미지 파일이 아님");
				}
			});
			
			uploadResult.append(str);
		}
		
		$("input[type='file']").change(function(e) {
			var formData = new FormData(); // jQuery는 파일업로드 처리를 FormData라는 객체를 이용한다. (가상의 폼)
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			
			for (var i = 0; i < files.length; i++) {
				if(!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url : "uploadImgAjax",
				processData : false,
				contentType : false,
				data : formData,
				type : "POST",
				dataType : "json",
				success : function(result) {
					console.log(result);
					showUploadedResult(result);
				}
			});
		});
		
		$(".btn-submit").on("click", function(e) {
			e.preventDefault(); // submit클릭 기본동작 막기
			console.log("submit click");
			
			var str = "";
			$(".uploadResult > ul > li").each(function(i, obj) {
				var jobj = $(obj);
				console.dir(jobj);
				
				// 데이터베이스에 이미지 파일을 저장하기 위해 별도의 hidden태그를 생성한다.
				// Ajax를 이용하였기 때문에 이미 어떤 파일을 첨부할 것인지에 대한 처리는 끝났고,
				// 남은 작업은 데이터베이스에 보낼 첨부파일에 관련된 정보를 처리하는 부분이기 때문에, data-uuid, data-filename, data-type를 추가한다.
				// MuseumVO로 수집되는 자료는 List<MuseumVO> attachList라는 이름으로 첨부파일 정보를 수집하기 때문에,
				// name='attachList[인덱스번호]'로 사용한다.
				str += "<input type='hidden' name='attachList["+i+"].museumImgFileName' value='" + jobj.data("filename")+ "'>";
				str += "<input type='hidden' name='attachList["+i+"].museumImgUuid' value='" + jobj.data("uuid")+ "'>";
				str += "<input type='hidden' name='attachList["+i+"].museumImgUploadPath' value='" + jobj.data("path")+ "'>";
				str += "<input type='hidden' name='attachList["+i+"].museumImgFileType' value='" + jobj.data("type")+ "'>";
				console.log("str2 : " + str);
			});
			formObj.append(str).submit();
		});
	});

	function formSubmit() {
		if(!checkMuseumName()) {
			alert("박물관 이름 에러");
			return false;
		} else if(!checkMuseumAddress()) {
			alert("박물관 주소 에러");
			return false;
		} else if(!checkMuseumTel()) {
			alert("박물관 전화번호 에러");
			return false;
		}
		
		alert("등록되었습니다.");
		return true;
	}

	let reg_onlyBlank = /^\s+|\s+$/g;
	
	function checkMuseumName() {
		let museumName = $("#museumName").val();
		console.log("museumName : " + museumName);
		if(museumName == '') {
			return false;
		} else if(museumName.replace(reg_onlyBlank, '') == "") {
			alert("박물관 이름이 공백만 입력됨.");
			return false;
		} else {
			return true;
		}
	}
	
	function checkMuseumAddress() {
		let museumAddress = $("#museumAddress").val();
		console.log("museumAddress : " + museumAddress);
		if(museumAddress == '') {
			return false;
		} else if(museumAddress.replace(reg_onlyBlank, '') == "") {
			alert("박물관 주소가 공백만 입력됨.");
			return false;
		} else {
			return true;
		}
	}
	
	function checkMuseumTel() {
		let museumTel = $("#museumTel").val();
		console.log("museumTel : " + museumTel);
		if(museumTel == '') {
			return false;
		} else if(museumTel.replace(reg_onlyBlank, '') == "") {
			alert("박물관 전화번호가 공백만 입력됨.");
			return false;
		} else {
			return true;
		}
	}
	
	function checkMuseumHomepage() {
		let museumHomepage = $("#museumHomepage").val();
		console.log("museumHomepage : " + museumHomepage);
		if(museumHomepage == '') {
			return false;
		} else if(museumHomepage.replace(reg_onlyBlank, '') == "") {
			alert("박물관 홈페이지가 공백만 입력됨.");
			return false;
		} else {
			return true;
		}
	}
</script>
</html>