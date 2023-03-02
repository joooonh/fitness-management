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
					<span><h5 class="" ><i class="bi bi-shop-window ms-2 me-3"></i>매장 정보 수정</h5></span>
					<hr width="103%" color="gray">
				</div>
			</div>
			
			<div class="row">
				<div class="col-12 club-wrap">
					<form action="modify" method="post">
						<input type="hidden" name="no" value=${club.no } />
						<input type="hidden" name="latitude" value="${club.latitude }" />
						<input type="hidden" name="longitude" value="${club.longitude }" />
						<table class="table table-bordered align-middle">
							<tr>
								<th class="table-light">매장명</th>							
								<td><input type="text" class="form-control" name="name" value="${club.name }" /></td>
							</tr>
							<tr>
								<th class="table-light">전화번호</th>							
								<td><input type="text" class="form-control" name="tel" value="${club.tel }" /></td>
							</tr>
							<tr>
							 	<th class="form-label table-light">우편번호</th>
							    <td class="d-flex justify-content-start">
									<input type="text" name="zipcode" class="form-control w-25 me-3" value="${club.zipcode }" />
									<button type="button" class="btn btn-outline-secondary btn-sm" id="btn-search-zipcode">우편번호검색</button>
							    </td>
							</tr>
							<tr>
								<th class="table-light">주소</th>							
								<td><input type="text" id="basicAddress" class="form-control" name="basicAddress" value="${club.basicAddress }" /></td>
							</tr>
							<tr>
								<th class="table-light">상세주소</th>							
								<td><input type="text" class="form-control" name="detailAddress" value="${club.detailAddress }" /></td>
							</tr>
							<tr>
								<th class="table-light">지도</th>							
								<td><div id="map"></div></td>
							</tr>
							<tr>
								<th class="table-light">매장소개</th>							
								<td><textarea class="form-control" name="description">${club.description }</textarea></td>
							</tr>
							<tr>
								<th class="table-light">영업시간</th>							
								<td>
									<div class="mb-3 weekdaysOpenHours">평일 영업시간 : <span>${club.weekdaysOpenHours }</span></div>
									<div class="row g-4 align-items-center mb-3">
										<div class="col-auto mt-3">
											<span>평일 영업 시작시간</span>
										</div>
										<div class="col-auto mt-3">
											<input type="time" class="form-control" name="weekdaysStartTime">
										</div>
										<div class="col-auto mt-3">
											<span>평일 영업 종료시간</span>
										</div>
										<div class="col-auto mt-3">
											<input type="time" class="form-control" name="weekdaysEndTime">
										</div>
									</div>		
																
									<div class="mb-3 weekendsOpenHours">주말 영업시간 : <span>${club.weekendsOpenHours }</span></div>
									<div class="row g-4 align-items-center mb-3">
										<div class="col-auto mt-3">
											<span>주말 영업 시작시간</span>
										</div>
										<div class="col-auto mt-3">
											<input type="time" class="form-control" name="weekendsStartTime">
										</div>
										<div class="col-auto mt-3">
											<span>주말 영업 종료시간</span>
										</div>
										<div class="col-auto mt-3">
											<input type="time" class="form-control" name="weekendsEndTime">
										</div>
									</div>	
									
									<div class="d-flex align-items-center">
										<span>휴무일 :</span> <input type="text" class="form-control w-50 ms-3" name="closedDays" value="${club.closedDays }" /> 
									</div>
								</td>
							</tr>
						</table>
					
						<div class="row">
							<div class="col-12 text-end">
								<a href="/emp/club/club" class="btn btn-secondary">취소</a>
								<button type="button" id="btn-save-club" class="btn btn-primary">저장</button>
							</div>
						</div>
					</form>
				</div>
			</div>
			
		</div>
	</div>
