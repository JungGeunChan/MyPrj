<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>(관리자)박물관 상세 : 전국 박물관 안내소</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/buttonCommon.css">
<link rel="stylesheet" type="text/css" href="/resources/css/admin/adminCreate.css">
</head>
	<%@include file="../includesAdmin/admin.jsp" %>
		<div class="menu-content">
			<p class="title-adminPage">(관리자) 박물관 수정</p>
			
			<input id="themeCode" type="hidden" value="<c:out value="${museumCategory.themeCode}"></c:out>"/>
			<input id="areaCode" type="hidden" value="<c:out value="${museumCategory.areaCode}"></c:out>"/>

			<form role="form" action="/admin/adminUpdate" method="post">
				<input id="museumNo" name="museumNo" type="hidden" value="<c:out value="${museum.museumNo}"></c:out>"/>
				
				<!-- 수정페이지에서 목록페이지로 이동시 검색조건과 키워드 유지 -->
				<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
				<input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
				<input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
				<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
				
				<table class="admin-table">
					<!-- <thead>
						<tr>
							<th colspan="2">
								<p>(관리자)박물관 수정</p>
							</th>
						</tr>
					</thead> -->
					<tbody>
						<tr>
							<th scope="row"><p>분류 코드</p></th>
							<td>
								<select id="code1" name="themeCode" onchange="optionChange();">
									<option value="100">100 - 종합</option>
									<option value="200">200 - 역사</option>
									<option value="300">300 - 전쟁</option>
									<option value="400">400 - 화폐</option>
								</select>
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
						</tr>
						<tr>
							<th scope="row"><p>박물관 이름</p></th>
							<td>
								<input id="museumName" name="museumName" type="text" value="<c:out value="${museum.museumName}"></c:out>"/>
							</td>
						</tr>
						<tr>
							<th scope="row"><p>박물관 주소</p></th>
							<td>
								<input id="museumAddress" name="museumAddress" type="text" value="<c:out value="${museum.museumAddress}"></c:out>"/>
							</td>
						</tr>
						<tr>
							<th scope="row"><p>박물관 전화번호</p></th>
							<td>
								<input id="museumTel" name="museumTel" type="text" value="<c:out value="${museum.museumTel}"></c:out>"/>
							</td>
						</tr>
						<tr>
							<th scope="row"><p>박물관 홈페이지</p></th>
							<td>
								<input id="museumHomepage" name="museumHomepage" type="text" value="<c:out value="${museum.museumHomepage}"></c:out>"/>
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
					<button class="btn-submit" data-oper="update" type="submit">저장</button>
					<button class="btn-submit" data-oper="delete" type="submit">삭제</button>
					<button class="btn-submit btn-black" data-oper="list" type="submit">목록으로</button>
				</div>
			</form>
		</div>
