<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/user-management.css">
<title>중앙피트니스</title>
</head>
<body>
<!-- 헤더 navbar 영역 -->
<%@ include file="../common/header.jsp" %>
<div class="container-fluid mt-4">
	<div class="row">
		<div class="col-md-2 sidebar">
			<!-- 사이드 바 영역  -->
			<%@ include file="../common/sidebar.jsp" %>
		</div>
		<div class="col-md-10 ps-2 pt-5">
			<!-- Content 영역 -->
			<div class="row ms-3">
				<div class="row pt-2 mb-3">
					<div class="col-12">
						<h5><i class="bi bi-person-lines-fill ms-2 me-3"></i><strong>회원정보 조회</strong></h5>
						<hr width="103%" color="gray">
					</div>
				</div>
				<!--------------------------- (좌) 회원 목록 ------------------------------>
				<div class="col-5">
					<form id="search-form" class="">
						<input type="hidden" name="page" value="${not empty param.page ? param.page : 1 }"/>
						<input type="hidden" name="sort" value="${not empty param.sort ? param.sort : 'no' }" />
						<div class="row mb-3">
							<div class="col">
								<select name="programNo" class="form-select d-inline">
									<option value="0">프로그램명 선택</option>
									<c:forEach var="program" items="${programList }">
										<option value="${program.no }" ${param.programNo eq program.no ? 'selected' : '' }>${program.name }</option>
									</c:forEach>
								</select>
							</div>
							<div class="col">
								<input type="search" class="form-control" name="keyword" placeholder="검색어를 입력하세요." value="${param.keyword }">
							</div>
							<div class="col">
								<button type="button" class="btn btn-xs btn-dark" id="btn-search">검색</button>
							</div>
						</div>
						<div class="row mb-3">
							<div class="col">
								<button type="button" class="btn btn-xs btn-dark" id="btn-delete-user"><i class="bi bi-trash"></i> 회원삭제</button>
							</div>
							<div class="col text-end mt-3" id="sort-div">
								<span class="badge ${empty param.sort or param.sort eq 'no' ? 'bg-warning' : 'bg-secondary' }" data-sort-method="no" style="cursor: pointer;">회원번호순 </span>
								<span class="badge ${param.sort eq 'date' ? 'bg-warning' : 'bg-secondary' }" data-sort-method="date" style="cursor: pointer;">최근등록순 </span>
								<span class="badge ${param.sort eq 'name' ? 'bg-warning' : 'bg-secondary' }" data-sort-method="name" style="cursor: pointer;">이름순</span>
							</div>
						</div>
						<table class="table table-sm table-hover border" id="table-member-list">
							<colgroup>
								<col width="5%">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
							</colgroup>
							<thead>
								<tr class="border table-secondary">
									<th class="text-center"><input type="checkbox" id="checkbox-all" /></th>
									<th class="text-center">회원번호</th>
									<th class="text-center">이름</th>
									<th class="text-center">성별</th>
									<th class="text-center">생년월일</th>
									<th class="text-center">연락처</th>
									<th class="text-center">수업명</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty userList }">
										<tr>
											<td colspan="12" class="text-center">등록된 회원이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="user" items="${userList }">
											<tr>
												<td class="text-center"><input type="checkbox" name="userId" value="${user.id }" /></td>
												<td class="text-center">${user.no }</td>
												<td class="text-center"><a href="" class="text-decoration-none text-dark" data-user-id="${user.id }" >${user.name }</a></td>
												<td class="text-center">${user.gender }</td>
												<td class="text-center"><fmt:formatDate value="${user.birth }" pattern="yyyy-MM-dd" /></td>
												<td class="text-center">${user.tel }</td>
												<td class="text-center">
													<select name="programName" class="form-select form-select-sm">
														<c:forEach var="prog" items="${user.programs }">
															<option value="${prog.no }">${prog.name }</option>
														</c:forEach>
													</select>
												</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						<div class="row">
							<strong><p>총 ${totalRows }명</p></strong>
						</div>
						<div class="row">
							<div class="col-12">
								<c:if test="${totalRows > 0 }">
									<nav aria-label="Page navigation example">
										<ul class="pagination justify-content-center">
											<li class="page-item ${pagination.first ? 'disabled' : '' }">
												<a href="userList?page=${pagination.prevPage }" data-page-no="${pagination.prevPage }" class="page-link">이전</a>
									    	</li>
									    	<c:forEach var="number" begin="${pagination.beginPage }" end="${pagination.endPage }">
											    <li class="page-item ${pagination.page eq number ? 'active' : '' }">
											    	<a href="userList?page=${number }" data-page-no="${number }" class="page-link">${number }</a>
											    </li>
									    	</c:forEach>
										    <li class="page-item ${pagination.last ? 'disabled' : '' }">
										    	<a href="userList?page=${pagination.nextPage }" data-page-no="${pagination.nextPage }" class="page-link">다음</a>
										    </li>
										</ul>
									</nav>
								</c:if>
							</div>
						</div>
					</form>
				</div>
				<!--------------------------- (우) 회원 정보 ------------------------------>
				<div class="col">
					<div class="row">
						<div class="col-3 pt-4" style="text-align:center" >
							<div>
								<sec:authentication property="principal.providerType" var="providerType"/>
								<c:choose>
									<c:when test="${empty providerType }">
										<img id="profile-img" src="/resources/images/default.png" width="170" height="170" class="border inline-block">
									</c:when>
									<c:otherwise>
										<img id="profile-img" src="${user.photo }" width="170" height="170" class="border inline-block">
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="col">
							<table class="table table-bordered">
								<colgroup>
									<col width="20%">
									<col width="30%">
									<col width="20%">
									<col width="30%">
									<col width="20%">
									<col width="*">
								</colgroup>
								<tbody class="text-center">
									<tr>
										<th class="table-secondary">회원번호</th>
										<td id="cell-user-no"></td>
										<th class="table-secondary">아이디</th>
										<td id="cell-user-id"></td>
									</tr>
									<tr>
										<th class="table-secondary">이름</th>
										<td id="cell-user-name"></td>
										<th class="table-secondary">성별</th>
										<td id="cell-user-gender"></td>
									</tr>
									<tr>
										<th class="table-secondary">생년월일</th>
										<td id="cell-user-birth"></td>
										<th class="table-secondary">이메일</th>
										<td id="cell-user-email"></td>
									</tr>
									<tr>
										<th class="table-secondary">연락처</th>
										<td id="cell-user-tel"></td>
										<th class="table-secondary">가입날짜</th>
										<td id="cell-user-created-date"></td>
									</tr>
									<tr>
										<th class="table-secondary">주소</th>
										<td id="cell-user-address" colspan="3"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="tab-list">
							<li class="tab-button active">회원권</li>
							<li class="tab-button">수업</li>
							<li class="tab-button">상담</li>
						</div>
					</div>
					<div class="row" id="tab-table-list">
						<!-- 회원권 탭 -->
						<table class="table table-sm border" id="table-membership">
							<colgroup>
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
							</colgroup>
							<thead>
								<tr class="border table-secondary">
									<th class="text-center">회원권 번호</th>
									<th class="text-center">회원권 기간</th>
									<th class="text-center">회원권 시작일자</th>
									<th class="text-center">회원권 종료일자</th>
									<th class="text-center">회원권 등록일자</th>
									<th class="text-center">결제 금액</th>
									<th class="text-center">결제 일자</th>
								</tr>
							</thead>
							<tbody id="tbody-membership">
								<!-- ajax로 받은 회원권 리스트 출력 -->
							</tbody>
						</table>
						<!-- 수업 탭 -->
						<table class="table table-sm border" id="table-class" style="display:none;">
							<colgroup>
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
							</colgroup>
							<thead>
								<tr class="border table-secondary">
									<th class="text-center">예약번호</th>
									<th class="text-center">수업분류</th>
									<th class="text-center">수업명</th>
									<th class="text-center">강사명</th>
									<th class="text-center">수업요일</th>
									<th class="text-center">수업시간</th>
									<th class="text-center">결제금액</th>
									<th class="text-center">결제일자</th>
								</tr>
							</thead>
							<tbody id="tbody-class">
								<!-- ajax로 받은 수업 리스트 출력 -->
							</tbody>
						</table>
						<!-- 예약 탭 -->
						<table class="table table-sm border" id="table-consulting" style="display:none;">
							<colgroup>
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
							</colgroup>
							<thead>
								<tr class="border table-secondary">
									<th class="text-center">예약번호</th>
									<th class="text-center">상담사</th>
									<th class="text-center">상담프로그램</th>
									<th class="text-center">예약일자</th>
									<th class="text-center">접수일자</th>
									<th class="text-center">예약상태</th>
								</tr>
							</thead>
							<tbody id="tbody-consulting">
								<!-- ajax로 받은 상담 리스트 출력 -->
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(function(){
	
	// 정렬방식을 클릭했을 때 실행되는 이벤트 핸들러 함수
	$("#sort-div").on('click', 'span', function(event){
		event.preventDefault();
		const sortMethod = $(this).attr("data-sort-method");
		$("input[name=sort]").val(sortMethod);
		submitForm(1);
	})
	
	// 페이지 클릭 이벤트
	$(".pagination").on('click', 'a', function(event) {
		event.preventDefault();
		const pageNo = $(this).attr("data-page-no");
		submitForm(pageNo);
	})
	
	// 검색 클릭 이벤트
	$("#btn-search").on('click', function(){
		submitForm(1);
	})
	
	// 검색 엔터키 이벤트
	$("input[name=keyword]").on('keydown', function(key){
		if(key.keyCode == '13'){	
			submitForm(1);	
		}
	})
	
	// 폼 제출
	function submitForm(pageNo){
		$("input[name=page]").val(pageNo);
		$("#search-form").trigger("submit");
	}
	
	// 회원 삭제 
	$("#btn-delete-user").click(function(){
		let checkedLength = $("input[name=userId]:checked").length;
		let deleteUsers = [];
		
		if(checkedLength == 0){
			alert("삭제할 회원을 선택하세요.");
			return false;
		}
		$("input[name=userId]:checked").each(function(){
			let value = $(this).val();
			if($(this).val() != ""){
				deleteUsers.push($(this).val());
			}
		});
		location.href = "deleteUser?userId=" + deleteUsers;
	})
	
	// 전체 체크박스 클릭
	$("#checkbox-all").change(function(){
		const checkboxAllChecked = $(this).prop("checked");
		$(":checkbox[name=userId]").prop("checked", checkboxAllChecked);
	})
	
	// 회원 상세정보 - ajax
	$("#table-member-list").on('click', 'a', function(event){
		event.preventDefault();
		const userId = $(this).attr("data-user-id");
		
		$.ajax({
			type: "GET",
			url: "/emp/userDetail",
			data: {userId:userId},
			dataType: "json",
			success: function(map){
				
				const user = map.user;
				const membershipList = map.membershipList;
				const classList = map.classRegList;
				const consultingList = map.consultingList;
				
				// 회원 상세정보 조회
				if (user.providerType == null) {
					$("#profile-img").attr("src", "/resources/images/profile/" + user.photo);					
				} else {
					$("#profile-img").attr("src", user.photo);					
				}
				$("#cell-user-no").text(user.no);
				$("#cell-user-id").text(user.id);
				$("#cell-user-name").text(user.name);
				$("#cell-user-gender").text(user.gender);
				$("#cell-user-birth").text(user.birth);
				$("#cell-user-email").text(user.email);
				$("#cell-user-tel").text(user.tel);
				$("#cell-user-created-date").text(user.createdDate);
				$("#cell-user-address").text(user.basicAddr + " " + user.detailAddr);
				
				// 회원권 조회
				$("#tbody-membership").empty(); 
				let membership = ""; 	
				if(membershipList.length > 0) {
					for(let index in membershipList){
						membership += "<tr>";
						membership += "	<td class='text-center'>" + membershipList[index].no + "</td>";
						membership += "	<td class='text-center'>" + membershipList[index].period + " 개월" + "</td>";
						membership += "	<td class='text-center'>" + membershipList[index].startDate + "</td>";
						membership += "	<td class='text-center'>" + membershipList[index].endDate + "</td>";
						membership += "	<td class='text-center'>" + membershipList[index].createdDate + "</td>";
						membership += "	<td class='text-center'>" + membershipList[index].totalPaymentPrice + " 원 </td>";
						membership += "	<td class='text-center'>" + membershipList[index].paymentCompletedDate + "</td>";
						membership += "</tr>";
					}
				} else {
					membership += "<tr>";
					membership += "	<td colspan='12' class='text-center'>회원권이 없습니다.</td>"
					membership += "</tr>";
				}
				
				$("#tbody-membership").append(membership);
					
				// 수업 조회
				$("#tbody-class").empty();
				let classReg = "";
				if(classList.length > 0){
					for(let index in classList){
						classReg += "<tr>";
						classReg += "	<td class='text-center'>" + classList[index].classRegNo + "</td>";
						classReg += "	<td class='text-center'>" + classList[index].programCategoryName + "</td>";
						classReg += "	<td class='text-center'>" + classList[index].programName + "</td>";
						classReg += "	<td class='text-center'>" + classList[index].empName + "</td>";
						classReg += "	<td class='text-center'>" + classList[index].openDays + "</td>";
						classReg += "	<td class='text-center'>" + classList[index].startHour + " ~ " + classList[index].endHour + "</td>";
						classReg += "	<td class='text-center'>" + classList[index].totalPaymentPrice + " 원 </td>";
						classReg += "	<td class='text-center'>" + classList[index].paymentCompletedDate + "</td>";
						classReg += "</tr>";
					}
				} else {
					classReg += "<tr>";
					classReg += "	<td colspan='12' class='text-center'>수업신청 내역이 존재하지 않습니다.</td>"
					classReg += "</tr>";
				}
				$("#tbody-class").append(classReg);
				
				// 상담 조회 
				$("#tbody-consulting").empty();
				let consulting = "";
				if(consultingList.length > 0){
					for(let index in consultingList){
						consulting += "<tr>";
						consulting += "	<td class='text-center'>" + consultingList[index].no + "</td>";
						consulting += "	<td class='text-center'>" + consultingList[index].empName + "</td>";
						consulting += "	<td class='text-center'>" + consultingList[index].programName + "</td>";
						consulting += "	<td class='text-center'>" + consultingList[index].reservationDate + "</td>";
						consulting += "	<td class='text-center'>" + consultingList[index].createdDate + "</td>";
						consulting += "	<td class='text-center'>" + consultingList[index].status + "</td>";
						consulting += "</tr>";
					}
				} else {
					consulting += "<tr>";
					consulting += "	<td colspan='12' class='text-center'>상담내역이 존재하지 않습니다.</td>"
					consulting += "</tr>";
				}
				$("#tbody-consulting").append(consulting);
			}
		})
	})
	
	// 탭 클릭시 테이블 표시
	$(".tab-list li").click(function(){
		const index = $(this).index();
		
		$(".tab-list li").removeClass("active");
		$(".tab-list li").eq(index).addClass("active");
		$("#tab-table-list .table-sm").hide();
		$("#tab-table-list .table-sm").eq(index).show();
	})
	
})
</script>
</body>
</html>