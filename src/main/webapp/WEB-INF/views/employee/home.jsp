<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/emp-home.css">
<title>중앙피트니스</title>
</head>
<body>
<!-- 헤더 navbar 영역 -->
<%@ include file="../common/header.jsp" %>
<div class="container-fluid mt-4">
	<div class="row">
		<div class="col-md-2 sidebar">
			<!-- 사이드 바 영역  -->
			<%@ include file="../common/sidebar.jsp" %>
		</div>
		<div class="col-md-10 ps-4 pt-5">
			<!-- Content 영역 -->
			<div class="row box">
				<div class="row mb-5">
					<h3 class="text-white">언제 어디서나 운동을 일상처럼</h3>
				</div>
				<div class="row mb-5">
					<h1 class="text-white"><strong>Everywhere JA Fitness</strong></h1>
				</div>
				<div id="box-chat">
					<a href="/emp/chat"><img src="/resources/images/chat.png" alt="chat" width="130" height="130" id="img-chat"></a>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>