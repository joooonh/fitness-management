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
   	   <div class= "row mb-4 pt-4">
   		<div class="col-12">
   			<a class="btn btn-secondary" href="list"><i class="bi bi-list-columns-reverse"></i> 출석리스트</a></button>
   			<a class="btn btn-secondary" href="day"><i class="bi bi-calendar3"></i>일별출석리스트</a>
   			<a class="btn btn-secondary" href="calendar"><i class="bi bi-calendar-week"></i>출석달력</a>
   		</div>
       </div>
   		<div class="row">
   			<div class="col-12 mb-2 text-end">
   				<input class="form-control form-control-sm d-inline-block border-secondary" name="keyword" style="width:150px;">
   				<button type="button" class="btn btn-success btn-sm">검색</button>
   				
   				<select  class="form-select form-select-sm d-inline-block border-secondary" name="프로그램" style="width:130px;">
	   				<option value="">프로그램명</option>
	   				<option value="">크로스핏</option>
	   				<option value="">요가</option>
	   				<option value="">스피닝</option>
	   				<option value="">줌바</option>
   				</select>
   			</div>
   		</div>
   		<div class="row mb-4">
   			<div class="col-3">
   				사진
   			</div>
   			<div  class="col-9">
   				<table class="table table-bordered border-2"> 
   					<colgroup>
	   					<col width="15%">
	   					<col width="15%">
	   					<col width="15%">
	   					<col width="15%">
	   					<col width="15%">
	   					<col width="18%">
   					</colgroup>
   					
   					<thead>
   					
   					</thead>
   					
   					<tbody>
   						<tr>
   							<td>회원이름</td>
   							<td>강감찬</td>
   							<td>회원번호</td>
   							<td>23010100001</td>
   							<td>휴대폰</td>
   							<td>010-1111-1111</td>
   						</tr>
   						<tr>
							<td>프로그램명</td>   						
							<td>요가</td>   						
							<td>성별</td>   						
							<td>남</td>   						
							<td>등록일자</td>   						
							<td>2023-01-01</td>   						
   						</tr>
   						<tr>
							<td>강사이름</td>   						
							<td>김유신</td>   						
							<td>이메일</td>   						
							<td>kang@gmail.com</td>   						
							<td></td>   						
							<td></td>   						
   						</tr>
   					</tbody>
   				</table>
   			</div>
   		</div>
   		<div class="row ">
   			<div id='calendar' class="col-12">
   			
   			</div>
   		</div>
   		<div class= "row" id="personnel">
   			<div class="col-12 " id="personnel">
   				<p class="perssonnel-number">인원 00명</p>
   			</div>
  	    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.1/index.global.min.js'></script>
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