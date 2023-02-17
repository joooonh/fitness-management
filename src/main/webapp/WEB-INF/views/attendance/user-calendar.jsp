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
					<div class="col-12">
						<a class="btn btn-secondary" href="/emp/userAttList"> <i class="bi bi-list-columns-reverse"></i> 출석리스트 </a></button>
						<a class="btn btn-secondary" href="/emp/userDay"><i class="bi bi-calendar3"></i>일별출석리스트</a> 
						<a class="btn btn-secondary" href="/emp/userCalendar"><i class="bi bi-calendar-week"></i>출석달력</a>
					</div>
				</div>
				<div class="row">
					<div class="col-12 mb-2 text-end">

						<input class="form-control form-control-sm d-inline-block border-secondary" type="date" value="today" style="width: 120px;">
						

						<input class="form-control form-control-sm d-inline-block border-secondary" type="date" value="today" style="width: 120px;"> 
						<input class="form-control form-control-sm d-inline-block border-secondary"	name="keyword" style="width: 150px;">
						<button type="button" class="btn btn-sm" style="background-color: #E0E0E0;"> <i class="bi bi-search"></i>
						</button>


						<select class="form-select form-select-sm d-inline-block border-secondary"	name="프로그램" style="width: 130px;">
							<option value="">프로그램명</option>
							<option value="">크로스핏</option>
							<option value="">요가</option>
							<option value="">스피닝</option>
							<option value="">줌바</option>

						</select> 
						
						<select class="form-select form-select-sm d-inline-block border-secondary"	name="opt" style="width: 130px;">
								<option value="none" selected disabled>선택하세요</option>
								<option value="userName" ${param.opt eq 'userName' ? 'selected' : '' }>회원이름</option>
								<option value="userNo" ${param.opt  == 'userNo' ? 'selected' : ''} >회원번호</option>
								<option value="userTel" ${param.opt  == 'userTel' ? 'selected' : ''}>휴대폰</option>
						</select> 
						
						<input class="form-control form-control-sm d-inline-block border-secondary"	name="keyword" style="width: 150px;">
						<button type="button" class="btn btn-sm" style="background-color: #E0E0E0;"> <i class="bi bi-search"></i>
						</button>

						</select>

					</div>
				</div>
				<div class="row ">
					<div class="col-12">
						<table class="table table-bordered">
							<colgroup>
								<col width="20%">
								<col width="20%">
								<col width="20%">
								<col width="20%">
								<col width="20%">
							</colgroup>
							<thead>
								<tr class="table-dark">
									<th class="text-start"><input class="form-check-input ms-2 me-3" type="checkbox" value="행체크"><span>회원번호</span></th>
									<th>회원이름</th>
									<th>성별</th>
									<th>회원권(헬스)</th>
									<th>프로그램명</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-start"><input class="form-check-input ms-2 me-3" type="checkbox" value="행체크" id="flexCheckDefault"><span>23010100001</span></td>
									<td>강감찬</td>
									<td>남</td>
									<td>헬스</td>
									<td>크로스핏</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="row mt-3">
					<div class="col-6">
						<h3 class="bg-dark text-white p-2 fs-6 fw-bold">회원상세정보</h3>
						<table class="table table-bordered ">
							<colgroup>
								<col width="40%">
								<col width="20%">
								<col width="40%">
							</colgroup>
							<tbody>
								<tr>
									<td rowspan="8" >
										
									</td>
									<td bgcolor="#FF0000">회원이름</td>
									<td>강감찬</td>
								</tr>
								<tr>
									<td>회원번호</td>
									<td>23010100001</td>
								</tr>
								<tr>
									<td>휴대폰</td>
									<td>010-1111-1111</td>
								</tr>
								<tr>
									<td>이메일</td>
									<td>kang@gmail.com</td>
								</tr>
								<tr>
									<td>성별</td>
									<td>남</td>
								</tr>
								<tr>
									<td>등록일자</td>
									<td>2023-01-01</td>
								</tr>
								<tr>
									<td>강사이름</td>
									<td>김유신</td>
								</tr>
								<tr>
									<td>프로그램명</td>
									<td>요가</td>
									
								</tr>
							</tbody>
						</table>
					</div>
					<div class="col-6">
						<div id='calendar' class="col-12" style="width: 600px; height: 50px;"></div>
					</div>
				</div>
				<div class="row" id="personnel">
					<div class="col-12 " id="personnel">
						<p class="perssonnel-number pt-3">인원 00명</p>
					</div>
				</div>
			</div>
		</div>
	</div>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"crossorigin="anonymous"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src='https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.1/index.global.min.js'></script>
<script type="text/javascript">

document.addEventListener('DOMContentLoaded', function() {
	
	
	  var calendarEl = document.getElementById('calendar');

	  var calendar = new FullCalendar.Calendar(calendarEl, {
	    timeZone: 'UTC',
	    initialView: 'dayGridMonth',
	    events: 'https://fullcalendar.io/api/demo-feeds/events.json',
	    editable: true,
	    selectable: true
	  });

	  calendar.render();
	});
</script>
</body>
</html>