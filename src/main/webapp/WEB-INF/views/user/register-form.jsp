<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/common.css">
<title>회원가입</title>
<style type="text/css">
	#form-register {
		width: 60%;
		margin: 0 auto;
	}
		
	#btn-upload {
		position: relative;
		background-color: transparent;
		border: none;
		top: 30px;
		left: -40px;
	}
	
	#camera-img {
		width: 40px;
		heith: 40px;
	}
	
</style>
</head>
<body class="pt-5">
<c:set var="menu" value="register" />
<%@ include file="../common/header.jsp" %>
<div class="container">
   <div class="row mt-4">
		<div class="col-12">
			<form:form modelAttribute="userRegisterForm" id="form-register" class="border bg-light mt-5 p-3" method="post" action="/user/register" enctype="multipart/form-data">
				<div class="row mb-3" style="margin:auto;text-align:center;">
					<div>
						<img id="profile-img" src="/resources/images/default.png" width="100" height="100" class="inline-block align-text-center rounded-circle">
						<button type="button" id="btn-upload" class="btn-image"><img src="/resources/images/camera-fill.svg" id="camera-img"></button>
						<form:input type="file" accept="image/*" path="upfile" id="file-upload" style="display:none"></form:input>
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-3">
						<label class="form-label">아이디 *</label>
					</div>
					<div class="col-7 ">
						<form:input class="form-control" path="id" placeholder="3~12자의 영문 소문자와 숫자" />
						<form:errors path="id" cssClass="text-danger" />
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-3">
						<label class="form-label">비밀번호 *</label>
					</div>
					<div class="col-7">
						<form:password class="form-control" path="encryptPassword" placeholder="8~20자의 영문 대/소문자와 숫자, 특수문자" />
						<form:errors path="encryptPassword" cssClass="text-danger" />
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-3">
						<label class="form-label">비밀번호 확인 *</label>
					</div>
					<div class="col-7">
						<form:password class="form-control" path="passwordConfirm" placeholder="8~20자의 영문 대문자/소문자와 숫자, 특수문자" />
						<form:errors path="passwordConfirm" cssClass="text-danger" />
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-3">
						<label class="form-label">이름 *</label>
					</div>
					<div class="col-7">
						<form:input class="form-control" path="name" placeholder="예) 홍길동" />
						<form:errors path="name" cssClass="text-danger" />
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-3">
						<label class="form-label">성별 *</label>
					</div>
					<div class="col-2">
						<form:radiobutton class="me-3" path="gender" label="남" value="m" checked="checked" />
					</div>
					<div class="col-2">
						<form:radiobutton class="me-3" path="gender" label="여" value="f" />
					</div>
					<form:errors path="gender" cssClass="text-danger" />
				</div>
				<div class="row mb-3">
					<div class="col-3">
						<label class="form-label">생년월일 *</label>
					</div>
					<div class="col-7">
						<form:input type="date" class="form-control" path="birth" />
						<form:errors path="birth" cssClass="text-danger" />
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-3">
						<label class="form-label">이메일 *</label>
					</div>
					<div class="col-7">
						<form:input class="form-control" path="email" placeholder="예) hong@gmail.com" />
						<form:errors path="email" cssClass="text-danger" />
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-3">
						<label class="form-label">연락처 *</label>
					</div>
					<div class="col-7">
						<form:input class="form-control" path="tel" placeholder="예) 010-0000-0000" />
						<form:errors path="tel" cssClass="text-danger" />
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-3">
						<label class="form-label">주소 *</label>
					</div>
					<div class="col-4">
						<form:input class="form-control" path="zipcode" placeholder="우편번호 입력"/>
						<form:errors path="zipcode" cssClass="text-danger" />
					</div>
					<div class="col-5">
						<button type="button" class="btn btn-secondary" id="btn-search-zipcode" >우편번호 찾기</button>
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-3">
					</div>
					<div class="col-7">
						<form:input class="form-control" path="basicAddr" placeholder="기본주소를 입력하세요." />
						<form:errors path="basicAddr" cssClass="text-danger" />
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-3">
					</div>
					<div class="col-7">
						<form:input class="form-control" path="detailAddr" placeholder="상세주소를 입력하세요. (아파트 동/호수)" />
						<form:errors path="detailAddr" cssClass="text-danger" />
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-3">
					</div>
					<div class="mb-3 d-grid gap-2 col-7 ">
						<form:button class="btn btn-dark" >회원가입</form:button>
					</div>
				</div>
			</form:form>
		</div>
   </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(function(){
	
	// 우편번호 API
	$("#btn-search-zipcode").click(function(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	            $(":input[name=zipcode]").val(data.zonecode);
	            $(":input[name=basicAddr]").val(data.roadAddress);
	        }
	    }).open();
	})
	
	// 프로필 사진 업로드 버튼
	$("#btn-upload").click(function(){
		$("#file-upload").click();
	})
	
	// 프로필 사진 업로드 미리보기
	let profileImg = document.querySelector("#profile-img");
	let fileUpload = document.querySelector("#file-upload");
	
	fileUpload.addEventListener("change", function(event){
		let reader = new FileReader();
		reader.readAsDataURL(event.target.files[0]);
		reader.onload = function(){
			profileImg.src = reader.result;
		}
	})
	
})
</script>
</body>
</html>