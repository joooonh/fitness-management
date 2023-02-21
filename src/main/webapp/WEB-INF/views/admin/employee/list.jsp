<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="../../../resources/css/common.css">
<link rel="stylesheet" href="../../../resources/css/content.css">
<title>중앙피트니스</title>
</head>
<body>

<!------------------------------------ 헤더 navbar 영역 ---------------------------------------->
<%@ include file="../../common/header.jsp" %>
<div class="container-fluid mt-4">
	<div class="row">
		<div class="col-md-2 sidebar">
			<!---------------------------------- 사이드 바 영역  ----------------------------------------->
			<%@ include file="../../common/sidebar.jsp" %>
		</div>
		<div class="col-md-10 ps-4 pt-5">
			<!--------------------------------- Content 영역 ------------------------------------------->
			<div class="row">
				<div class="col-12">
					<h1>직원 목록</h1>
				</div>
			</div>
			
			<div class="row">
				<div class="col-12">
					<form id="seach-form" class="row float-end">
						<input type="hidden" name="page" />
						<div class="col-auto">
							<select class="form-select" name="status">
								<option selected disabled>재직상태</option>
								<option value="전체" ${param.status eq '전체' ? 'selected' : '' }>전체</option>
								<option value="재직" ${param.status eq '재직' ? 'selected' : '' }>재직</option>
								<option value="휴직" ${param.status eq '휴직' ? 'selected' : '' }>휴직</option>
								<option value="퇴직" ${param.status eq '퇴직' ? 'selected' : '' }>퇴직</option>
							</select>
						</div>
						<div class="col-auto">
							<input type="text" class="form-control" name="keyword" value="${param.keyword }" placeholder="검색어를 입력하세요">
						</div>
						<div class="col-auto">
							<button type="submit" class="btn btn-primary mb-3">검색</button>
						</div>
					</form>
				</div>
			</div>
			
			<div class="row">
				<div class="col-12">
					<table id="employeeTable" class="table table-hover align-middle text-center">
						<colgroup>
							<col width="8%">
							<col width="10%">
							<col width="21%">
							<col width="21%">
							<col width="30%">
							<col width="10%">
						</colgroup>
						<thead class="table-light">
							<tr>
								<th class="text-center"><input type="checkbox" disabled></th>
								<th>이름</th>
								<th>아이디</th>
								<th>연락처</th>
								<th>이메일</th>
								<th>재직상태</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty employees }">
									<tr>
										<td colspan="6" class="text-center">등록된 직원이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="employee" items="${employees }">
										<tr>
											<td class="text-center"><input type="checkbox" name="id" value="${employee.id }" class="form-check-input"></td>
											<td><button type="button" class="btn btn-link btn-detail">${employee.name }</button></td>
											<td class="empId">${employee.id }</td>
											<td>${employee.tel }</td>
											<td>${employee.email }</td>
											<td>${employee.status }</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>				
			</div>
			<c:if test="${not empty employees }">
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<div class="row">
						<div class="col-12">
							<div class="text-end">
								<a href="/" id="btn-delete-program" class="btn btn-secondary">삭제</a>
								<a href="/" id="btn-modify-move" class="btn btn-primary">수정</a>
							</div>
						</div>
					</div>
				</sec:authorize>
				<div class="row">
					<div class="col-12">
						<nav aria-label="Page navigation example">
							<ul class="pagination justify-content-center">
								<li class="page-item">
									<a href="list?page=${pagination.prevPage }" data-page-no="${pagination.prevPage }" class="page-link ${pagination.first? 'disabled' : '' }" >이전</a>
								</li>
								<c:forEach var="number" begin="${pagination.beginPage }" end="${pagination.endPage }">
									<li class="page-item">
										<a href="list?page=${number }" data-page-no="${number }" class="page-link ${pagination.page eq number ? 'active' : '' }" >${number }</a>
									</li>
								</c:forEach>
								<li class="page-item">
									<a href="list?page=${pagination.nextPage }" data-page-no="${pagination.nextPage }" class="page-link ${pagination.last? 'disabled' : '' }" >다음</a>
								</li>
							</ul>
						</nav>
					</div>
				</div>
			</c:if>
			
		</div>
	</div>
	
	<!-- 상세보기 모달창 -->
	<div class="modal fade" id="employeeDetail" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen-lg-down modal-dialog-centered">
			<div class="modal-content px-3">
				<div class="modal-header">
					<h1 class="modal-title fs-5">상세정보</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-5">
							<div class="profile">
								<img src="/resources/images/default.png" id="empProfile" class="rounded-circle" alt="직원 프로필 사진" style="width:100%">
							</div>
						</div>
						<div class="col-7">
							<table id="" class="table table-bordered">
								<colgroup>
									<col width="30%">
									<col width="70%">
								</colgroup>
								<tr>
									<th class="table-secondary">아이디</th><td id="empId"></td>
								</tr>
								<tr>
									<th class="table-secondary">이름</th><td id="empName"></td>
								</tr>
								<tr>
									<th class="table-secondary">이메일</th><td id="empEmail"></td>
								</tr>
								<tr>
									<th class="table-secondary">연락처</th><td id="empTel"></td>
								</tr>
								<tr>
									<th class="table-secondary">주소</th><td id="empBasicAddress"></td>
								</tr>
								<tr>
									<th class="table-secondary">상세주소</th><td id="empDetailAddress"></td>
								</tr>
								<tr>
									<th class="table-secondary">재직상태</th><td id="empStatus"></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<div class="modal-footer d-flex justify-content-center">
					<button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	let employeeDetailModel = new bootstrap.Modal("#employeeDetail");
	
	// 직원 클릭시 상세정보 모달창이 나타난다.
	$("#employeeTable tbody").on('click', '.btn-detail', function(event) {
		event.preventDefault();
		// 클릭한 직원의 아이디를 가져온다.
		let id = $(this).closest("tr").children(".empId").text();

		$.getJSON("detail.json", {empId: id}, function(employeeInfo) {
			$("#empProfile").attr("src","/resources/images/"+employeeInfo.photo);
			$("#empId").text(employeeInfo.id);
			$("#empName").text(employeeInfo.name);
			$("#empEmail").text(employeeInfo.email);
			$("#empTel").text(employeeInfo.tel);
			$("#empBasicAddress").text(employeeInfo.basicAddress);
			$("#empDetailAddress").text(employeeInfo.detailAddress);
			$("#empStatus").text(employeeInfo.status);
		});
		
		employeeDetailModel.show();
	});

	// 직원 삭제 
	$("#btn-delete-program").click(function(event) {
		event.preventDefault();

		// 체크된 직원 인원 조회
		let checkedLength = $("input[name='id']:checked").length;
		// 여러명 삭제할 직원의 아이디를 담을 배열을 생성		
		let idList = [];
		
		if (checkedLength == 0) {
			alert("삭제할 직원을 선택하세요.");	
			return false;
		};
		
		// 체크한 직원의 아이디를 배열에 담는다.
		$("input[name='id']:checked").each(function() {
			idList.push($(this).val());
		});
		
		// 삭제여부를 확인한다.
		if (confirm("삭제한 직원은 복구가 안됩니다. 삭제하시겠습니까?")) {
			location.href = "delete?empId=" + idList;
		}
	});
	
	// 직원 정보 수정 페이지 이동
	$("#btn-modify-move").click(function(event) {
		event.preventDefault();
		
		// 체크된 직원의 아이디 조회
		let id = $("input[name='id']:checked").val();
		// 체크된 직원의 인원수 조회
		let checkedLength = $("input[name='id']:checked").length;
		
		if (checkedLength == 0) {
			alert("수정할 직원을 선택하세요.");
			return false;
		};
		// 수정할 직원은 한명만 선택하도록 한다.
		if (checkedLength > 1) {
			alert("수정할 직원은 한명만 선택가능합니다.");	
			return false;
		};
		
		location.href = "modify-form?empId=" + id;
	});
	
	// 페이지 클릭 이벤트
	$(".pagination a").click(function(event) {
		event.preventDefault();
		let pageNo = $(this).attr("data-page-no");
		$("input[name=page]").val(pageNo);
		$("#seach-form").trigger("submit");
	});
})
</script>
</body>
</html>