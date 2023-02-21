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
	#side-menu{
		margin-top: 100px;
		list-style: none;
		background-color: #eee;
		text-align: center;
		width: 250px;
		height: 710px;
		padding: 30px;
		border-radius: 40px 40px 40px 40px;
	}
	#side-menu a{
		font-size: large;
		font-weight: bold;
		text-decoration: none;
		display: block;
		color: black;
		line-height: 400%;
		border-radius: 40px 40px 40px 40px;
	}
	#side-menu a:hover{
		background-color: black;
		color: white;
	}
	#current-page{
		background-color: black;
	}
	#form-delete{
		margin-top: 100px;
		padding: 50px;
	}
	h5{
		font-weight: bold;
		margin-bottom: 50px;
	}
	
</style>
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
				<li><a href="/user/attendance">내 출석 조회</a></li>
				<li><a href="/user/delete" style="color:white" id="current-page">회원 탈퇴</a></li>
			</div>
		</div>
		<div class="col-9" id="col2">
			<div class="row mb-3">
				<div class="col">
					<form class="form border" id="form-delete" method="post" action="delete">
						<h5>비밀번호를 입력하세요.</h5>
						<div class="row mb-3">
							<div class="col-3">
								<label class="form-label">비밀번호</label>
							</div>
							<div class="col-9 mb-5">
								<input class="form-control" type="password" name="password">
							</div>
						</div>
						<div class="text-end">
							<button type="submit" class="btn btn-dark">탈퇴하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	
})
</script>
</body>
</html>