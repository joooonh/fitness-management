<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/common.css">
<title>애플리케이션</title>
<style type="text/css">
	body {
        height: 100vh;
        width: 100vw;
        background-image: url('/resources/images/home.jpg');
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
	.container {
		width: 300vw%;
		margin: 0 auto;
		padding: 100px 0;
		padding-left: 0px;
		margin-top: 200px;
		opacity: 0.9;
		border-radius: 40px 40px 40px 40px;
	}
	.col-6 {
		text-align: center;
	}
	h1 {
		color: white;
		font-weight: bold;
		margin-bottom: 100px;
	}
	
</style>
</head>

<body class="pt-5">
<%@ include file="common/header.jsp" %>
<div class="container border">
   <div class="row" id="row">
		<div class="col-6">
			<h1>프로그램 조회하기</h1>
			<button type="button" class="btn btn-lg btn-outline-light">프로그램 조회</button>
		</div>
		<div class="col-6">
			<h1>수업 예약하기</h1>
			<button type="button" class="btn btn-lg btn-outline-light">예약하기</button>
		</div>
   </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<body>
<!------------------------------------ 헤더 navbar 영역 ---------------------------------------->
<%@ include file="common/header.jsp"%>
	<div class="container-fluid mt-4">
		<div class="row">
			<div class="col-md-2 sidebar">
				<!---------------------------------- 사이드 바 영역  ----------------------------------------->
				<%@ include file="common/sidebar.jsp"%>
			</div>
			<div class="col-md-10 ps-4 pt-5">
				<!--------------------------------- Content 영역 ------------------------------------------->
				<p>개인화면구현</p>
				<p>개인화면구현</p>
				<p>개인화면구현</p>
			</div>
		</div>
	</div>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

</body>
</html>