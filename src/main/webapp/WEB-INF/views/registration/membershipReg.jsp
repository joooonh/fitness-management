<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/resources/css/common.css">
<title>중앙피트니스</title>
<style type="text/css">
</style>
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
		<div class="col-md-10 ps-4 pt-5">
			<!-- Content 영역 -->
			<div class="row ms-3">
				<div class="row pt-2 mb-3">
					<div class="col-12">
						<h5><i class="bi bi-person-lines-fill ms-2 me-3"></i><strong>회원권 신청현황</strong></h5>
						<hr width="103%" color="gray">
					</div>
				</div>
				
				<div class="row">
					<div class="col-12">
						<form action="membershipRegList" class="row d-flex justify-content-end align-items-center mb-3">
							<input type="hidden" name="page" />
							<div class="col-auto d-flex align-items-center text-nowrap">
								<label class="me-2">날짜조회</label>
								<input type="date" name="startDate" value="${param.startDate }" class="form-control form-control-sm" />
								<label class="m-1">~</label>
								<input type="date" name="endDate" value="${param.endDate }" class="form-control form-control-sm" />
							</div>
							<div class="col-auto">
								<select class="form-select" name="period">
									<option selected disabled>기간</option>
									<option value="전체" ${param.period eq '전체' ? 'selected' : '' }>전체</option>
									<option value="1" ${param.period eq '1' ? 'selected' : '' }>1개월</option>
									<option value="3" ${param.period eq '3' ? 'selected' : '' }>3개월</option>
									<option value="6" ${param.period eq '6' ? 'selected' : '' }>6개월</option>
									<option value="12" ${param.period eq '12' ? 'selected' : '' }>12개월</option>
								</select>
							</div>
							<div class="col-auto">
								<input type="text" class="form-control" name="keyword" value="${param.keyword }" placeholder="검색어를 입력하세요">
							</div>
							<div class="col-auto">
								<button type="submit" class="btn btn-primary">검색</button>
							</div>
						</form>
					</div>
				</div>
				
				<div class="row">
					<div class="col-12">
						<table class="table">
							<colgroup>
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
							</colgroup>
							<thead>
								<tr class="table-secondary">	
									<th>이름</th>
									<th>연락처</th>
									<th>시작일</th>
									<th>종료일</th>
									<th>기간</th>
									<th>결재일</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty membershipList }">
										<tr>
											<td colspan="6" class="text-center">신청한 회원권이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="membership" items="${membershipList }">
											<tr>
												<td>${membership.name }</td>
												<td>${membership.tel }</td>
												<td><fmt:formatDate value="${membership.startDate }" pattern="yyyy-MM-dd"/></td>
												<td><fmt:formatDate value="${membership.endDate }" pattern="yyyy-MM-dd"/></td>
												<td>${membership.period }개월</td>
												<td><fmt:formatDate value="${membership.completedDate }" pattern="yyyy-MM-dd"/></td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
				
				<c:if test="${not empty membershipList }">
					<div class="row">
						<div class="col-12">
							<nav aria-label="Page navigation">
								<ul class="pagination justify-content-center">
									<li class="page-item">
										<a href="membershipRegList?page=${pagination.prevPage }" data-page-no="${pagination.prevPage }" class="page-link ${pagination.first? 'disabled' : '' }" >이전</a>
									</li>
									<c:forEach var="number" begin="${pagination.beginPage }" end="${pagination.endPage }">
										<li class="page-item">
											<a href="membershipRegList?page=${number }" data-page-no="${number }" class="page-link ${pagination.page eq number ? 'active' : '' }" >${number }</a>
										</li>
									</c:forEach>
									<li class="page-item">
										<a href="membershipRegList?page=${pagination.nextPage }" data-page-no="${pagination.nextPage }" class="page-link ${pagination.last? 'disabled' : '' }" >다음</a>
									</li>
								</ul>
							</nav>
						</div>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	$(".pagination a").click(function(event) {
		event.prventDefault();
		let pageNo = $(this).attr("data-page-no");
		$("input[name=page]").val(pageNo);
		$("form").trigger("submit");
	});
})
</script>
</body>
</html>