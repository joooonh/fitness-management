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
   			<div>
	   			<div>
	   				<button>프로그램 조회</button>
	   			</div>
	   			<div>
	   				<button>예약하기</button>
	   			</div>
   			</div>
		</div>
   </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>