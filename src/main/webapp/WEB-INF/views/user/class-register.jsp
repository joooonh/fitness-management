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
	
</style>
</head>
<body class="pt-5">
<c:set var="menu" value="info" />
<%@ include file="../common/header.jsp" %>
<div class="container mt-5">
	<div class="row mb-3" id="row">
		<div class="col-5 border" id="col">
			<input type="hidden" id="latitude" name="latitude" value="${club.latitude }" />
			<input type="hidden" name="longitude" value="${club.longitude }" />
			<div id="map" style="width:500px;height:400px;"></div>
		</div>
		<div class="col-7 border" id="col2">
			<form class="form border bg-light p-2" id="form-classReg" method="post" action="">
				<div class="row">
					<h5>예약접수</h5>
				</div>
				<div class="row">
					달력 API (일정)
				</div>
				<div class="row">
					시간
				</div>
				<div class="row">
					<button type="submit" class="btn btn-dark">신청</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=87a85d046c0b17485040c5ec4b0afaca"></script>
<script type="text/javascript">
$(function(){
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