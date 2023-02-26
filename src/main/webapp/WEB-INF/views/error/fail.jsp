<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/background.css">
<link rel="stylesheet" href="/resources/css/success.css">
<title>애플리케이션</title>
</head>
<body class="pt-5">
<%@ include file="../common/header.jsp" %>
<div class="container">
   <div class="row" id="row">
		<div class="p-4" id="box">
			<div class="alert alert-danger text-center">
				<h1 class="mb-4">로그인 실패</h1>
				<p style="text-align:center">비밀번호가 일치하지 않습니다.</p>
			</div>
		</div>
   </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>