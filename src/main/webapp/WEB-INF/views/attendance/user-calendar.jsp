<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" 	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="../resources/css/attendance-user-calendar.css">
<link rel="stylesheet" href="../resources/css/common.css">
<style type="text/css">
table {
    width: 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
    border-color: #E0E0E0;
    border-radius: 10px;
  }
th, td {
  	border-color: none;
    padding: 10px;
  }

</style>
<title>애플리케이션</title>
</head>
<body>
<!------------------------------------ 헤더 navbar 영역 ---------------------------------------->
	<%@ include file="../common/header.jsp"%>
	<div class="container-fluid mt-4">
		<div class="row">
			<div class="col-md-2 sidebar">
				<!---------------------------------- 사이드 바 영역  ----------------------------------------->
				<%@ include file="../common/sidebar.jsp"%>
			</div>

			<div class="col-md-10 ps-4 pt-2">
				<div class="row pt-5">
					<div class="col-12">
						<p class="memberH">
							<i class="bi bi-person-check-fill  ms-2 me-3"></i>회원출석관리
						</p>
						<hr width="100%" color="gray">
					</div>
				</div>
				<div class="row mb-2">
					<div class="col-6">
						<div class="row mb-3">
							<div class="col-12">
								<a class="btn btn-secondary" href="/emp/userAttList"> <i class="bi bi-list-columns-reverse"></i> 출석리스트 </a></button>
								<a class="btn btn-secondary" href="/emp/userDay"><i class="bi bi-calendar3"></i>일별출석리스트</a> 
								<a class="btn btn-secondary" href="/emp/userCalendar"><i class="bi bi-calendar-week"></i>출석달력</a>
							</div>
						</div>
						
							<div class="row mb-3">
								<h3 class="bg-dark text-white p-2 fs-6 fw-bold">회원상세정보</h3>
								<table class="table table-bordered ">
									<colgroup>
										<col width="20%">
										<col width="30%">
										<col width="23%">
										<col width="27%">
									</colgroup>
									<tbody>
										<tr>
											<td bgcolor="#FF0000">아이디</td>
											<td><span id="user-id"></span></td>
											<td>회원이름</td>
											<td><span id="user-name"></span></td>
										</tr>
										<tr>
											<td>회원번호</td>
											<td><span id="user-no"></span></td>
											<td>휴대폰</td>
											<td><span id="user-tel"></span></td>
										</tr>
										
										<tr>
											<td>이메일</td>
											<td><span id="user-email"></td>
											<td>성별</td>
											<td><span id="user-gender"></td>
										</tr>
										
										<tr>
											<td>회원출석일자</td>
											<td>
												<span class="badge text-bg-secondary" id="user-attDate"></td>
											</td>
											<td>프로그램출석일자</td>
											<td>
												<span class="badge text-bg-secondary" id="user-classDate"></td>
											</td>
										</tr>
										
										<tr>
											<td>프로그램명</td>
											<td><span class="badge text-bg-success" id="prog-name"></td>
											<td>회원권</td>
											<td><span class="badge text-bg-warning" id="user-membership"></td>
										</tr>
									</tbody>
								</table>
						</div>
						<div class="row mb-2">
							<div class="col-12">
								<form id="form-search" method="get" action="/emp/userCalendar">
									<input class="form-control form-control-sm d-inline-block border-secondary"  type="date"  style="width: 120px;">
									
									<select class="form-select form-select-sm d-inline-block border-secondary"	name="programInfo" style="width: 130px;">
											<option value="" selected>= 프로그램 =</option>
											<c:forEach var="category" items="${FitnessProgramCategories }">
												<option value="${category.categoryNo }" ${param.programInfo eq '${category.categoryNo}' ? 'selected' : ''}>${category.categoryName }</option>
											</c:forEach>
			
									</select> 
									
									<select class="form-select form-select-sm d-inline-block border-secondary"	name="opt" style="width: 130px;">
											<option value="" selected >선택하세요</option>
											<option value="userName" ${param.opt eq 'userName' ? 'selected' : '' }>회원이름</option>
											<option value="userNo" ${param.opt  == 'userNo' ? 'selected' : ''} >회원번호</option>
											<option value="userTel" ${param.opt  == 'userTel' ? 'selected' : ''}>휴대폰</option>
									</select> 
									
									<input class="form-control form-control-sm d-inline-block border-secondary"	name="keyword" style="width: 150px;">
									<button id="btn-search" type="submit" class="btn btn-sm" style="background-color: #E0E0E0;"> <i class="bi bi-search"></i></button>
								</form>
							</div>
						</div>
						
						<div class="row">
								<table class="table table-hover" class="table table-sm" id="user-att-table">
									<colgroup>
										<col width="15%">
										<col width="15%">
										<col width="10%">
										<col width="15%">
										<col width="30%">
									</colgroup>
									<thead  class="table-light">
										<tr style="background-color:#757575; color=white;">
											<th class="text-center"><span>회원번호</span></th>
											<th class="text-center">회원이름</th>
											<th class="text-center">성별</th>
											<th class="text-center"> 회원권</th>
											<th class="text-center">프로그램명</th>
										</tr>
									</thead>
									<tbody>
										<c:choose> 
											<c:when test="${empty userAtts }">
												<tr>	
													<td colspan="12" class="text-center">출석이력이 없습니다.</td>
												</tr>	
											</c:when>
											<c:otherwise>
												<c:forEach var="user" items="${userAtts }">
													<tr>
														<td class="text-center"><span>${user.userNo }</span></td>
														<td class="text-center"><a href="" data-user-No="${user.userNo }" class="text-decoration-none">${user.userName } </a></td>
														<td class="text-center">${user.userGender }</td>
														<td class="text-center">${user.membership }</td>
														<td>${user.programName }</td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
								
								<c:if test="${not empty userAtts }">
										<nav class="pt-3">
											<ul class="pagination pagination-sm justify-content-center">
												<li class="page-item">
													<a class="page-link ${pagination.first ? 'disabled' : '' }"
															href="userCalendar?page=${pagination.prevPage }">이전</a>
												</li>
												<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">									
												<li class="page-item">
													<a class="page-link ${pagination.page eq num ? 'active' : '' }"
																href="userCalendar?page=${num }">${num }</a>
												</li>
												</c:forEach>
													
												<li class="page-item">
													<a class="page-link ${pagination.last ? 'disabled' : '' }"
															href="userCalendar?page=${pagination.nextPage }">다음</a>
												</li>
											</ul>
										</nav>
								</c:if>
						</div>
						
					
					</div>
					
					<div class="col-6">
						<div id="calendar" ></div>
					</div>
				</div>
					
			</div>
		</div>
	</div>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"crossorigin="anonymous"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src='https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.1/index.global.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js" ></script>
