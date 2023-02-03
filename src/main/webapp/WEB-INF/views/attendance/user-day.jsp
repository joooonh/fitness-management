<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<style type="text/css">
	#personnel {
		background-color: #353535
	}
	
	.perssonnel-number{
		color: white;
		top: 2px;
		
	}
</style>
<title>애플리케이션</title>
</head>
<body>
<div class="container">
   <div class="row mb-4 pt-4">
   		<div class="col-12">
   			<a class="btn btn-secondary" href="list"><i class="bi bi-list-columns-reverse"></i> 출석리스트</a></button>
   			<a class="btn btn-secondary" href="day"><i class="bi bi-calendar3"></i>일별출석리스트</a>
   			<a class="btn btn-secondary" href="calendar"><i class="bi bi-calendar-week"></i>출석달력</a>
   		</div>
   </div>
   
   <div class="row mb-2">
  	    <div class="col">
   			<button type="button" class="btn btn-secondary btn-sm">선택해제</button>
   			<input class="form-control form-control-sm d-inline-block border-secondary" type="date" value="2023-02-03" style="width: 120px;">
   			<div class="form-check form-check-inline ms-2">
	   			<input class="form-check-input  border-dark" type="checkbox" value="행체크" id="flexCheckDefault">
	   			<label class="form-check-label">회원권</label>
	   		</div>
   		</div>
   		<div class="col-6">
   			<select class="form-select form-select-sm d-inline-block border-secondary" name="프로그램"   style="width:130px;">
   				<option value="">프로그램명</option>
   				<option value="">크로스핏</option>
   				<option value="">요가</option>
   				<option value="">스피닝</option>
   				<option value="">줌바</option>
   			</select>
   			
   			<select class="form-select form-select-sm d-inline-block border-secondary" name=""  style="width:130px;">
   				<option value="">선택하세요</option>
   				<option value="">회원이름</option>
   				<option value="">프로그램명</option>
   				<option value="">회원번호</option>
   				<option value="">휴대폰</option>
   			</select>
   			<input class="form-control form-control-sm d-inline-block border-secondary" name="keyword" style="width:150px;">
   			<button type="button" class="btn btn-success btn-sm">검색</button>
   		</div>
   		<div class="col text-end">
   			<button type="button" class="btn btn-success btn-sm">출석체크</button>
			<button type="button" class="btn btn-warning btn-sm">수정</button>
			<button type="button" class="btn btn-danger btn-sm">삭제</button>		
   		</div>
   </div>
   
   <div class="row mb-2">
   			<div id='calendar' class="col-12">
   			</div>-
   </div>
   
   <div class= "row" id="personnel">
   		<div class="col-12 " id="personnel">
   			<p class="perssonnel-number">인원 00명</p>
   		</div>
   </div>
   
   <div class="row mb-2">
   </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.1/index.global.min.js'></script>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
    	  var calendarEl = document.getElementById('calendar');

    	  var calendar = new FullCalendar.Calendar(calendarEl, {
    	    timeZone: 'UTC',
    	    initialView: 'resourceTimelineDay',
    	    aspectRatio: 1.5,
    	    headerToolbar: {
    	      left: 'prev,next',
    	      center: 'title',
    	      right: 'resourceTimelineDay,resourceTimelineWeek,resourceTimelineMonth'
    	    },
    	    editable: true,
    	    resourceAreaHeaderContent: 'Rooms',
    	    resources: 'https://fullcalendar.io/api/demo-feeds/resources.json?with-nesting&with-colors',
    	    events: 'https://fullcalendar.io/api/demo-feeds/events.json?single-day&for-resource-timeline'
    	  });

    	  calendar.render();
    	});
    </script>
</body>
</html>