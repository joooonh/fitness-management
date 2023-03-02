<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/content.css">
<title>중앙피트니스</title>
</head>
<body>

<!------------------------------------ 헤더 navbar 영역 ---------------------------------------->
<%@ include file="../../common/header.jsp" %>
<div class="container-fluid mt-4">
	<div class="row">
		<div class="col-md-2 sidebar">
			<!---------------------------------- 사이드 바 영역  ----------------------------------------->
			<%@ include file="../../common/sidebar.jsp" %>
		</div>
		<div class="col-md-10 ps-4 pt-5">
			<!--------------------------------- Content 영역 ------------------------------------------->
			<div class="row">
				<div class="col-12">
					<span><h5 class="" ><i class="bi bi-shop-window ms-2 me-3"></i>매장정보</h5></span>
					<hr width="103%" color="gray">
				</div>
			</div>
			
			<div class="row">
				<div class="col-12 club-wrap">
					<input type="hidden" id="latitude" name="latitude" value="${club.latitude }" />
					<input type="hidden" name="longitude" value="${club.longitude }" />
					<table class="table table-bordered align-middle">
						<tr>
							<th class="table-light">매장명</th>							
							<td>${club.name }</td>
						</tr>
						<tr>
							<th class="table-light">전화번호</th>							
							<td>${club.tel }</td>
						</tr>
						<tr>
							<th class="table-light">주소</th>							
							<td>${club.basicAddress }</td>
						</tr>
						<tr>
							<th class="table-light">상세주소</th>							
							<td>${club.detailAddress }</td>
						</tr>
						<tr>
							<th class="table-light">지도</th>							
							<td>
								<div id="map" style="width:100%;height:200px;"></div>
							</td>
						</tr>
						<tr>
							<th class="table-light">매장소개</th>							
							<td>${club.description }</td>
						</tr>
						<tr>
							<th class="table-light">영업시간</th>							
							<td>
								<p><span>평일 영업시간 : </span>${club.weekdaysOpenHours }</p>
								<p><span>주말 영업시간 : </span>${club.weekendsOpenHours }</p>
								<p><span>휴무일	 : </span>${club.closedDays }</p>
							</td>
						</tr>
					</table>
					
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<div class="row">
							<div class="col-12">
								<a href="/admin/club/modify?no=${club.no }" class="btn btn-primary float-end">수정</a>
							</div>
						</div>
					</sec:authorize>
				</div>
			</div>
		</div>
	</div>
</div>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f3d8a8eea76fdb2ef8ea7772409ebb82"></script>
<script type="text/javascript">
$(function() {
	var latitude = $("input[name=latitude]").val();
	var longitude = $("input[name=longitude]").val();
	let container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	
	let options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};
	//지도 생성 및 객체 리턴
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