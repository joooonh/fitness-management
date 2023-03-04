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
						<p class="memberH" ><i class="bi bi-person-check-fill  ms-2 me-3"></i>회원출석관리</p>
						<hr width="100%" color="gray">
					</div>
				</div>
				
				<div class="row mb-3">
						<div class="col-12">
							<a class="btn btn-secondary" href="/emp/userAttList"> <i class="bi bi-list-columns-reverse"></i> 출석리스트 </a></button>
							<a class="btn btn-secondary" href="/emp/userDay"><i class="bi bi-calendar3"></i>일별출석리스트</a> 
							<a class="btn btn-secondary" href="/emp/userCalendar"><i class="bi bi-calendar-week"></i>출석달력</a>
						</div>
					</div>
				
				<div class="row mb-2">
					<%--<div class="col">
						<button type="button" id="select-all" class="btn btn-secondary btn-sm">전체선택</button>
						<button type="button" id="deselect" class="btn btn-secondary btn-sm">선택해제</button>
		
					</div>
					 --%>
					<div class="col-8">
						<form id="form-search" method="get" action="/emp/userAttList">
								<c:choose>
									<c:when test="${param.attDate eq null }">
										<input class="form-control form-control-sm d-inline-block border-secondary"	type="date" name ="attDate"  value="${param.attDate }" ${param.attDate eq '${param.attDate }' ? 'selected' : '' } style="width: 120px;">
									</c:when>
									<c:when test="${param.classAttDate eq null }">
										<input class="form-control form-control-sm d-inline-block border-secondary"	type="date" name ="classAttDate" value="${param.classAttDate }"  ${param.classAttDate eq '${param.classAttDate }' ? 'selected' : '' } style="width: 120px;">
									</c:when>
								</c:choose>
							
							<select class="form-select form-select-sm d-inline-block border-secondary"	name="onlyMembership" style="width: 130px;">
									<option value="" selected >= 선택 =</option>
									<option value="Y" ${param.onlyMembership == 'Y' ? 'selected' : '' }>회원권</option>
							</select> 
								<%-- <div class="form-check form-check-inline ms-2">
									<input class="form-check-input  border-dark" type="checkbox" name="onlyMembership" value=""${param.onlyMembership eq 'Y' ? 'checked' : '' } id="flexCheckDefault"> 
									<label class="form-check-label">회원권</label>
								</div>  --%>
							<select class="form-select form-select-sm d-inline-block border-secondary" name="programInfo" style="width: 225px;">
										
									<option value="" selected >= 프로그램 =</option>
									<c:forEach var="category" items="${FitnessProgramCategories }">
										<option value="${category.categoryNo}" ${param.programInfo eq '${category.categoryNo}' ? 'selected': '' }>${category.categoryName }</option>
									</c:forEach>
							</select>
									
							<select class="form-select form-select-sm d-inline-block border-secondary"	name="opt" style="width: 130px;">
									<option value="" selected 선택하세요>선택하세요</option>
									<option value="userName" ${param.opt eq 'userName' ? 'selected' : '' }>회원이름</option>
									<option value="userNo" ${param.opt  == 'userNo' ? 'selected' : ''} >회원번호</option>
									<option value="userTel" ${param.opt  == 'userTel' ? 'selected' : ''}>휴대폰</option>
							</select> 
									<input class="form-control form-control-sm d-inline-block border-secondary"	name="keyword" value="${param.keyword }" style="width: 150px;">
									<button type="submit" id="btn-search" class="btn btn-sm" style="background-color:#E0E0E0;"><i class="bi bi-search"></i></button>
						</form>
					</div>
					

					<div class="col text-end">
								<button type="button" id="btn-check-attendance"  class="btn btn-sm btn-outline-secondary"">회원출석<i class="bi bi-check2"></i></button>
								<button type="button" id="btn-check-class-attendance"  class="btn btn-sm btn-outline-secondary">프로그램출석<i class="bi bi-check2"></i></button>
								<!-- <button type="button" class="btn  btn-sm"  style="background-color:#E0E0E0;">수정</button> -->
								<button type="submit" id="btn-delete" class="btn btn-sm" style="background-color:#E0E0E0;">삭제</button>
					</div>
				</div>
				
				
				<div class="row mb-3">
					<div class="col-12">
						<form id="form-att" method="get" action="/emp/delete-userAtt">
								<table class="table table-hover">
									<colgroup>
										<col width="3%">
										<col width="8%">
										<col width="8%">
										<col width="6%">
										<col width="12%">
										<col width="15%">
										<col width="15%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead class="table-light">
										<tr>
											<th class="text-start"><input class="form-check-input ms-2 me-3" type="checkbox"  id="checkbox-all"></th>
											<th>회원번호</th>
											<th>회원이름</th>
											<th>성별</th>
											<th class="text-center">회원권</th>
											<th>프로그램명</th>
											<th>휴대폰</th>
											<th>이메일</th>
											<th>출석일자</th>
											<th>출입시간</th>
										</tr>
									</thead class="table-light">
									<tbody>
										<c:choose>
											<c:when test="${empty userAtts }">
												<tr>	
													<td colspan="11" class="text-center">출석이력이 없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach var="user" items="${userAtts }">
													<tr>
														<td class="text-start">
															<c:choose>
																<c:when test="${user.userSeq ne 0 }">
																	<input class="form-check-input ms-2 me-3"  type="checkbox"  name="value" value="${user.userSeq }-M" data-user-delete id="flexCheckDefault">
																</c:when>
																<c:when test="${user.classSeq ne 0 }">
																	<input class="form-check-input ms-2 me-3"  type="checkbox"  name="value" value="${user.classSeq }-P" data-user-delete id="flexCheckDefault">
																</c:when>
															</c:choose>
														</td>
														
														<td name="userNo" value="${user.userNo }">${user.userNo}</td>
														<td>${user.userName }</td>
														<td>${user.userGender }</td>
														<td class="text-center">${user.membership }</td>
														<td>${user.programName }</td>
														<td>${user.userTel }</td>
														<td>${user.userEmail }</td>
														<td name="attNo" >
															<c:choose>
																<c:when test="${user.userAttDate ne null }">
																		<fmt:formatDate pattern="yyyy-MM-dd" value="${user.userAttDate }"/>
																</c:when>
																<c:when test="${user.classAttDate ne null }">
																		<fmt:formatDate pattern="yyyy-MM-dd" value="${user.classAttDate }"/>
																</c:when>
															</c:choose>
														</td>
														<td>
															<c:choose>
																<c:when test="${user.startTime != null }">
																	${user.startTime }
																</c:when>
																<c:when test="${user.progStartTime != null }">
																	${user.progStartTime }
																</c:when>
															</c:choose>
														</td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
										
										
										
									</tbody>
								</table>
								
								<c:if test="${not empty	userAtts }">
									<nav class="pt-3">
										<ul class="pagination pagination-sm justify-content-center">
											<li class="page-item">
												<a class="page-link ${pagination.first ? 'disabled' : '' }"
													href="userAttList?page=${pagination.prevPage }">이전</a>
											</li>
											<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">									
												<li class="page-item">
													<a class="page-link ${pagination.page eq num ? 'active' : '' }"
														href="userAttList?page=${num }">${num }</a>
												</li>
											</c:forEach>
											
											<li class="page-item">
												<a class="page-link ${pagination.last ? 'disabled' : '' }"
													href="userAttList?page=${pagination.nextPage }">다음</a>
											</li>
										</ul>
									</nav>
								</c:if>
							</div>
						</div>
						
						<div class="row" id="personnel">
							<div class="col-12 " id="personnel" ">
								<p class="perssonnel-number pt-3">인원 ${totalRows }명</p>
							</div>
						</div>
				
					</form>
			</div>
		</div>
	</div>
	
 <!-------회원출석등록 모달창 ----------------------------------------------------------------------------------------- -->
  <div class="modal" tabindex="-1" id="modal-form-att">
  	<div class="modal-dialog">
  		<form id="att-check" class="border p-3 bg-light" method="post" action="/emp/userRegisterAtt">
  			<div class="modal-content">
  				<div class="modal-header">
  					<h5 class="modal-title">회원출석등록</h5>
  					<button  type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
  				</div>
				<div class="modal-body">
					<div class="row mb-2">
					
						<div class="row">
							<div class="mb-3">
								<label class="form-label ">회원번호</label>
								<select name="userNo" class="form-select d-inline">	
									<option>회원번호 선택</option>
									<c:forEach var="Membership" items="${Membership }">
										<option>${Membership.userNo }</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="row">
							<div class="mb-3">
								<label class="form-label" value="">휴대폰</label>
								<input type="text" id="user-tel" name="userTel" value="${userTel}" style="width: 150px;" >
							</div>
						</div>
						
						
						
						<div class="row">
							<div class="mb-3">
								<label class="form-label " >회원이름</label>
								<input type="text" id="user-name" name="userName" value="${userName }" style="width: 150px;" >
							</div>
						</div>
						
						<div class="row">
							<div class="mb-3">
								<label class="form-label " >회원권여부</label>
								<input type="text" id="membership-status" name="membership" value="${membership }" style="width: 150px;" >
							</div>
						</div>
					
					
						<div class="row">
							<div class=" mb-3">
								<label class="form-label" >입실시간</label>
								<input type="time"  name="startTime" >
							</div>
						</div>
						
						<div class="row">
							<div class="mb-3">
								<label class="form-label ">출석날짜</label>
								<input class="form-control " type="date" name="userAttDate" value="${userAttDate }">
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
  
