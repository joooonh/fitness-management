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
					<h1>프로그램 등록</h1>
				</div>
			</div>
			
			<div class="row mt-5">
				<div class="col-12 program-insert-wrap">
					<form action="insert" method="post">
						<input type="hidden" name="employeeId">
						<table class="table table-bordered table-program-insert">
							<colgroup>
								<col width="20%">
								<col width="80%">
							</colgroup>
							<tr>
								<th class="table-light">프로그램 명</th>
								<td><input type="text" class="form-control form-control-sm" name="name" /></td>
							</tr>
							<tr>
								<th class="table-light">프로그램 분류</th>
								<td>
									<select class="form-select" name="categoryNo">
										<c:forEach var="category" items="${categories }">
												<option value="${category.no }">${category.name }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th class="table-light">강사</th>
								<td>
									<div class="input-group">
									  <input type="text" class="form-control" name="employeeName" style="cursor:pointer;">
									  <button class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#searchEmployee"><i class="bi bi-search"></i></button>
									</div> 
								</td>
							</tr>
							<tr>
								<th class="table-light">시작일</th>
								<td><input type="date" name="startDate" class="form-control"/></td>
							</tr>
							<tr>
								<th class="table-light">종료일</th>
								<td><input type="date" name="endDate" class="form-control"/></td>
							</tr>
							<tr>
								<th class="table-light">시작시간</th>
								<td><input type="time" name="startHour" class="form-control"/></td>
							</tr>
							<tr>
								<th class="table-light">종료시간</th>
								<td><input type="time" name="endHour" class="form-control"/></td>
							</tr>
							<tr>
								<th class="table-light">수업요일</th>
								<td>
									<div>
										<input class="form-check-input" type="checkbox" name="day" value="월" />
										<label class="form-check-label">월</label>
										<input class="form-check-input" type="checkbox" name="day" value="화" />
										<label class="form-check-label">화</label>
										<input class="form-check-input" type="checkbox" name="day" value="수" />
										<label class="form-check-label">수</label>
										<input class="form-check-input" type="checkbox" name="day" value="목" />
										<label class="form-check-label">목</label>
										<input class="form-check-input" type="checkbox" name="day" value="금" />
										<label class="form-check-label">금</label>
										<input class="form-check-input" type="checkbox" name="day" value="토" />
										<label class="form-check-label">토</label>
										<input class="form-check-input" type="checkbox" name="day" value="일" />
										<label class="form-check-label">일</label>
									</div>
								</td>
							</tr> 
							<tr>
								<th class="table-light">정원</th>
								<td><input type="number" name="quota" min="0" max="999" class="form-control" /></td>
							</tr>
							<tr>
								<th class="table-light">가격</th>
								<td><input type="number" name="price" min="0" max="9999999" class="form-control" /></td>
							</tr>
						</table>
						
						<button type="button" id="btn-insert-program" class="btn btn-primary float-end">등록</button>
					</form>
				</div>
			</div>
		</div>
	</div>	
	
	<!-- 직원검색 모달창 -->
	<div class="modal fade" id="searchEmployee" tabindex="-1" aria-labelledby="seachTitle" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen-lg-down modal-dialog-centered">
			<div class="modal-content px-3">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="seachTitle">강사검색</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-12 mb-4 text-center">
							<div class="input-group mb-3">
								<input type="text" name="name" class="form-control" placeholder="강사이름을 검색하세요" >
								<button type="button" id="btn-search-employee" class="btn btn-secondary"><i class="bi bi-search"></i></button>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-12 scroll-y">
							<table id="employeeTable" class="table table-hover text-center">
								<colgroup>
									<col width="20%" />
									<col width="40%" />
									<col width="40%" />
								</colgroup>
								<thead>
									<tr class="table-secondary">
										<th>이름</th>
										<th>연락처</th>
										<th>주소</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty employeeList }">
											<tr>
												<td colspan="3">재직중인 강사가 없습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="employee" items="${employeeList }">
												<tr>
													<td class="name">
														<span data-employee-id="${employee.id }">${employee.name }</span>
													</td>
													<td>${employee.tel }</td>
													<td>${employee.basicAddress }</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
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
		// 강사 검색 모달창이 나타난다.
		$("input[name=employeeName]").click(function() {
			$("#searchEmployee").modal('show');
		});
		
		$("#btn-search-employee").click(function() {
			let name = $("#searchEmployee input[name=name]").val();
			
			$.getJSON("/admin/program/searchEmployees", {employeeName:name}, function(employees) {
				let html = "";
				
				if (employees.length == 0) {
					html += `
						<tr>
							<td colspan="3">검색된 강사가 없습니다.</td>
						</tr>
					`;
					
					$("#employeeTable tbody").html(html);		
				};
				
				for (let i = 0; i < employees.length; i++) {
					let employee = employees[i];
					html += `
						<tr>
							<td class="name">
								<input type="hidden" name="id" value="\${employee.id }">
								<span>\${employee.name }</span>
							</td>
							<td>\${employee.tel }</td>
							<td>\${employee.basicAddress }</td>
						</tr>
					`;
				};
				$("#employeeTable tbody").html(html);	
			});
		});
		
		// 강사 목록에서 선택한 강사이름과 아이디를 대입한다.
		$("#employeeTable tbody").on('click', 'tr', function(){
			let name = $(this).children(".name").children("span").text();
			let id = $(this).children(".name").children("span").attr("data-employee-id");
			
			$("input[name=employeeName]").val(name);
			$("input[name=employeeId]").val(id);
			
			$("#searchEmployee").modal('hide');
		});
		
		// 현재 날짜를 구한다.
		let today = new Date();
		// yyyy-MM-dd 형식으로 날짜를 구한다.
		let year = today.getFullYear();
		let month = ("0" + (today.getMonth() + 1)).slice(-2);
		let day = ("0" + today.getDate()).slice(-2);
		let nowDate = year + '-' + month  + '-' + day;
		// 시작일과 종료일이 오늘 이전 날짜는 선택하지 못하게 한다.
		$("input[name=startDate]").attr("min", nowDate);
		$("input[name=endDate]").attr("min", nowDate);
		
		$("#btn-insert-program").click(function () {
			let startDate = $("input[name=startDate]").val();
			let endDate = $("input[name=endDate]").val();
			let startHour = $("input[name=startHour]").val();
			let endHour = $("input[name=endHour]").val();
			
			if ($("input[name=name]").val() == "") {
				alert("프로그램 명을 입력하세요.");
				return false;
			}
			if ($("input[name=employeeName]").val() == "") {
				alert("강사를 선택하세요.");
				return false;
			}
			if (startDate == "") {
				alert("시작일을 선택해야 합니다.");
				return false;
			}
			if (endDate == "") {
				alert("종료일을 선택해야 합니다.");
				return false;
			}
			if (startHour == "") {
				alert("시작시간을 선택해야 합니다.");
				return false;
			}
			if (endHour == "") {
				alert("종료시간을 선택해야 합니다.");
				return false;
			}
			// 날짜 비교
			if (startDate > endDate) {
				alert("시작일은 종료일보다 작아야합니다.");
				return false;
			}
			// 시간 비교
			if (startHour > endHour) {
				alert("시작시간은 종료시간보다 작아야합니다.");
				return false;
			}
			// 날짜 선택
			if (!$("input[name=day]").is(":checked")) {
				alert("수업요일은 하루이상 선택해야합니다.");
				return false;
			}
			// 숫자만 입력가능한 표현식
			let check = /^[0-9]*$/; 
			let quota = $("input[name=quota]").val();
			let price = $("input[name=price]").val();
			if (quota == "") {
				alert("정원을 입력하세요.");
				return false;
			}
			if (quota < 0 || quota > 999) {
				alert("정원은 0명이상 999명이하로 등록가능합니다.");
				return false;
			}
			if (price == "") {
				alert("가격을 입력하세요.");
				return false;
			}
			if (price < 0 || price > 9999999) {
				alert("가격은 0원이상 9999999원이하로 등록가능합니다.");
				return false;
			}
 			if (!check.test(quota) || !check.test(price)) {
				alert("숫자만 입력가능합니다.");
				return false;
			}
			
			$("form").submit();
		});
	})
</script>
</body>
</html>