<!-- <script type="text/javascript" src="/resources/js/admin/optionChange.js"></script> -->
<script type="text/javascript">
	$(".span-upload").hover(function() {
		$(".arrow-box").show();
	}, function() {
		$(".arrow-box").hide();
	});
	
	/*------------------------------ 사진 삭제 처리 부분 -------------------------------*/
	$(".uploadResult").on("click", "span", function() {
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var targetLi = $(this).closest("li");
		
		console.log("targetFile : " + targetFile);
		console.log("type : " + type);
		
		if(confirm("해당 사진을 삭제하시겠습니까?")) {
			targetLi.remove();	
		}
		//$("input[type='file']").val("");
	});
	
	$(document).ready(function() {
		var themeCode = $("#themeCode").val();
		var areaCode = $("#areaCode").val();
		
		console.log("themeCode : " + themeCode);
		console.log("areaCode : " + areaCode);
		
		$("#code1").val(themeCode).prop("selected", true);		
		$("#code2").val(areaCode).prop("selected", true);
		
		/*------------------------------ 파일 업로드 처리 부분 -------------------------------*/
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
				/* console.log("i : " + i);
				if(i%3 == 0) { // 3개 단위로 섬네일 줄바꿈 처리
					$(".uploadFile").css({"display" : "block", "content" : "''", "clear" : "left"});
				} */
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
		
		/*------------------------------ 기존 파일 보여주는 부분 -------------------------------*/
		
		(function() {
			var museumNo = '<c:out value="${museum.museumNo}"/>';
			
			/*
			$.getJSON("/admin/getMuseumCategoryList", {museumNo : museumNo}, function(arr) {
				console.log(arr);
				var str = "";
				var length = $(arr).length;
				
				$(arr).each(function(i, obj) {
					var str = obj.category_categoryCode;
					if(i == 0) {
						$("#code1 > option[value=" + str + "]").attr("selected", "selected");
					} else {
						$("#museumCategoryCode").attr("value", str);
					}
				});
			});
			*/
			
			
			$.getJSON("/admin/getAttachList", {museumNo : museumNo}, function(arr) {
				var str = "";
				var uploadResult = $(".uploadResult > ul");
				
				$(arr).each(function(i, obj) {
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
				$(".uploadResult > ul").html(str);
			});
		})();		
		
		/*------------------------------ 하단 버튼 처리 부분 -------------------------------*/
		
		var formObj = $("form");
		
		$("button").on("click", function(e) {
			e.preventDefault();
			
			/* 클릭한 버튼에 따라서 form에서 각각 다른 action을 취함 */
			
			var operation = $(this).data("oper");
			console.log("operation : " + operation);
			
			if(operation === "delete") { // 삭제
				formObj.attr("action", "/admin/adminDelete");
				alert("삭제합니다...");
				formObj.submit();
			} else if(operation === "list") { // 목록으로
				formObj.attr("action", "/admin/adminRead").attr("method", "get");
				
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var typeTag = $("input[name='type']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				
				/* 다시 목록으로 이동하는 경우에 필요한 파라미터면 추가하기 위해 form의 내용을 비우고 다시 추가 */
				formObj.empty();
				
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(typeTag);
				formObj.append(keywordTag);
				
				formObj.submit();
			} else { // 수정
				var str = "";
				
				console.log($("#code1 option:selected").val());
			
			
				/* if(!reg_categoryCode($("#museumCategoryCode").val())) {
					alert("카테고리 코드는 숫자 3자리 입니다.");
				} else  */
				if(!checkMuseumName()) {
					alert("박물관 이름 에러");
				} else if(!checkMuseumAddress()) {
					alert("박물관 주소 에러");
				} else if(!checkMuseumTel()) {
					alert("박물관 전화번호 에러");
				} else if(!checkMuseumHomepage()) {
					alert("박물관 홈페이지 에러");
				} else {
					$(".uploadResult > ul > li").each(function(i, obj) {
						var jobj = $(obj);
						console.dir(jobj);
						
						// 설명 : adminCreate.js
						str += "<input type='hidden' name='attachList["+i+"].museumImgFileName' value='" + jobj.data("filename")+ "'>";
						str += "<input type='hidden' name='attachList["+i+"].museumImgUuid' value='" + jobj.data("uuid")+ "'>";
						str += "<input type='hidden' name='attachList["+i+"].museumImgUploadPath' value='" + jobj.data("path")+ "'>";
						str += "<input type='hidden' name='attachList["+i+"].museumImgFileType' value='" + jobj.data("type")+ "'>";
						console.log("str2 : " + str);
					});
					formObj.append(str).submit();
					alert("저장되었습니다.");
					formObj.submit();
				}
				/* 
				var saveConfirm = confirm("저장하시겠습니까?");
				if(saveConfirm) {
					formObj.append(str).submit();
				} else {
					location.href = "/admin/adminUpdate";
				}
				 */
			}
		});
	}); // end of $(document).ready();

	/*------------------------------ submit 제어 부분 -------------------------------*/
	
	function checkMuseumName() {
		let museumName = $("#museumName").val();
		console.log("museumName : " + museumName);
		if(museumName == '') {
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
		} else {
			return true;
		}
	}
	
	function checkMuseumTel() {
		let museumTel = $("#museumTel").val();
		console.log("museumTel : " + museumTel);
		if(museumTel == '') {
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
		} else {
			return true;
		}
	}
	/*
	function reg_categoryCode(museumCategoryCode) {
		let categoryCodeRegExp = /^([0-9]{3})$/;
		
		if(!categoryCodeRegExp.test(museumCategoryCode) ) {
	        $("#museumCategoryCode").val("");
	        return false;
		} else {
			return true;	
		}
	}
	*/
	/*
	$("#museumCategoryCode").on("propertychange change keyup paste input", function() {
		let museumCategoryCode = $("#museumCategoryCode").val();
		
		let len = $("#museumCategoryCode").val().length;
		let num = museumCategoryCode.search(/[0-9]/g);
		
		if(len == 3) {
			if(museumCategoryCode.search(/\s/) != -1) {
				$(".result-categoryCode").html("공백없이 입력해주세요.");
				$(".result-categoryCode").css("color", "#97000F");
			} else {
				$(".result-categoryCode").html("올바른 코드 입니다.");
				$(".result-categoryCode").css("color", "#3F0B9F");	
			}
		} else {
			if(len == 0) {
				$(".result-categoryCode").html("박물관 코드를 입력해주세요.");
				$(".result-categoryCode").css("color", "black");
			} else if(museumCategoryCode.search(/\s/) != -1) {
				$(".result-categoryCode").html("공백없이 입력해주세요.");
				$(".result-categoryCode").css("color", "#97000F");
			} else {
				$(".result-categoryCode").html("3자리 코드로 입력해주세요.");
				$(".result-categoryCode").css("color", "#97000F");	
			}
		}
	});
	*/
	/*
	function formSubmit() {
		console.log("museumCategoryCode : " + $("#museumCategoryCode").val());
		
		if(!reg_categoryCode($("#museumCategoryCode").val())) {
			alert("카테고리 코드는 숫자 4자리 입니다.");
			return false;
		} else if(!checkMuseumName()) {
			alert("박물관 이름 에러");
			return false;
		} else if(!checkMuseumAddress()) {
			alert("박물관 주소 에러");
			return false;
		} else if(!checkMuseumTel()) {
			alert("박물관 전화번호 에러");
			return false;
		} else if(!checkMuseumHomepage()) {
			alert("박물관 홈페이지 에러");
			return false;
		} else {
			alert("저장되었습니다.");
			return true;
		}
	}
	*/
</script>
</html>