<!-------프로그램출석등록 모달창 ----------------------------------------------------------------------------------------- -->
  <div class="modal" tabindex="-1" id="modal-form-class-att">
  	<div class="modal-dialog">
  		<form id="class-check" class="border p-3 bg-light" method="post" action="/emp/classAttRegister">
  			<div class="modal-content">
  				<div class="modal-header">
  					<h5 class="modal-title">프로그램 출석등록</h5>
  					<button  type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
  				</div>
				<div class="modal-body">
					<div class="row mb-2">
					
						<div class="row">
							<div class="mb-3">
								<label class="form-label ">회원번호</label>
								<select name="userNo" class="form-select d-inline">	
									<option>회원번호 선택</option>
									<c:forEach var="Class" items="${ClassRegistration }">
										<option>${Class.no }</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="row">
							<div class="mb-3">
								<label class="form-label" >휴대폰</label>
								<input type="text" id="class-tel" name="userTel" value="${userTel}" style="width: 150px;">
							</div>
						</div>
						
						
						
						<div class="row">
							<div class="mb-3">
								<label class="form-label " >회원이름</label>
								<input type="text" id="class-name" name="userName" value="${userName }" style="width: 150px;">
							</div>
						</div>
						
						<div class="row">
							<div class="mb-3">
								<input type="text" id="class-prog"  style="width: 225px;">
							</div>
						</div>
						
						<div class="row">
							<div class=" mb-3">
								<label class="form-label" >프로그램명</label>
								<select class="form-select" id="class-prog" name="programNo" value="${userClassAttRegiModyfy.programNo }">
									<option value="" selected >= 프로그램 =</option>
									<c:forEach var="category" items="${FitnessProgramCategories }">
											<option  value="${category.categoryNo}">${category.categoryName }</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						
						
						<div class="row">
							<div class="mb-3" id="prog-days">
								<p>프로그램요일</p>
							</div>
						</div>
						
						<div class="row">
							<div class="mb-3">
								<label class="form-label">출석날짜</label>
								<input class="form-control " type="date" name="classAttDate" value="${userClassAttRegiModyfy.classAttDate }">
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="" id="class-register">등록</button>
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

