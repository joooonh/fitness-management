<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/userInfo-sideMenu.css">
<title>애플리케이션</title>
</head>
<body class="pt-5">
<c:set var="menu" value="info" />
<%@ include file="../common/header.jsp" %>
<div class="container">
	<div class="row mb-3" id="row">
		<div class="col-3" id="col">
			<div id="side-menu">
				<li><a href="/user/info">내 정보 조회/수정</a></li>
				<li><a href="/user/membership">내 회원권 조회</a></li>
				<li><a href="/user/reservation">내 예약 조회</a></li>
				<li><a href="/user/attendance" style="color:white" id="current-page">내 출석 조회</a></li>
				<li><a href="/user/delete">회원 탈퇴</a></li>
			</div>
		</div>
		<div class="col-9" id="col2">
			<div class="row mb-3">
				<div class="col">
					출석 조회
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>