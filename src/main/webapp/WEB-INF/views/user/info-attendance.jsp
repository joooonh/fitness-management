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
				<div class="col pt-5">
					<div id="calendar" ></div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src='https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.1/index.global.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js" ></script>
<script src="https://momentjs.com/downloads/moment-with-locales.js" type="text/javascript"></script>
<script src="https://momentjs.com/downloads/moment.js"></script>
<script type="text/javascript">
	//FullCalendar의 Calender객체를 생성한다.
	// new FullCalendar.Calendar(엘리먼트객체, 옵션객체)
	// new FullCalendar.Calendar(document.getElementById("calendar"), {
	//		locale: "ko",
	//		initialView: "dayGridMonth",
	//		events: function(int, successCallback, failureCallback) { ... }
	//		dateClick: function(info) { ... }
	// })
	let calendar = new FullCalendar.Calendar(document.getElementById("calendar"), {
		// 달력의 월, 요일정보가 한글로 표시되도록 한다.
		locale: 'ko',
		// 달력의 초기화면을 월별로 일정이 표시되게 한다.
		initialView: 'dayGridMonth',
		// events 프로퍼티에는 달력이 변경될 때마다 실행되는 함수를 등록한다.
		// info는 화면에 표시되는 달력의 시작일, 종료일을 제공한다.
		// 일정정보를 조회하고, successCallback(이벤트배열)함수의 매개변수로 일정정보를 제공하고 실행하면 화면에 반영된다.
		events: function(info, successCallback, failureCallback) {
			refreshEvents(info, successCallback);
		},
		// dateClick 프로퍼티에는 달력의 날짜를 클릭했을 때 실행되는 함수를 등록한다.
		// info는 클릭한 날짜의 날짜정보를 제공한다.
		dateClick: function(info) {
			let clickedDate = info.dateStr;
			openTodoModal(clickedDate);
		},
		// eventClick 프로퍼티에는 달력의 이벤트(일정)을 클릭했을 때 실행되는 함수를 등록한다.
		eventClick: function(info) {
			
		}
	});
	// Calendar를 렌더링한다.
	calendar.render();
	
	
	function refreshEvents(info, successCallback) {
		let startDate = moment(info.start).format("YYYY-MM-DD");
		let endDate = moment(info.end).format("YYYY-MM-DD");
		let param = {
			startDate: startDate,
			endDate: endDate
		};
		
		$.ajax({
			type: 'get',
			url: '/user/userEvents',
			data: param,
			dataType: 'json'
		})
		.done(function(events) {
			successCallback(events);
		})
	}
</script>
</body>
</html>