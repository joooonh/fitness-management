<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="../resources/css/attendance-user-list.css">
<link rel="stylesheet" href="../resources/css/common.css">
<title>중앙피트니스</title>
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
						<p class="memberH" ><i class="bi bi-person-check-fill  ms-2 me-3"></i>강사출석관리</p>
						<hr width="100%" color="gray">
					</div>
				</div>
				
				<div class="row mb-3">
						<div class="col-12">
							<a class="btn btn-secondary" href="/emp/empAttList"> <i class="bi bi-list-columns-reverse"></i> 출석리스트 </a></button>
							<a class="btn btn-secondary" href="/emp/empAttCalendar"><i class="bi bi-calendar-week"></i>출석달력</a>
						</div>
					</div>
				
				<div class="row mb-2">
					<div class="col">
						<button type="button" id="select-all" class="btn btn-secondary btn-sm">전체선택</button>
						<button type="button" id="deselect" class="btn btn-secondary btn-sm">선택해제</button>
		
								
					</div>
					<div class="col-6">
						<form id="form-search" method="get" action="/emp/empAttList">

							<input class="form-control form-control-sm d-inline-block border-secondary"	type="date" name ="empDate"  ${param.progAttDate eq 'empDate' ? 'selected' : '' } style="width: 120px;">
							<select class="form-select form-select-sm d-inline-block border-secondary" name="programInfo" style="width: 130px;">
									<option value="" selected >= 프로그램 =</option>
									<c:forEach var="program" items="${programs }">
										<option value="${program.no}" ${param.programInfo eq '${program.no}' ? 'selected': '' }>${program.name }</option>
									</c:forEach>
							</select>
									
							<select class="form-select form-select-sm d-inline-block border-secondary"	name="opt" style="width: 130px;">
									<option value="" selected 선택하세요>= 선택하세요 =</option>
									<option value="empName" ${param.opt eq 'empName' ? 'selected' : '' }>이름</option>
									<option value="id" ${param.opt  == 'id' ? 'selected' : ''} >아이디</option>
									<option value="tel" ${param.opt  == 'tel' ? 'selected' : ''}>휴대폰</option>
							</select> 
									<input class="form-control form-control-sm d-inline-block border-secondary"	name="keyword" value="${param.keyword }" style="width: 150px;">
									<button type="submit" id="btn-emp-search" class="btn btn-sm" style="background-color:#E0E0E0;"><i class="bi bi-search"></i></button>
						</form>
					</div>
					

					<div class="col text-end">
								<button type="button" id="btn-check-attendance"  class="btn btn-sm btn-outline-secondary"">출석<i class="bi bi-check2"></i></button>
								<button type="button" class="btn  btn-sm"  style="background-color:#E0E0E0;">수정</button>
								<button type="submit" id="btn-delete" class="btn btn-sm" style="background-color:#E0E0E0;">삭제</button>
					</div>
				</div>
				
				
				<div class="row mb-3">
					<div class="col-12">
						<form id="form-att" method="get" action="/emp/empAttList">
								<table class="table table-hover">
									<colgroup>
										<col width="5%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
									</colgroup>
									<thead class="table-light">
										<tr>
											<th class="text-start"><input class="form-check-input ms-2 me-3" type="checkbox"  id="checkbox-all"></th>
											<th>강사이름</th>
											<th>아이디</th>
											<th class="text-start">프로그램</th>
											<th class="text-start">휴대폰</th>
											<th>이메일</th>
											<th>출석일자</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${empty empAtts }">
												<tr>	
													<td colspan="11" class="text-center">출석이력이 없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach var="emp" items="${empAtts }">
													<tr>
														<td class="text-start">
															<input class="form-check-input ms-2 me-3"  type="checkbox"  name="value" value="" data-user-delete id="flexCheckDefault">
														</td>
														<td name="name" value="${emp.name }">${emp.name}</td>
														<td name="id" value="${emp.id }">${emp.id}</td>
														<td class="text-start">${emp.progName }</td>
														<td class="text-start">${emp.tel }</td>
														<td>${emp.email }</td>
														<td>
															<fmt:formatDate pattern="yyyy-MM-dd" value="${emp.progAttDate }"/>
														</td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
								
								<c:if test="${not empty empAtts }">
									<nav class="pt-3">
										<ul class="pagination pagination-sm justify-content-center">
											<li class="page-item">
												<a class="page-link ${pagination.first ? 'disabled' : '' }"
													href="empAttList?page=${pagination.prevPage }">이전</a>
											</li>
											<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">									
												<li class="page-item">
													<a class="page-link ${pagination.page eq num ? 'active' : '' }"
														href="empAttList?page=${num }">${num }</a>
												</li>
											</c:forEach>
											
											<li class="page-item">
												<a class="page-link ${pagination.last ? 'disabled' : '' }"
													href="empAttList?page=${pagination.nextPage }">다음</a>
											</li>
										</ul>
									</nav>
								</c:if>
							</div>
						</div>
						
						<div class="row" id="personnel">
							<div class="col-12 " id="personnel" ">
								<p class="perssonnel-number pt-3">인원 00명</p>
							</div>
						</div>
				
					</form>
			</div>
		</div>
	</div>
	
 <!-------출석등록 모달창 ----------------------------------------------------------------------------------------- -->
  <div class="modal" tabindex="-1" id="modal-form-att">
  	<div class="modal-dialog">
  		<form id="att-check" class="border p-3 bg-light" method="post" action="/emp/empAttRegister">
  			<div class="modal-content">
  				<div class="modal-header">
  					<h5 class="modal-title">출석등록</h5>
  					<button  type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
  				</div>
				<div class="modal-body">
					<div class="row">
						<div class="mb-3">
							<select name="empId" class="form-select d-inline">
								<option selected >= 아이디 =</option>
								<c:forEach var="emp" items="${EmpId }">
										<option>${emp.id }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					
					<div class="row mb-2">
						<div class="row">
							<div class="mb-3">
								<label class="form-label" value="">이름</label>
								<input type="text" id="emp-name" name="name" value="${name }" style="width: 150px;" disabled="disabled"> 
							</div>
						</div>
						
						<div class="row">
							<div class="mb-3">
								<label class="form-label " >휴대폰</label>
								<input type="text" id="emp-tel" name="tel" value="${tel }" style="width: 150px;" disabled="disabled">
							</div>
						</div>
					
						<div class="row">
							<div class=" mb-3">
								<label class="form-label" >프로그램명</label>
								<input type="text" id="prog-name" value="${progName }" style="width: 220px;" disabled="disabled">
								<%-- <select class="form-select"  name="progName" >
									<option value="" selected >= 프로그램 =</option>
									<c:forEach var="program" items="${programs }">
											<option value="${program.no}">${program.name }</option>
									</c:forEach>
								</select> --%>
							</div>
						</div>
						<div class="row">
							<div class="mb-3" id="prog-days">
								<p>프로그램요일</p>
							</div>
						</div>
						
						<div class="row">
							<div class=" mb-3">
								<label class="form-label" >출입시간</label>
								<input type="time"  name="startTime">
							</div>
						</div>
						
						<div class="row">
							<div class="mb-3">
								<label class="form-label ">출석날짜</label>
								<input class="form-control " type="date" name="progAttDate" >
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="" id="btn-register">등록</button>
					<%--<a href="user-list?userNo=">취소</a> --%>
				</div>
  			</div>
  		</form>
  	</div>
  </div>	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js" ></script>
