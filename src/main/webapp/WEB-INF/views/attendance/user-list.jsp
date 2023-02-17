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
<link rel="stylesheet" href="resources/css/attendance-user-list.css">
<link rel="stylesheet" href="resources/css/common.css">
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
						<a class="btn btn-secondary" href="userList"> <i class="bi bi-list-columns-reverse"></i> 출석리스트 </a></button>
						<a class="btn btn-secondary" href="userDay"><i class="bi bi-calendar3"></i>일별출석리스트</a> 
						<a class="btn btn-secondary" href="userCalendar"><i class="bi bi-calendar-week"></i>출석달력</a>
					</div>
				</div>

				
				<div class="row mb-2">
					<div class="col">
						<button type="button" id="select-all" class="btn btn-secondary btn-sm">전체선택</button>
						<button type="button" id="deselect" class="btn btn-secondary btn-sm">선택해제</button>
		
						<input class="form-control form-control-sm d-inline-block border-secondary"	type="date" name ="attDate" value="" style="width: 120px;">
								
						<div class="form-check form-check-inline ms-2">
							<input class="form-check-input  border-dark" type="checkbox" name="membership" value="행체크" id="flexCheckDefault"> 
							<label class="form-check-label">회원권</label>
						</div>
					</div>
					<div class="col-5">
						<form action="userList" method="get">
							<select class="form-select form-select-sm d-inline-block border-secondary" name="programInfo" style="width: 130px;">
										
								<option value="none" selected disabled>= 프로그램 =</option>
									<c:forEach var="category" items="${FitnessProgramCategories }">
										<option value="${category.categoryNo}" ${param.programInfo eq '${category.categoryNo}' ? 'selected': '' }>${category.categoryName }</option>
									</c:forEach>
							</select>
									
							<select class="form-select form-select-sm d-inline-block border-secondary"	name="opt" style="width: 130px;">
									<option value="none" selected disabled>선택하세요</option>
									<option value="userName" ${param.opt eq 'userName' ? 'selected' : '' }>회원이름</option>
									<option value="userNo" ${param.opt  == 'userNo' ? 'selected' : ''} >회원번호</option>
									<option value="userTel" ${param.opt  == 'userTel' ? 'selected' : ''}>휴대폰</option>
							</select> 
									<input class="form-control form-control-sm d-inline-block border-secondary"	name="keyword" value="${param.keyword }" style="width: 150px;">
									<button type="submit" class="btn btn-sm" style="background-color:#E0E0E0;"><i class="bi bi-search"></i></button>
						</form>
					</div>
					

					<div class="col text-end">
								<button type="button" id="btn-check-attendance"  class="btn btn-outline-secondary"">회원출석<i class="bi bi-check2"></i></button>
								<button type="button" id="btn-check-class-attendance"  class="btn btn-outline-secondary">프로그램출석<i class="bi bi-check2"></i></button>
								<button type="button" class="btn  btn-sm"  style="background-color:#E0E0E0;">수정</button>
								<button type="button" class="btn  btn-sm" style="background-color:#E0E0E0;">삭제</button>
					</div>
				</div>
				
				


				<div class="row mb-2">
					<div class="col">
						<button type="button" class="btn btn-secondary btn-sm">선택해제</button>

						<input class="form-control form-control-sm d-inline-block border-secondary"	type="date" value="" style="width: 120px;">
						<div class="form-check form-check-inline ms-2">
							<input class="form-check-input  border-dark" type="checkbox" value="행체크" id="flexCheckDefault"> 
							<label class="form-check-label">회원권</label>
						</div>
					</div>
					<div class="col-6">
						<select class="form-select form-select-sm d-inline-block border-secondary" name="프로그램" style="width: 130px;">
							
							<option value="none" selected disabled>= 프로그램 =</option>
							<c:forEach var="category" items="${FitnessProgramCategories }">
									<option value="${category.categoryNo}">${category.categoryName }</option>
							</c:forEach>
						
							 
						</select>
						 <select class="form-select form-select-sm d-inline-block border-secondary"	name="" style="width: 130px;">
							<option value="none" selected disabled>선택하세요</option>
							<option value="">회원이름</option>
							<option value="">프로그램명</option>
							<option value="">회원번호</option>
							<option value="">휴대폰</option>
						</select> 
						<input class="form-control form-control-sm d-inline-block border-secondary"	name="keyword" style="width: 150px;">
						<button type="button" class="btn btn-sm" style="background-color:#E0E0E0;"><i class="bi bi-search"></i></button>
					</div>
					<div class="col text-end">
						<button type="button" class="btn btn-sm" style="background-color:#E0E0E0; ">출석체크</button>
						<button type="button" class="btn  btn-sm"  style="background-color:#E0E0E0;">수정</button>
						<button type="button" class="btn  btn-sm" style="background-color:#E0E0E0;">삭제</button>
					</div>
				</div>




				<div class="row mb-3">
					<div class="col-12">
						<table>
							<colgroup>
								<col width="15%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
								<col width="15%">
								<col width="13%">
								<col width="13%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>

									<th class="text-start"><input class="form-check-input ms-2 me-3" type="checkbox" value="행체크" id="checkbox-all"><span>회원번호</span></th>

									<th class="text-start"><input class="form-check-input ms-2 me-3" type="checkbox" value="행체크"><span>회원번호</span></th>

									<th>회원이름</th>
									<th>성별</th>
									<th>회원권(헬스)</th>
									<th>프로그램명</th>
									<th>휴대폰</th>
									<th>이메일</th>

									<th>회원출석일자</th>

									<th>등록일자</th>

									<th>수업출석일자</th>
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

												<td class="text-start"><input class="form-check-input ms-2 me-3" type="checkbox" name="userNo" value="행체크" id="flexCheckDefault"><span>${user.userNo }</span></td>
												<td>${user.userName }</td>
												<td>${user.userGender }</td>
												<td>${user.membership }</td>
												<td>${user.programName }</td>
												<td>${user.userTel }</td>
												<td>${user.userEmail }</td>
												<td><fmt:formatDate pattern="yyyy-MM-dd" value="${user.userAttDate }"/></td>
												<td><fmt:formatDate pattern="yyyy-MM-dd" value="${user.classAttDate }"/></td>

												<td class="text-start"><input class="form-check-input ms-2 me-3" type="checkbox" value="행체크" id="flexCheckDefault"><span>${user.userNo }</span></td>
												<td>${user.userName }</td>
												<td>${user.userGender }</td>
												<td></td>
												<td>${user.programName }</td>
												<td>${user.userTel }</td>
												<td>${user.userEmail }</td>
												<td><fmt:formatDate value="${user.createdDate }"/></td>
												<td><fmt:formatDate value="${user.classAttDate }"/></td>

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
											href="list?page=${pagination.prevPage }">이전</a>
									</li>
									<c:forEach var="num" begin="${pagination.beginPage }" end="${pagintion.endPage }">									
										<li class="page-item">
											<a class="page-link ${pagination.page eq num ? 'active' : '' }"
												href="list?page=${num }">${num }</a>
										</li>
									</c:forEach>
									
									<li class="page-item">
										<a class="page-link ${pagination.last ? 'disabled' : '' }"
											href="list?page=${pagination.nextPage }">다음</a>
									</li>
								</ul>
							</nav>
						</c:if>
					</div>
				</div>
				

						<nav class="pt-3">
							<ul class="pagination pagination-sm justify-content-center">
								<li class="page-item"><a class="page-link">이전</a></li>
								<li class="page-item"><a class="page-link">1</a></li>
								<li class="page-item"><a class="page-link">다음</a></li>
							</ul>
						</nav>
					</div>
				</div>


				<div class="row" id="personnel">
					<div class="col-12 " id="personnel" ">
						<p class="perssonnel-number pt-3">인원 00명</p>
					</div>
				</div>

				
				
			</div>
		</div>
	</div>
	
 <!-------회원출석등록 모달창 ----------------------------------------------------------------------------------------- -->
  <div class="modal" tabindex="-1" id="modal-form-att">
  	<div class="modal-dialog">
  		<form id="att-check" class="border p-3 bg-light" method="post" action="userAttRegister">
  			<div class="modal-content">
  				<div class="modal-header">
  					<h5 class="modal-title">회원출석등록</h5>
  					<button  type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
  				</div>
				<div class="modal-body">
					<div class="row mb-2">
						<div class="row">
							<div class="mb-3">
								<label class="form-label" value="">휴대폰</label>
								<input type="text"  name="userTel" value="${userTel}" style="width: 150px;">
								<button type="submit" class="">조회</button>
							</div>
						</div>
						
						<div class="row">
							<div class="mb-3">
								<label class="form-label ">회원번호</label>
								<input type="text"  name="userNo" value="${userNo }" style="width: 150px;">
							</div>
						</div>
						
						<div class="row">
							<div class="mb-3">
								<label class="form-label " >회원이름</label>
								<input type="text"  name="userName" value="${userName }" style="width: 150px;">
							</div>
						</div>
					
					
						<div class="row">
							<div class=" mb-3">
								<label class="form-label" >입실시간</label>
								<input type="text"  name="startTime">
							</div>
						</div>
						
						<div class="row">
							<div class="mb-3">
								<label class="form-label ">출석날짜</label>
								<input class="form-control " type="date" name="userAttDate" >
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="">등록</button>
					<a href="user-list?userNo=">취소</a>
				</div>
  			</div>
  		</form>
  	</div>
  </div>	
  
