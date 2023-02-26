<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/userInfo-sideMenu.css">
<link rel="stylesheet" href="/resources/css/userInfo.css">
<title>애플리케이션</title>
</head>
<body class="pt-5">
<c:set var="menu" value="info" />
<%@ include file="../common/header.jsp" %>
<div class="container">
	<div class="row mb-3" id="row">
		<div class="col-3" id="col">
			<div id="side-menu">
				<li><a href="/user/info" style="color:white" id="current-page">내 정보 조회/수정</a></li>
				<li><a href="/user/membership">내 회원권 조회</a></li>
				<li><a href="/user/reservation">내 예약 조회</a></li>
				<li><a href="/user/attendance">내 출석 조회</a></li>
				<li><a href="/user/delete">회원 탈퇴</a></li>
			</div>
		</div>
		<div class="col-9" id="col2">
			<div class="row mb-3">
				<div class="col">
					<form:form modelAttribute="modifyForm" class="p-2" id="form-modify" method="post" action="modify" enctype="multipart/form-data">
						<!-- 히든필드에 사용자 번호를 설정한다. -->
						<form:input type="hidden" path="no" />
						<div class="row mb-3" style="margin:auto;text-align:center;">
							<div>
								<img id="profile-img" src="/resources/images/profile/${modifyForm.photo }" width="100" height="100" class="border inline-block align-text-center rounded-circle">
								<button type="button" id="btn-upload" class="btn-image"><img src="/resources/images/camera-fill.svg" id="camera-img"></button>
								<form:input type="file" accept="image/*" path="upfile" id="file-upload" style="display:none" />
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-10">
								<c:if test="${param.complete eq 'y' }">
									<div class="alert alert-success" role="alert">
										정보 수정이 완료되었습니다.
									</div>
								</c:if>
								<c:if test="${param.complete eq 'n' }">
									<div class="alert alert-danger" role="alert">
										정보 수정에 실패하였습니다.
									</div>
								</c:if>
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-3">
								<label class="form-label">아이디</label>
							</div>
							<div class="col-7 ">
								<form:input class="form-control" path="id" disabled="true"/>
								<form:errors path="id" cssClass="text-danger" />
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-3">
								<label class="form-label">새 비밀번호</label>
							</div>
							<div class="col-7">
								<form:password class="form-control" path="password" placeholder="8~20자의 영문 대/소문자와 숫자, 특수문자" />
								<form:errors path="password" cssClass="text-danger" />
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-3">
								<label class="form-label">비밀번호 확인</label>
							</div>
							<div class="col-7">
								<form:password class="form-control" path="passwordConfirm" placeholder="8~20자의 영문 대/소문자와 숫자, 특수문자" />
								<form:errors path="passwordConfirm" cssClass="text-danger" />
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-3">
								<label class="form-label">이름</label>
							</div>
							<div class="col-7">
								<form:input class="form-control" path="name"  disabled="true" />
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-3">
								<label class="form-label">성별</label>
							</div>
							<div class="col-2">
								<form:radiobutton class="me-3" path="gender" label="남" value="m" disabled="true"/>
							</div>
							<div class="col-2">
								<form:radiobutton class="me-3" path="gender" label="여" value="f" disabled="true"/>
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-3">
								<label class="form-label">생년월일</label>
							</div>
							<div class="col-7">
								<form:input type="date" class="form-control" path="birth" disabled="true" />
								<form:errors path="birth" cssClass="text-danger" />
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-3">
								<label class="form-label">이메일</label>
							</div>
							<div class="col-7">
								<form:input class="form-control" path="email"  disabled="true" />
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-3">
								<label class="form-label">연락처</label>
							</div>
							<div class="col-7">
								<form:input class="form-control" path="tel"  />
								<form:errors path="tel" cssClass="text-danger" />
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-3">
								<label class="form-label">주소</label>
							</div>
							<div class="col-4">
								<form:input class="form-control" path="zipcode" value="${modifyForm.zipcode }" />
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
								<form:input class="form-control" path="basicAddr" value="${modifyForm.basicAddr }" />
								<form:errors path="basicAddr" cssClass="text-danger" />
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-3">
							</div>
							<div class="col-7">
								<form:input class="form-control" path="detailAddr" value="${modifyForm.detailAddr }" />
								<form:errors path="detailAddr" cssClass="text-danger" />
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-3">
							</div>
							<div class="mb-3 d-grid gap-2 col-7 ">
								<form:button type="submit" class="btn btn-dark" >수정</form:button>
							</div>
						</div>
					</form:form>
				</div>
			</div>
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