<script src="https://momentjs.com/downloads/moment-with-locales.js" type="text/javascript"></script>
<script src="https://momentjs.com/downloads/moment.js"></script>
<script type="text/javascript">
	moment.locale('ko');
$(function(){
	
	
	// 날짜 표현
	let day = moment().format("YYYY-MM-DD");
	
	$("#form-search :input[name=empDate]").val(day);
	
	// 회원출석 모달창
	let attendanceFormModal = new bootstrap.Modal("#modal-form-att");
	
	$('#btn-check-attendance').click(function(event) {
		// moment.js라이브러리
		let day = moment().format("YYYY-MM-DD");
		let hour = moment().format("HH:mm"); 
		
		// 출석날짜 화면에 출력
		$("#modal-form-att :input[name=startTime]").val(hour);
		$("#modal-form-att :input[name=progAttDate]").val(day);
		
		attendanceFormModal.show();
	});
	
	
	// 검색
	$('#btn-search').click(function() {
		
		$("#form-search").attr("action","/emp/userAttList").trigger("submit");
	});
	
	
	
	// 체크박스 전체 선택
	$("#checkbox-all").change(function(){
		
		//전체 체크박스 여부 조회
		let checkboxAllChecked = $(this).prop("checked");
		// 각 게시물의 체크박스 여부를 전체선택 체크박스의 체크여부와 같은 상태로 변경한다.
		$(":checkbox[name=value]").prop('checked',checkboxAllChecked);
		
		
	});
	
	
	
	// userNo가 바뀔 때 마다 무언가가 실행되게 하기
	$(":checkbox[name=value]").change(function(){
		
		toggleCheckboxAll();
	});
	
	
	function toggleCheckboxAll() {
		
			// 게시글 체크박스 갯수 조회
			let checkboxLength = $(":checkbox[name=value]").length;
			// 게시글 체크박스 중에서 체크된 갯수 조회
			let checkedCheckboxLength = $(":checkbox[name=value]:checked").length;
			// 게시글 체크박스의 갯수와 체크된 갯수가일치하면 전체선택 체크박스상태로 변경
			$("#checkbox-all").prop("checked", checkboxLength == checkedCheckboxLength);
	};
	
	// 선택해제 버튼을 클릭했을 때 해당 체크박스 해제하기
	$('#deselect').click(function(event){
		
		$("#checkbox-all").prop('checked',false);
		$(":checkbox[name=value]").prop('checked',false);
	});

	// 전체선택 버튼을 클릭했을 때 모든 체크박스가 선택되게하기 
	$("#select-all").click(function(){
		$("#checkbox-all").prop('checked',true);
		$(":checkbox[name=value]").prop('checked',true);
		
	});
	
	// 프로그램 요일
	$(":input[name=programNo]").change(function() {
		
		let today = moment().format("dd");
		
		let no = $(this).val();
		$.getJSON("/emp/ProgramDays",{programNo:no}, function(days) {
				
			let text = days.join("/")
			$("#prog-days").text(text);
			
			//$("#prog-days").text().includes('일')
			
		});
		
	});
	
	
	// 회원출석 삭제
	$('#btn-delete').click(function() {
			
		let len = $("#form-att table tbody :checkbox[data-user-delete]:checked").length;
		if(len == 0){
			alert("삭제할 정보를 하나이상 선택하세요.");
			return;
		}
		
		$("#form-att").attr("action","/emp/delete-userAtt").trigger("submit");
	});
	
	// 회원등록 alert
	$('#att-check').submit(function() {
		let userNo =  $("#att-check input[name=userNo]").val();
		
		if(userNo == ""){
			alert("회원번호를 입력하세요");
			return false;
		}
		
		return true;
	});
	
	// 출석등록 alert
	$('#class-check').submit(function() {
			
		let userNo = $("#class-check input[name=userNo]").val();
		
		if(userNo == ""){
			alert("회원번호를 입력하세요");
			return false;
		}
		
		return true;
	});
	
	// 모달창에 이름을 선택했을 때 나타내기
	$(":input[name=empId]").change(function() {
		const empId = $(this).val();
		$.getJSON("/emp/EmployeeInfo", {empId:empId}, function(emp) {
			$("#emp-name").val(emp.name);
			$("#emp-tel").val(emp.tel);
			$("#prog-name").val(emp.progName);
		})
	})
	
});
	
</script>
</body>
</html>