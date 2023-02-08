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
									<select class="form-select" name="category">
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
									  <input type="text" class="form-control" name="employeeName">
									  <button class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#seachEmployee"><i class="bi bi-search"></i></button>
									</div>
								</td>
							</tr>
							<tr>
								<th class="table-light">시작일</th>
								<td>
									<input type="date" id="start-date" name="startDate" class="form-control"/>
								</td>
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
										<input id="mon" class="form-check-input" type="checkbox" name="day" value="월" />
										<label class="form-check-label" for="mon">월</label>
										<input id="tue" class="form-check-input" type="checkbox" name="day" value="화" />
										<label class="form-check-label" for="tue">화</label>
										<input id="wed" class="form-check-input" type="checkbox" name="day" value="수" />
										<label class="form-check-label" for="wed">수</label>
										<input id="thur" class="form-check-input" type="checkbox" name="day" value="목" />
										<label class="form-check-label" for="thur">목</label>
										<input id="fri" class="form-check-input" type="checkbox" name="day" value="금" />
										<label class="form-check-label" for="fri">금</label>
									</div>
								</td>
							</tr> 
							<tr>
								<th class="table-light">정원</th>
								<td><input type="number" min="0" max="50" class="form-control" /></td>
							</tr>
							<tr>
								<th class="table-light">가격</th>
								<td><input type="number" min="0" class="form-control" /></td>
							</tr>
						</table>
						
						<button class="btn btn-primary float-end">등록</button>
					</form>
				</div>
			</div>
		</div>
	</div>	
	
	<!-- 직원검색 모달창 -->
	<div class="modal fade" id="seachEmployee" tabindex="-1" aria-labelledby="seachTitle" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen-lg-down modal-dialog-centered">
			<div class="modal-content px-3">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="seachTitle">강사검색</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-12 mb-5 text-center">
							<input type="text"/>
						</div>
					</div>
					<div class="row">
						<div class="col-12 scroll-y">
							<table id="userList" class="table text-center">
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
													<td>${employee.name }</td>
													<td>${employee.tel }</td>
													<td>${employee.basicAddress }</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
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
</body>
</html>