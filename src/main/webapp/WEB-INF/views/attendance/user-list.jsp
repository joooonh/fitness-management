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
									<th class="text-start"><input class="form-check-input ms-2 me-3" type="checkbox" value="행체크"><span>회원번호</span></th>
									<th>회원이름</th>
									<th>성별</th>
									<th>회원권(헬스)</th>
									<th>프로그램명</th>
									<th>휴대폰</th>
									<th>이메일</th>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>