<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/common.css">
<title>애플리케이션</title>
<style type="text/css">
	#form-login {
		width: 60%;
		margin: 0 auto;
		padding: 100px 0;
		padding-left: 200px;
		margin-top: 200px;
		opacity: 0.95;
		border-radius: 40px 40px 40px 40px;
	}
	
	#login-head {
		text-align: center;
		font-size: xx-large;
		font-weight: bold;
	}
</style>
</head>
<body class="pt-5" background="../../../resources/images/home.jpg">
<%@ include file="../common/header.jsp" %>
<div class="container">
   <div class="row">
   		<div class="col-12">
   			<form class="form border bg-light" id="form-login" method="post" action="login">
   				<div class="row mb-3">
   					<div class="col-7" id="login-head">
   						<img src="../../../resources/images/logo.svg" alt="Logo" width="40" height="27" class="text-black me-3">
   						중앙피트니스
   					</div>
   				</div>
   				<div class="row mb-3">
					<div class="col-7 ">
						<input type="text" class="form-control" name="id" placeholder="아이디" />
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-7">
						<input type="password" class="form-control" name="encryptPassword" placeholder="비밀번호" />
					</div>
				</div>
			    <div class="mb-3 d-grid gap-2 col-7 ">
						<button type="submit" class="btn btn-dark" >로그인</button>
				</div>
			    <div class="mb-3 d-grid gap-2 col-7 ">
						<button type="button" class="btn btn-secondary" onclick="location.href='/user/register' " >회원가입</button>
				</div>
			</form>
		</div>
   </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>