$(function(){
	
	// 현재날짜 표시
	/*     document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);; */
	
	// 날짜 표현
 	let day = moment().format("YYYY-MM-DD");
	
	$("#form-search :input[name=attDate]").val(day);
	$("#form-search :input[name=classAttDate]").val(day);

	// 회원출석 모달창
	let attendanceFormModal = new bootstrap.Modal("#modal-form-att");
	
	$('#btn-check-attendance').click(function(event) {
		let day = moment().format("YYYY-MM-DD");
		let hour = moment().format("HH:mm"); 
		
		$("#modal-form-att :input[name=startTime]").val(hour);
		$("#modal-form-att :input[name=userAttDate]").val(day);
		
		attendanceFormModal.show();
	});
	
	// 프로그램출석 모달창
	let classAttendanceFormModal = new bootstrap.Modal("#modal-form-class-att");
	
	$('#btn-check-class-attendance').click(function(event) {
		// moment.js라이브러리
		let day = moment().format("YYYY-MM-DD");
		
		// 출석날짜 화면에 출력
		$("#modal-form-class-att :input[name=classAttDate]").val(day);
		
		classAttendanceFormModal.show();
		
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
		$("#prog-days").text("");
		
		let obj = {
			Su:'일',
			Mo:'월',
			Tu:'화',
			We:'수',
			Hh:'목',
			Fr:'금',
			Sa:'토'
		}
		let today = obj[moment().format("dd")];
		
		let no = $(this).val();
		$.getJSON("/emp/ProgramDays",{programNo:no}, function(days) {
				
			let text = days.join("/")
			$("#prog-days").text(text);
			
			let prog = text.includes(today);
			
			if(!prog){
				alert("오늘은 해당수업을 운영하지 않습니다.");
			}
			
		});
		
	});
	
	
	// 회원출석 삭제
	$('#btn-delete').click(function() {
			
		let len = $("#form-att table tbody :checkbox[data-user-delete]:checked").length;
		if(len === 0){
			alert("삭제할 정보를 하나이상 선택하세요.");
			return;
		}
		
		$("#form-att").attr("action","/emp/delete-userAtt").trigger("submit");
	});
	
	
	
	// 회원출석 등록 alert
	$('#btn-register').click(function() {
		let userNo =  $("#att-check input[name=userNo]").val();
		let userTel =  $("#att-check input[name=userTel]").val();
		let userName =  $("#att-check input[name=userName]").val();
		let membership =  $("#att-check input[name=membership]").val();
		
		if(membership != "Y"){
			alert("회원권을 등록하세요")
			return false
		}
		
		if(userNo === ""){
			alert("회원번호를 입력하세요");
			return false;
		}
		if(userTel === ""){
			alert("회원번호를 입력하세요");
			return false;
		}
		if(userName === ""){
			alert("회원번호를 입력하세요");
			return false;
		}
		if(membership === ""){
			alert("회원번호를 입력하세요");
			return false;
		}
			
			return true;
	});
	
	$('#btn-check').click(function() {
		let userTel = $("#att-check input[name=userTel]").val();
		
		if(userTel === ""){
			alert("휴대폰번호를 입력하세요");
			
			return false;
		}
			return true;
	});
	
	
	
			
	// 프로그램출석 등록 alert
	$('#class-register').click(function() {
			
		let userNo = $("#class-check input[name=userNo]").val();
		
		if(userNo === ""){
			alert("회원번호를 입력하세요");
			return false;
		}
		
		return true;
	});
	
	$("#btn-class-check").click(function() {
		
		let userTel = $("#class-check input[name=userTel]").val();
		
		if(userTel === ""){
			alert("휴대폰번호를 입력하세요");
			return false;
		}
		return true;
	});
	
	// 회원 번호 입력했을 때, 상세 정보 나오기
	$(":input[name=userNo]").change(function() {
		const userNo = $(this).val();
		$.getJSON("/emp/userInfo", {userNo:userNo}, function(user){
			$("#user-tel").val(user.tel);
			$("#user-name").val(user.name);
			$("#membership-status").val(user.paymentStatus);
		})
	});
	
	// 프로그램 출석 모달창에 회원번호를 입력했을 때, 상세정보 나오기
	$(":input[name=userNo]").change(function() {
		const userNo = $(this).val();
		$.getJSON("/emp/ClassUserInfo", {userNo:userNo}, function(user) {
			$("#class-tel").val(user.userTel);
			$("#class-name").val(user.userName);
			$("#class-prog").val(user.programName);
		})
	})
	
});
	
</script>
</body>
</html>