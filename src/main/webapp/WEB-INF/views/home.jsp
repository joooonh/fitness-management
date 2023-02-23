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
	#box-map {
		background-color: rgba(255,255,255,0.3);
		width: 900px;
		margin: 20px auto;
		padding: 20px 50px;
		margin-top: 20px;
		border-radius: 40px;
		color: white;
		
	}
	#box-register {
		width: 700px;
		margin: 0 auto;
		padding: 40px 0;
		opacity: 0.9;
		border-radius: 40px 40px 40px 40px;
		text-align: center;
	}
	.img-logo {
	filter: invert(100%) sepia(100%) saturate(0%) hue-rotate(288deg)
		brightness(102%) contrast(102%);
	}
	
</style>
</head>
<body class="pt-5">
<%@ include file="common/header.jsp" %>
<div class="container">
	<div class="row border" id="box-map">
		<div class="row">
			<div class="row text-center mb-2">
				<img src="/resources/images/logo.svg" alt="Logo" width="40" height="27" class="img-logo me-2">
				<h3><strong>중앙피트니스</strong></h3>
			</div>
			<input type="hidden" id="latitude" name="latitude" value="${club.latitude }" />
			<input type="hidden" name="longitude" value="${club.longitude }" />
			<div class="box mb-3">
				<div id="map" style="width:770px; height:400px;"></div>
			</div>
		</div>
		<div class="row ms-5 text-white">
			<div class="col">
				<div class="row mb-3">
					<span><i class="bi bi-telephone-fill me-2"></i><strong>${club.tel }</strong></span>
				</div>
				<div class="row mb-3">
					<span><i class="bi bi-geo-alt-fill me-2"></i><strong>${club.basicAddress } ${club.detailAddress }</strong></span>
				</div>
			</div>
			<div class="col">
				<div class="row mb-3 ">
					<span><i class="bi bi-pin-angle-fill me-2"></i><strong>평일 영업시간 : ${club.weekdaysOpenHours }</strong></span>
				</div>
				<div class="row mb-3 ">
					<span><i class="bi bi-pin-angle-fill me-2"></i><strong>주말 영업시간 : ${club.weekendsOpenHours }</strong></span>
				</div>
				<div class="row mb-3 ">
					<span><i class="bi bi-pin-angle-fill me-2"></i><strong>휴무일 : ${club.closedDays }</strong></span>
				</div>
			</div>
		</div>
		<sec:authorize access="isAuthenticated()">
			<div class="row border" id="box-register">
				<h2 class="mb-4" style="color:white;"><strong>프로그램 신청하기</strong></h2>
				<a class="btn btn-lg btn-outline-light" href="/user/classReg" style="width:300px; margin:0 auto;">프로그램 신청</a>
			</div>
		</sec:authorize>
	</div>
</div>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=87a85d046c0b17485040c5ec4b0afaca"></script>
<script type="text/javascript">
$(function(){
	
	// 카카오 지도 API 
	var latitude = $("input[name=latitude]").val();
	var longitude = $("input[name=longitude]").val();
	var container = document.getElementById('map'); // 지도를 담을 영역의 DOM 레퍼런스
	
	var options = { // 지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
		level: 3 // 지도의 레벨(확대, 축소 정도)
	};
	// 지도 생성 및 객체 리턴
	var map = new kakao.maps.Map(container, options); 
	// 마커가 표시될 위치
	var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 
	// 마커를 생성
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});
	// 마커가 지도 위에 표시되도록 설정
	marker.setMap(map);
})
</script>
</body>
</html>