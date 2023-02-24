<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/resources/css/common.css">
<title>애플리케이션</title>
<style type="text/css">
	body {
        height: 100vh;
        width: 100vw;
        background-image: url('/resources/images/home2.jpg');
        background-repeat : no-repeat;
        background-size : cover;
        background-opacity: 0.5;
	}
	body::before {
		position: absolute;
		content: "";
		top:0px;
		left:0px;
		width: 100%;
		height: 100%;
		background-color: rgba(0,0,0,0.2);
	}
	#box-register {
		width: 500px;
		padding: 40px 0;
		opacity: 0.9;
		border-radius: 40px;
		text-align: center;
	}
	.box {
		margin-top: 250px;
		margin-left: 110px;
	}
	
</style>
</head>
<body class="pt-5">
<%@ include file="common/header.jsp" %>
<div class="container">
	<div class="row box">
		<div class="row mb-5">
			<h3 class="text-white">언제 어디서나 운동을 일상처럼</h3>
		</div>
		<div class="row mb-5">
			<h1 class="text-white"><strong>Everywhere JA Fitness</strong></h1>
		</div>
		<div class="row">
			<sec:authorize access="isAuthenticated()">
				<div class="row border" id="box-register">
					<h2 class="mb-4" style="color:white;"><strong>프로그램 신청하기</strong></h2>
					<a class="btn btn-lg btn-outline-light" href="/user/classReg" style="width:200px; margin:0 auto;">프로그램 신청</a>
				</div>
			</sec:authorize>
		</div>
	</div>
</div>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	
})
</script>
</body>
</html>