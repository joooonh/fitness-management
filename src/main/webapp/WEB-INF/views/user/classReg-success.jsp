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
	
	#box h1 {
		margin: 0 auto;
		text-align: center;
		font-size: xx-large;
		font-weight: bold;
	}
	
	#row{
		background-color: #eee;
		width: 800px;
		margin: 0 auto;
		padding: 90px 0;
		padding-left: 100px;
		padding-right: 100px;
		margin-top: 230px;
		opacity: 0.93;
		border-radius: 40px 40px 40px 40px;
	}
</style>
</head>
<body class="pt-5">
<c:set var="menu" value="login" />
<%@ include file="../common/header.jsp" %>
<div class="container">
   <div class="row" id="row">
			<div class="p-4" id="box">
				<h1 class="mb-4">프로그램 신청 완료</h1>
				<p style="text-align:center">프로그램 신청이 완료되었습니다.</p>
			</div>
   </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>