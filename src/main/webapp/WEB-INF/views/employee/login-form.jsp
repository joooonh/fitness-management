<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/background.css">
<link rel="stylesheet" href="/resources/css/login-form.css">
<title>중앙피트니스</title>
</head>
<body class="pt-5">
<%@ include file="../common/header.jsp" %>
<div class="container">
   <div class="row" id="row">
   		<div class="col-12" id="col">
   			<form class="form" id="form-login" method="post" action="/login">
   			<!-- csrf 토큰값을 히든필드로 추가한다. -->
			<sec:csrfInput />
			<!-- userType을 히든필드로 추가한다. -->
			<input type="hidden" name="userType" value="관리자" />
   				<div class="row mb-3">
   					<div  id="login-head">
   						<img src="/resources/images/logo.svg" alt="Logo" width="40" height="27" class="text-black me-3">
   						<strong>중앙피트니스 관리자</strong>
   					</div>
   				</div>
   				<c:if test="${param.error eq 'fail' }">
   					<div class="alert alert-danger">
	   					<strong>로그인 실패</strong> 아이디 혹은 비밀번호가 유효하지 않습니다.
   					</div>
   				</c:if>
   				<div class="row mb-3">
					<div >
						<input type="text" class="form-control" name="id" placeholder="아이디" value="hong" />
					</div>
				</div>
				<div class="row mb-5">
					<div >
						<input type="password" class="form-control" name="password" placeholder="비밀번호" value="Zxcv1234!" />
					</div>
				</div>
			    <div class="row mb-1">
						<button type="submit" class="btn btn-dark" >관리자 로그인</button>
				</div>
			</form>
		</div>
   </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>