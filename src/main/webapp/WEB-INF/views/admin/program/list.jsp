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
					<h1>프로그램 조회</h1>
				</div>
			</div>
			
			<div class="row">
				<div class="col-12">
					<form id="sech-form" class="row float-end">
						<input type="hidden" name="page" />
						<div class="col-auto">
							<select class="form-select" name="sort">
								<option>상태</option>
								<option value="신청중" ${sort eq '신청중' ? 'selected' : '' }>신청중</option>
								<option value="진행중" ${sort eq '진행중' ? 'selected' : '' }>진행중</option>
								<option value="마감" ${sort eq '마감' ? 'selected' : '' }>마감</option>
							</select>
						</div>
						<div class="col-auto">
							<input type="text" class="form-control" name="keyword" value="${keyword }" placeholder="검색어를 입력하세요">
						</div>
						<div class="col-auto">
							<button type="submit" class="btn btn-primary mb-3">검색</button>
						</div>
					</form>
				</div>
			</div>
			
			<div class="row">
				<div class="col-12">
					<table id="programTable" class="table table-hover">
						<colgroup>
							<col width="">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead class="table-light">
							<tr>
								<th class="text-center"><input type="checkbox" disabled></th>
								<th>번호</th>
								<th class="text-center">프로그램명</th>
								<th>분류</th>
								<th>강사명</th>
								<th>시작일자</th>
								<th>종료일자</th>
								<th>정원</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty programs }">
									<tr>
										<td class="text-center" colspan="9">등록된 프로그램이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="program" items="${programs }">
										<tr class="align-middle">
											<td class="text-center"><input type="checkbox" name="programNo" value="${program.no }" class="form-check-input"></td>
											<td class="programNo">${program.no }</td>
											<td><button type="button" class="btn btn-link btn-detail">${program.name }</button></td>
											<td>${program.categoryName }</td>
											<td>${program.empName }</td>
											<td><fmt:formatDate value="${program.startDate }" pattern="yyyy-MM-dd"/> </td>
											<td><fmt:formatDate value="${program.endDate }" pattern="yyyy-MM-dd"/> </td>
											<td>${program.quota }</td>
											<td>${program.status }</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>				
			</div>
			
			<c:if test="${not empty programs }">
				<div class="row">
					<div class="col-12">
						<div class="text-end">
							<a href="/" id="modify-move" class="btn btn-primary">수정</a>
						</div>
					</div>
				</div>
			</c:if>
			
			<c:if test="${not empty pagination }">
				<div class="row">
					<div class="col-12">
						<nav aria-label="Page navigation example">
							<ul class="pagination justify-content-center">
								<li class="page-item">
									<a href="list?page=${pagination.prevPage }" class="page-link ${pagination.first? 'disabled' : '' }" onclick="changPage(event,${pagination.prevPage });">이전</a>
								</li>
								<c:forEach var="number" begin="${pagination.beginPage }" end="${pagination.endPage }">
									<li class="page-item">
										<a href="list?page=${number }" class="page-link ${pagination.page eq number ? 'active' : '' }" onclick="changPage(event,${number });">${number }</a>
									</li>
								</c:forEach>
								<li class="page-item">
									<a href="list?page=${pagination.nextPage }" class="page-link ${pagination.last? 'disabled' : '' }" onclick="changPage(event,${pagination.nextPage });">다음</a>
								</li>
							</ul>
						</nav>
					</div>
				</div>
			</c:if>
			
		</div>
	</div>
	
	<!-- 상세보기 모달창 -->
	<div class="modal fade" id="programDetail" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen-lg-down modal-dialog-centered">
			<div class="modal-content px-3">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="programTitle">상세보기</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-12">
							<table id="programInfo" class="table table-bordered">
								<tr>
									<th class="table-secondary">프로그램명</th><td id="prgramName"></td><th class="table-secondary">분류</th><td id="programCategory"></td>
								</tr>
								<tr>
									<th class="table-secondary">강사명</th><td id="empName"></td><th class="table-secondary">상태</th><td id="status"></td>
								</tr>
								<tr>
									<th class="table-secondary">시작일자</th><td id="startDate"></td><th class="table-secondary">종료일자</th><td id="endDate"></td>
								</tr>
								<tr>
									<th class="table-secondary">시작시간</th><td id="startHour"></td><th class="table-secondary">종료시간</th><td id="endHour"></td>
								</tr>
								<tr>
									<th class="table-secondary">정원</th><td id="quota"></td><th class="table-secondary">신청인원</th><td id="requestCount"></td>
								</tr>
								<tr>
									<th class="table-secondary">가격</th><td id="price"></td><th class="table-secondary">수업요일</th><td id="days"></td>
								</tr>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-12 scroll-y">
							<table id="userList" class="table text-center">
								<colgroup>
									<col width="10%" />
									<col width="20%" />
									<col width="30%" />
									<col width="40%" />
								</colgroup>
								<thead>
									<tr class="table-secondary">
										<th>번호</th>
										<th>이름</th>
										<th>연락처</th>
										<th>주소</th>
									</tr>
								</thead>
								<tbody></tbody>
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
	let programDetailModel = new bootstrap.Modal("#programDetail");
	
	// 프로그램 목록 클릭시 상세정보 모달창이 나타난다.
	$("#programTable tbody").on('click', '.btn-detail', function(event) {
		event.preventDefault();
		// 클릭한 프로그램의 프로그램번호를 가져온다.
		let no = $(this).closest("tr").children(".programNo").text();
		
		$.getJSON("/admin/program/detail.json", {programNo: no}, function(programInfo) {
			// 프로그램 상세정보
			let detail = programInfo.programDetail;
			
			$("#prgramName").text(detail.name);
			$("#programCategory").text(detail.categoryName);
			$("#empName").text(detail.empName);
			$("#status").text(detail.status);
			$("#startDate").text(detail.startDate);
			$("#endDate").text(detail.endDate);
			$("#startHour").text(detail.startHour);
			$("#endHour").text(detail.endHour);
			$("#quota").text(detail.quota + "명");
			$("#requestCount").text(detail.requestCount + "명");
			$("#price").text(detail.price + "원");
			
			$.each(detail.days, function(index, item){
				console.log(item.day);	
				$("#days").append(item.day);
			});
			
			// 프로그램 신청자 정보
			let users = programInfo.users;
			let html = "";
			if (users.length == 0) {
				html += `
					<tr>
						<td colspan="4">신청자가 없습니다.</td>
					</tr>
				`;
				$("#userList tbody").html(html);
			};
			
			for(let i = 0; i<users.length; i++) {
				let user = users[i];
				html += `
					<tr>
						<td>\${user.no}</td>
						<td>\${user.name}</td>
						<td>\${user.tel}</td>
						<td>\${user.basicAddr}</td>
					</tr>
				`;
			};
			$("#userList tbody").html(html);
		});
		
		programDetailModel.show();
	});
	
	// 프로그램 수정 페이지 이동
	$("#modify-move").click(function(event) {
		event.preventDefault();
		
		let programNo = $("input[name='programNo']:checked").val();
		let checkedLength = $("input[name='programNo']:checked").length;
		
		if (checkedLength > 1) {
			alert("수정할 프로그램은 한개만 선택가능합니다.");	
			return false;
		};
		
		location.href = "modify?programNo=" + programNo;
	});
	
	// 페이지번호를 클릭했을 때 실행되는 이벤트
	function changPage(event, page) {
		event.preventDefault();
		$("input[name=page]").val(page);
		
		$("#sech-form").submit()
	}
	
})
</script>
</body>
</html>