</div>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f3d8a8eea76fdb2ef8ea7772409ebb82&libraries=services"></script>
<script type="text/javascript">
$(function() {
	let daysStartTime = $(".weekdaysOpenHours span").text();
	let weekendsOpenHours = $(".weekendsOpenHours span").text();
	// 평일영업시간에서 시작시간을 구한다.
	let daysStartHour = daysStartTime.slice(0,5);
	// 평일영업시간에서 종료시간을 구한다.
	let daysEndHour = daysStartTime.slice(-5);
	// 주말영업시간에서 시작시간을 구한다.
	let endsStartHour = weekendsOpenHours.slice(0,5);
	// 주말영업시간에서 종료시간을 구한다.
	let endsEndHour = weekendsOpenHours.slice(-5);
	$("input[name=weekdaysStartTime]").val(daysStartHour);
	$("input[name=weekdaysEndTime]").val(daysEndHour);
	$("input[name=weekendsStartTime]").val(endsStartHour);
	$("input[name=weekendsEndTime]").val(endsEndHour);
	
	// 위도값을 구한다.
	let latitude = $("input[name=latitude]").val();
	// 경도값을 구한다.
	let longitude = $("input[name=longitude]").val();
	// 지도를 표시할 div
	var mapContainer = document.getElementById('map'), 
	mapOption = {
	    center: new daum.maps.LatLng(latitude, longitude), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};
	
	//지도를 미리 생성
	var map = new daum.maps.Map(mapContainer, mapOption);
	//주소-좌표 변환 객체를 생성
	var geocoder = new daum.maps.services.Geocoder();
	//마커를 미리 생성
	var marker = new daum.maps.Marker({
	    position: new daum.maps.LatLng(latitude, longitude),
	    map: map
	});

	
	// 주소검색
	$("#btn-search-zipcode").click(function() {
	  new daum.Postcode({
	        oncomplete: function(data) {
				// 기본주소 정보를 대입하는 변수를 선언한다.
				let address;
				// 사용자가 도로명 주소를 선택했을 때 data.userSelectedType은 R이다.
				if (data.userSelectedType === 'R') {
				  address = data.roadAddress;
				} else {
				  address = data.jibunAddress;
				}
				// 우편번호 입력필드와 기본주소 입력필드에 값을 입력한다.
				$(":input[name=zipcode]").val(data.zonecode);
				$(":input[name=basicAddress]").val(address);
				
				// 상세주소 입력필드에 값을 지우고 포커스를 위치시킨다.
				$(":input[name=detailAddress]").val("").focus();
				

	            var addr = data.address; // 최종 주소 변수
	            // 주소 정보를 해당 필드에 넣는다.
	            document.getElementById("basicAddress").value = addr;
	            // 주소로 상세 정보를 검색
	            geocoder.addressSearch(data.address, function(results, status) {
	                // 정상적으로 검색이 완료됐으면
	                if (status === daum.maps.services.Status.OK) {

	                    var result = results[0]; //첫번째 결과의 값을 활용

	                    // 해당 주소에 대한 좌표를 받아서
	                    var coords = new daum.maps.LatLng(result.y, result.x);
	        	        $("input[name=latitude]").val(result.y);
	        	    	$("input[name=longitude]").val(result.x);
	        	    	
	                    // 지도를 보여준다.
	                    mapContainer.style.display = "block";
	                    map.relayout();
	                    // 지도 중심을 변경한다.
	                    map.setCenter(coords);
	                    // 마커를 결과값으로 받은 위치로 옮긴다.
	                    marker.setPosition(coords)
	                }
	            });
	            
	        }
	    }).open();
	});
	
	$("#btn-save-club").click(function() {
		if ($("input[name=name]").val() == "") {
			alert("매장명을 입력하세요");
			return false
		};
		if ($("input[name=tel]").val() == "") {
			alert("전화번호를 입력하세요");
			return false
		};
		if ($("input[name=zipcode]").val() == "") {
			alert("우편번호를 입력하세요");
			return false
		};
		if ($("input[name=basicAddress]").val() == "") {
			alert("주소를 입력하세요");
			return false
		};
		if ($("input[name=weekdaysStartTime]").val() == "") {
			alert("평일 영업시작시간을 선택하세요");
			return false
		};
		if ($("input[name=weekdaysEndTime]").val() == "") {
			alert("평일 영업종료시간을 선택하세요");
			return false
		};
		if ($("input[name=weekendsStartTime]").val() == "") {
			alert("주말 영업시작시간을 선택하세요");
			return false
		};
		if ($("input[name=weekendsEndTime]").val() == "") {
			alert("주말 영업종료시간을 선택하세요");
			return false
		};
		$("form").trigger("submit");
	});
})
</script>
</body>
</html>