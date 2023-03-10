<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/class-register.css">
<title>중앙피트니스</title>
</head>
<body class="pt-5">
<c:set var="menu" value="info" />
<%@ include file="../common/header.jsp" %>
<div class="container mt-5">
	<div class="row mb-3" id="row">
		<!-- 매장 정보 (좌) -->
		<div class="col-4 border p-4 bg-light">
			<input type="hidden" id="latitude" name="latitude" value="${club.latitude }" />
			<input type="hidden" name="longitude" value="${club.longitude }" />
			<div class="row mb-5">
				<h4>
					<img src="/resources/images/logo.svg" alt="Logo" width="40" height="27" class="d-inline-block text-black">
					<strong>중앙피트니스</strong>
				</h4>
			</div>
			<div class="row mb-3">
				<span><i class="bi bi-megaphone-fill me-2"></i>${club.description }</span>
			</div>
			<div class="row mb-3">
				<span><i class="bi bi-telephone-fill me-2"></i>${club.tel }</span>
			</div>
			<div class="row mb-5">
				<span><i class="bi bi-geo-alt-fill me-2"></i>${club.basicAddress } ${club.detailAddress }</span>
			</div>
			<div class="row mb-5">
				<div id="map" style="width:530px; height:400px;"></div>
			</div>
			<div class="row mb-3">
				<span><i class="bi bi-pin-angle-fill me-2"></i>평일 영업시간 : ${club.weekdaysOpenHours }</span>
			</div>
			<div class="row mb-3">
				<span><i class="bi bi-pin-angle-fill me-2"></i>주말 영업시간 : ${club.weekendsOpenHours }</span>
			</div>
			<div class="row mb-3">
				<span><i class="bi bi-pin-angle-fill me-2"></i>휴무일 : ${club.closedDays }</span>
			</div>
		</div>
		<!-- 프로그램 신청 (우) -->
		<div class="col">
			<form class="form border bg-light p-4" id="form-classReg" method="post" action="/user/classReg">
				<div class="row mb-3">
					<h4><strong>프로그램 신청</strong></h4>
				</div>
				<div class="row mb-3">
					<div class="mb-3">
						<div id="calendar"></div>
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-2">
						<label class="form-label"><strong>프로그램</strong></label>
					</div>
					<div class="col-5">
						<select name="programNo" class="form-select d-inline">
							<option value="">프로그램명 선택</option>
							<c:forEach var="program" items="${programList }">
								<option value="${program.no }" ${param.programNo eq program.no ? 'selected' : '' }>${program.name }</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-2">
						<label class="form-label"><strong>시간</strong></label>
					</div>
					<div class="col-5">
						<input type="text" class="form-control" id="class-time" value="시간" disabled="disabled">
					</div>
				</div>
				<div class="row mb-5">
					<div class="col-2">
						<label class="form-label"><strong>가격</strong></label>
					</div>
					<div class="col-5">
						<input type="text" class="form-control" id="class-price" value="가격" disabled="disabled">
					</div>
				</div>
				<div class="row mb-4">
					<h4><strong>회원권 신청 (선택사항)</strong></h4>
				</div>
				<div class="row mb-3">
					<div class="col-2">
						<label class="form-label"><strong>신청여부</strong>
					</div>
					<div class="col-10">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="checkbox" id="memRegister" checked>
							<label class="form-check-label">신청</label>
						</div>										
					</div>
				</div>
				<div class="row mb-3 member-box">
					<div class="col-2">
						<label class="form-label"><strong>시작날짜</strong>
					</div>
					<div class="col-4">
						<input type="date" name="memStartDate" class="form-control" >
					</div>
					<div class="col-2">
						<label class="form-label"><strong>기간</strong>
					</div>
					<div class="col-4">
						<select name="memPeriod" class="form-select d-inline" >
							<option value="">회원권 기간 선택</option>
							<option value="1">1개월</option>
							<option value="3">3개월</option>
							<option value="6">6개월</option>
							<option value="12">12개월</option>
						</select>
					</div>
				</div>
				<div class="row mb-5 member-box">
					<div class="col-2">
						<label class="form-label"><strong>종료날짜</strong>
					</div>
					<div class="col-4">
						<input type="date" name="memEndDate" class="form-control" readonly="readonly">
					</div>
					<div class="col-2">
						<label class="form-label"><strong>가격</strong>
					</div>
					<div class="col-4">
						<input type="text" name="memPrice" class="form-control" value="" readonly="readonly">
					</div>
				</div>
				<div class="row mb-3">
					<button type="submit" class="btn btn-lg btn-dark">신청하기</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=87a85d046c0b17485040c5ec4b0afaca"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.4/index.global.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<script type="text/javascript">