<script src="https://momentjs.com/downloads/moment-with-locales.js" type="text/javascript"></script>
<script src="https://momentjs.com/downloads/moment.js"></script>
<script type="text/javascript">
$(function(){
	
	// FullCalendar의 Calender객체를 생성한다.
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
	
	
	// 검색
	$('#btn-search').click(function() {
		
		$("#form-search").attr("action","/emp/userCalendar").trigger("submit");
	});
	
	function refreshEvents(info, successCallback) {
		let startDate = moment(info.start).format("YYYY-MM-DD");
		let endDate = moment(info.end).format("YYYY-MM-DD");
		let param = {
			startDate: startDate,
			endDate: endDate
		};
		
		$.ajax({
			type: 'get',
			url: '/emp/events',
			data: param,
			dataType: 'json'
		})
		.done(function(events) {
			successCallback(events);
		})
	}
	
	
	
	
	// 이름을 클릭했을 때
	$('#user-att-table a[data-user-no]').click(function(event){

		event.preventDefault();
		let no = $(this).attr('data-user-no');
		
		$.getJSON('/emp/detail.json', {userNo: no}, function(userAtt) {
			
			
			$("#user-id").text(userAtt.userId);
			$("#user-name").text(userAtt.userName);
			$("#user-no").text(userAtt.userNo);
			$("#user-tel").text(userAtt.userTel);
			$("#user-email").text(userAtt.userEmail);
			$("#user-gender").text(userAtt.userGender);
			$("#user-attDate").text(userAtt.userAttDate);
			$("#user-classDate").text(userAtt.classAttDate);
			$("#emp-name").text(userAtt.userId);
			$("#prog-name").text(userAtt.programName);
			$("#user-membership").text(userAtt.membership);
			
		})
			
	});	
	
	
});

	
	
</script>
</body>
</html>