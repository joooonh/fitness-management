<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="../../../resources/css/common.css">
<link rel="stylesheet" href="../../../resources/css/content.css">
<title>중앙피트니스</title>
</head>
<body>

<!------------------------------------ 헤더 navbar 영역 ---------------------------------------->
<%@ include file="../common/header.jsp" %>
<div class="container-fluid mt-4">
	<div class="row">
		<div class="col-md-2 sidebar">
			<!---------------------------------- 사이드 바 영역  ----------------------------------------->
			<%@ include file="../common/sidebar.jsp" %>
		</div>
		<div class="col-md-10 ps-4 pt-5">
			<!--------------------------------- Content 영역 ------------------------------------------->
			<div class="row">
				<div class="col-12">
					<h1>내정보</h1>
				</div>
			</div>
			
			<form:form method="post" modelAttribute="form" action="modify" id="modifyEmployee" enctype="multipart/form-data">
				<div class="row">
					<div class="col-4">
						<div class="profile">
							<img src="../../../resources/images/${form.photo }" id="img-profile" class="rounded-circle" alt="직원 프로필 사진">
							<label for="file-profile" class="form-label"><i class="bi bi-camera-fill"></i></label>
							<input class="form-control" type="file" id="file-profile" name="upfile">
						</div>
					</div>
					
					<div class="col-8">
							<input type="hidden" name="fitnessNo" value="${form.fitnessNo }" />
							<table class="table table-bordered">
								<colgroup>
									<col width="25%">
									<col width="*">
								</colgroup>
								 <tr>
								 	<th class="table-secondary">이름</th>
								 	<td>
								 		<form:input path="name" class="form-control form-control-sm" />
										<form:errors path="name" cssClass="text-danger" />
								 	</td>
								 </tr>
								 <tr>
								 	<th class="table-secondary">아이디</th>
								 	<td>
								 		<form:input path="id" class="form-control form-control-sm" readonly="true" />
								 		<form:errors path="id" cssClass="text-danger" />
								 	</td>
								 </tr>
								 <tr>
								 	<th class="table-secondary">비밀번호</th>
								 	<td>
								 		<form:password path="password" class="form-control form-control-sm" />
								 		<form:errors path="password" cssClass="text-danger" />
								 		<span id="passwordCheck" class="text-danger"></span>
								 	</td>
								 </tr>
								 <tr>
								 	<th class="table-secondary">비밀번호 확인</th>
								 	<td>
								 		<form:password path="passwordConfirm" class="form-control form-control-sm" />
								 		<form:errors path="passwordConfirm" cssClass="text-danger" />
								 		<span id="passwordConfirmCheck" class="text-danger"></span>
								 	</td>
								 </tr>
								 <tr>
								 	<th class="table-secondary">전화번호</th>
								 	<td>
								 		<form:input path="tel" class="form-control form-control-sm" />
								 		<form:errors path="tel" cssClass="text-danger" />
								 	</td>
								 </tr>
								 <tr>
								 	<th class="table-secondary">이메일</th>
								 	<td>
								 		<form:input path="email" class="form-control form-control-sm" readonly="true" />
								 		<form:errors path="email" cssClass="text-danger" />
							 		</td>
								 </tr>
								 <tr>
								 	<th class="form-label table-secondary">우편번호</th>
								    <td class="d-flex justify-content-start">
										<form:input path="zipcode" class="form-control w-25 me-3" readonly="true" />
										<form:errors path="zipcode" cssClass="text-danger" />
										<button type="button" class="btn btn-outline-secondary btn-sm" id="btn-search-zipcode">우편번호검색</button>
								    </td>
								 </tr>
								 <tr>
								 	<th class="table-secondary">주소</th>
								 	<td>
								 		<form:input path="basicAddress" class="form-control form-control-sm" />
										<form:errors path="basicAddress" cssClass="text-danger" />
								 	</td>
								 </tr>
								 <tr>
								 	<th class="table-secondary">상세주소</th>
								 	<td>
								 		<form:input path="detailAddress" class="form-control form-control-sm" />
										<form:errors path="detailAddress" cssClass="text-danger" />
								 	</td>
								 </tr>
								
								 <tr>
								 	<th class="table-secondary">재직상태</th>
								 	<td>
								 		<form:select path="status" class="form-select">
								 			<form:option value="재직" />
								 			<form:option value="퇴사" />
								 			<form:option value="휴직" />
								 		</form:select>
								 	</td>
								 </tr>
							</table>
							
							<div class="text-end">
								<a href="mypage" class="btn btn-secondary">취소</a>
								<button type="button" id="btn-save-employee" class="btn btn-primary">저장</a>
							</div>
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
$(function() {
	// 주소검색
	$("#btn-search-zipcode").click(function() {
	  new daum.Postcode({
	    oncomplete: function(data) {
	      // 기본주소 정보를 대입하는 변수를 선언한다.
	      let address;
	      // 사용자가 도로명 주소를 선택했을 때 data.userSelectedType은 R이다.
	      if (data.userSelectedType === 'R') {
	        address = data.roadAddress;
	      } else {
	        address = data.jibunAddress;
	      }
					
	      // 우편번호 입력필드와 기본주소 입력필드에 값을 입력한다.
	      $(":input[name=zipcode]").val(data.zonecode);
	      $(":input[name=basicAddress]").val(address);
				
	      // 상세주소 입력필드에 값을 지우고 포커스를 위치시킨다.
	      $(":input[name=detailAddress]").val("").focus();
	    }
	  }).open();
	});
	
	// 프로필사진 미리보기
	let imgProfile = document.querySelector("#img-profile");
	let fileProfile = document.querySelector("#file-profile");
	
	fileProfile.addEventListener("change", function(event) {
		let reader = new FileReader();
		reader.readAsDataURL(event.target.files[0]);
		reader.onload = function() {
			imgProfile.src = reader.result;
		}
	});
	
	// 직원 정보 유효성 검사
	$("#btn-save-employee").click(function() {		
		let password = $("#password").val();
		let passwordConfirm = $("#passwordConfirm").val();
		
		// 비밀번호를 변경하지 않을 경우 비밀번호 제외하고 서버로 제출
		if (password == 0) {
			$("#modifyEmployee").submit();
			
			return true;
		}
		
		// 비밀번호 유효성 체크
		let check = RegExp(/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,20}$/);
		if (!check.test(password)) {
			$("#passwordCheck").text("* 비밀번호는 8~20자의 영문 대소문자와 숫자,특수문자를 각각 1개 이상 입력하세요.");
			$("#password").val("");
			$("#passwordConfirm").val("");
			$("#password").focus();
			
			return false;
		};
		
		// 비밀번호 일치 확인
		if (password != passwordConfirm) {
			$("#passwordCheck").text("* 비밀번호와 비밀번호 확인이 서로 다릅니다.");
			$("#password").val("");
			$("#passwordConfirm").val("");
			$("#password").focus();
			
			return false;
		}
		
		$("#modifyEmployee").trigger("submit");
	});
	
})
</script>
</body>
</html>