$(function(){
	
 	// 달력 API 
	let calendarEl = document.getElementById("calendar");
	// FullCalendar의 Calender객체를 생성한다.
	let calendar = new FullCalendar.Calendar(calendarEl, {
		headerToolbar: {
			start: '',
			center: 'title'
		},
		locale: 'ko',
		initialView: 'dayGridMonth',	
		// 일정정보를 조회하고, successCallback(이벤트배열)함수의 매개변수로 일정정보를 제공하고 실행하면 화면에 반영된다.
		events: function(info, successCallback, failureCallback) {	// events 프로퍼티에는 달력이 변경될 때마다 실행되는 함수를 등록한다.
			refreshEvents(info, successCallback);					// info는 화면에 표시되는 달력의 시작일, 종료일을 제공한다.
		}
	});
	// Calendar를 렌더링한다.
	calendar.render();

	// 16진수(hex) 색상 코드를 랜덤하게 생성하는 함수
	function generateColor() {
		// hexArray 배열에 16진수 코드 저장
		const hexArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F'];
		let code = "";
		for (let i = 0; i < 6; i++) {
			// 랜덤한 인덱스를 구하고 해당 인덱스에 해당하는 코드를 code 문자열에 추가, 이 과정을 6번 반복
			code += hexArray[Math.floor(Math.random() * 16)];
		}
		// 16진수 색상 코드 생성
		return '#' + code;
	}

	// 반복되는 수업들을 db에서 가져오기
	// 지금 많이 쓰이는 async/await 비동기 호출 방식 (.then(), .done(), catch()를 사용하지 않고 결과값을 바로 변수에 넣는 방식)
	async function refreshEvents(info, successCallback) {
		try {
			// 비동기 방식으로 응답받은 결과값을 events 변수에 저장
			const events = await $.get("/user/events");
			// lodash 라이브러리
			const data =
				_.chain(events)											// 메소드 체이닝
				 .orderBy(["id"], ["asc"])								// 응답객체의 id 속성 기준으로 정렬
				 .groupBy("id")											// id 속성 기준으로 그룹화
				 .map((groupById) => {									// 그룹화된 배열 내 각각의 요소에 대해 함수를 적용하고, 반복하는 메소드
					const color = generateColor();						// 랜덤 색상 생성 메소드 결과를 color변수에 저장
					groupById.forEach((data) => data.color = color);	// 그룹화된 데이터를 돌면서 각 데이터의 color를 color로 설정
					return groupById;									// 색상이 지정된 응답객체를 반환 
				 })
				 .value()												// 메소드 체인 종료, 최종결과값 반환
				 .reduce((o1, o2) => o1.concat(o2), []);				// 중첩된 배열을 평평하게 반환
			successCallback(data);	// list<ScheduleCheckDto>
		} catch(e) {
			// Ajax 요청 실패 시 처리 로직
			log.error(e);
			successCallback([]);
		}
	}
	
	// 프로그램 선택 유효성 체크 
	$("#form-classReg").submit(function(){
		const progNo = $(":input[name=programNo]").val();
		const memStartDate = $(":input[name=memStartDate]").val();
		const memPeriod = $(":input[name=memPeriod]").val();
		
		if(progNo === ""){
			alert("프로그램을 선택하세요.");
			return false;
		}
		if($("#memRegister").prop("checked")){
			if(memStartDate === ""){
				alert("회원권 시작날짜를 선택하세요.");
				return false;
			}
			if(memPeriod === ""){
				alert("회원권 기간을 선택하세요.");
				return false;
			}
		}
	})
	
	// 회원권 신청여부를 선택할 때만 서버로 전송
	$("#memRegister").change(function() {
		if ($(this).prop("checked")) {
			$(".member-box :input").prop("disabled", false);
		} else {
			$(".member-box :input").prop("disabled", true);
		}
	});
	
	// 선택한 프로그램에 해당하는 시간, 가격 표시 ajax
	$(":input[name=programNo]").change(function(){
		const programNo = $(this).val();
		$.getJSON("/user/classInfo", {no:programNo}, function(program){
			$("#class-time").val(program.startHour);
			$("#class-price").val(program.price);
		})
	})
	
	// 회원권 기간 설정에 따른 회원권 종료 날짜, 가격 표시 ajax 
    $(":input[name=memPeriod]").on('change', function(){
    	// 종료날짜 계산
	    const startDate= $("input[name=memStartDate]").val();
	    const period = $(":input[name=memPeriod]").val();
	    
	    const endDate = moment(startDate).add(period, 'months').format("YYYY-MM-DD");
	    $("input[name=memEndDate]").val(endDate);
	    
	    // 가격 표시
	    const totalPrice = period*150000;
	    $("input[name=memPrice]").val(totalPrice);
    })
	
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