<!-------프로그램출석등록 모달창 ----------------------------------------------------------------------------------------- -->
  <div class="modal" tabindex="-1" id="modal-form-class-att">
  	<div class="modal-dialog">
  		<form id="att-check" class="border p-3 bg-light" method="post" action="classAttRegister">
  			<div class="modal-content">
  				<div class="modal-header">
  					<h5 class="modal-title">프로그램 출석등록</h5>
  					<button  type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
  				</div>
				<div class="modal-body">
					<div class="row mb-2">
						<div class="row">
							<div class="mb-3">
								<label class="form-label" >휴대폰</label>
								<input type="text"  name="userTel" value="${userTel}" style="width: 150px;">
								<button type="submit" class="">조회</button>
							</div>
						</div>
						
						<div class="row">
							<div class="mb-3">
								<label class="form-label ">회원번호</label>
								<input type="text"  name="userNo" value="${userNo }" style="width: 150px;">
							</div>
						</div>
						
						<div class="row">
							<div class="mb-3">
								<label class="form-label " >회원이름</label>
								<input type="text"  name="userName" value="${userName }" style="width: 150px;">
							</div>
						</div>
						
						<div class="row">
							<div class=" mb-3">
								<label class="form-label" >프로그램명</label>
								<select class="form-select "  name="programNo" value="${userClassAttRegiModyfy.programName }">
									<option value="none" selected disabled>= 프로그램 =</option>
									<c:forEach var="category" items="${FitnessProgramCategories }">
											<option value="${category.categoryNo}">${category.categoryName }</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="row">
							<label class="form-label" >프로그램요일</label>
						</div>
						<div class="row">
							<div class="mb-3" id="prog-days">
								<input class="form-check-input  border-dark" type="checkbox" name="programName" value="${programName}" id="flexCheckDefault"> 
								<label class="form-check-label">월</label>
							</div>
						</div>
						 
						
						<div class="row">
							<div class="mb-3">
								<label class="form-label ">출석날짜</label>
								<input class="form-control " type="date" name="classAttDate" value="${userAttRegiModyfy.attDate }">
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="">등록</button>
					<a href="user-list?userNo=">취소</a>
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
	
	// 회원출석 모달창
	let attendanceFormModal = new bootstrap.Modal("#modal-form-att");
	
	$('#btn-check-attendance').click(function(event) {
		let day = moment().format("YYYY-MM-D");
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
	
	$(":input[name=programNo]").cha
	
	// 검색
	function getSearchList(){
		$.ajax({
				type:'GET',
				url: "/getSearchList",
				data: $("select[name=search").serialize(),
				success : function(result){
						// 테이블 초기화
							$('#board')
				}
		});
	};
	
	
	// 체크박스 전체 선택
	$("#checkbox-all").change(function(){
		
		//전체 체크박스 여부 조회
		let checkboxAllChecked = $(this).prop("checked");
		// 각 게시물의 체크박스 여부를 전체선택 체크박스의 체크여부와 같은 상태로 변경한다.
		$(":checkbox[name=userNo]").prop('checked',checkboxAllChecked);
		
		
	});
	
	
	
	// userNo가 바뀔 때 마다 무언가가 실행되게 하기
	$(":checkbox[name=userNo]").change(function(){
		
		toggleCheckboxAll();
	});
	
	
	function toggleCheckboxAll() {
		
			// 게시글 체크박스 갯수 조회
			let checkboxLength = $(":checkbox[name=userNo]").length;
			// 게시글 체크박스 중에서 체크된 갯수 조회
			let checkedCheckboxLength = $(":checkbox[name=userNo]:checked").length;
			// 게시글 체크박스의 갯수와 체크된 갯수가일치하면 전체선택 체크박스상태로 변경
			$("#checkbox-all").prop("checked", checkboxLength == checkedCheckboxLength);
	};
	
	// 선택해제 버튼을 클릭했을 때 해당 체크박스 해제하기
	$('#deselect').click(function(event){
		
		$("#checkbox-all").prop('checked',false);
		$(":checkbox[name=userNo]").prop('checked',false);
	});

	// 전체선택 버튼을 클릭했을 때 모든 체크박스가 선택되게하기 
	$("#select-all").click(function(){
		$("#checkbox-all").prop('checked',true);
		$(":checkbox[name=userNo]").prop('checked',true);
		
	});
		
	
});
	
</script>

			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

</body>
</html>