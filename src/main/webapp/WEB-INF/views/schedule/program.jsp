<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<link rel="stylesheet" href="../../resources/css/common.css">
<style>
	#title {
	border-bottom: solid 3px grey;
	}
	input {
	background-color: #dc143c;
	color: white;
	border: 0;
	}
	#title a {
  	text-decoration: none; /* 링크의 밑줄 제거 */
  	color: inherit; /* 링크의 색상 제거 */
	}
</style>
<title>중앙피트니스</title>
</head>
<body>
<c:set var="menu" value="programschedule"/>
<!------------------------------------ 헤더 navbar 영역 ---------------------------------------->
<%@ include file="../common/header.jsp" %>
<div class="container-fluid mt-4">
	<div class="row">
		<div class="col-md-2 sidebar">
			<!---------------------------------- 사이드 바 영역  ----------------------------------------->
			<%@ include file="../common/sidebar.jsp" %>
		</div> 
		<div class="col-md-10 ps-4 pt-5">
			<!--------------------------------- Content 영역 ------------------------------------------->
	   	   	<div id="title">
					<p class="fs-2"><i class="bi bi-calendar3"></i><a href="program"> 프로그램일정관리</a></p>
			</div>
				<p>
			<div>
		        <form id="form-search" method="get" action="program">
			        <select name="progNo">
		        		<option selected disabled>프로그램명</option>
		        		<c:forEach var="program" items="${programs }">
		               		<option value="${program.no }">${program.name }</option>
		        		</c:forEach>
			        </select>
		       	  <button type="button" class="btn btn-danger btn-sm" id="btn-search">검색</button>
		    	</form>
			</div>
			<p>
			<!-- calendar API 추가 -->
			 <!-- calendar 태그 -->
  			<div id='calendar-container'>
    			<div id='calendar'></div>
  			</div>
  			</p>
	 
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<script type="text/javascript" src="https://momentjs.com/downloads/moment.min.js"></script>
<script type="text/javascript">
$(function(){
    // calendar element 취득
    var calendarEl = $('#calendar')[0];
    // full-calendar 생성하기
    var calendar = new FullCalendar.Calendar(calendarEl, {
      height: '700px', // calendar 높이 설정
      expandRows: true, // 화면에 맞게 높이 재설정
      slotMinTime: '00:00', // Day 캘린더에서 시작 시간
      slotMaxTime: '24:00', // Day 캘린더에서 종료 시간
      // 해더에 표시할 툴바
      headerToolbar: {
        left:'prev next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
      },
      initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
      navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
      //editable: true, // 수정 가능?
      //selectable: true, // 달력 일자 드래그 설정가능
      nowIndicator: true, // 현재 시간 마크
      dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
      locale: 'ko', // 한국어 설정
      events: function(info, successCallback, failureCallback) {
    	  let startDate = info.startStr;
    	  let endDate = info.endStr;
    	  
    	  let param = {
    			 startDate: startDate,
    			 endDate: endDate
    	  };
    	  $.ajax({
    		  type:'get',
    		  url: "programs",
    		  data: param,
    		  dataType: 'json',
    		  success: function(events) {
    			  successCallback(events);
    		  }
    	  })
      }
    });
    // 캘린더 랜더링
    calendar.render();
    
  	$("#btn-search").click(function(){
  		let progNo = $("select[name=progNo]").val();
  		
  		let startDate = moment(calendar.view.currentStart).format("YYYY-MM-DD")
  		let endDate = moment(calendar.view.currentEnd).format("YYYY-MM-DD")
  		 let param = {
    			 startDate: startDate,
    			 endDate: endDate,
    			 progNo: progNo
    	  };
  		
  		 $.ajax({
   		  type:'get',
   		  url: "programs",
   		  data: param,
   		  dataType: 'json',
   		  success: function(events) {
   			  calendar.addEventSource(events);
   		  }
   	  })
  	})
    
  });
</script>
</body>
</html>