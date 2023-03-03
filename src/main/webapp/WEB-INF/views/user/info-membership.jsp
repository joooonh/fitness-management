<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/userInfo-sideMenu.css">
<link rel="stylesheet" href="/resources/css/userInfo-membership.css">
<title>애플리케이션</title>
</head>
<body class="pt-5">
<c:set var="menu" value="info" />
<%@ include file="../common/header.jsp" %>
<div class="container">
	<div class="row mb-3">
		<div class="col-3"">
			<div id="side-menu">
				<li><a href="/user/info">내 정보 조회/수정</a></li>
				<li><a href="/user/reservation">내 예약 조회</a></li>
				<li><a href="/user/membership" style="color:white" id="current-page">내 회원권 조회</a></li>
				<li><a href="/user/attendance">내 출석 조회</a></li>
				<li><a href="/user/delete">회원 탈퇴</a></li>
			</div>
		</div>
		<div class="col-9">
			<div class="row mb-3">
				<div class="col">
					<div class="box">
						<sec:authorize access="isAuthenticated()">
							<strong><sec:authentication property="principal.nickname"/></strong> 님의 회원권 내역입니다.
						</sec:authorize>
					</div>
					<table class="table table-bordered" id="table-membership">
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
						<tbody>
							<c:choose>
								<c:when test="${empty membership }">
									<tr>
										<td colspan="12" class="text-center">회원권이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="membership" items="${membership }">
										<tr>
											<td class="text-center">${membership.no }</td>
											<td class="text-center">${membership.period } 개월</td>
											<td class="text-center"><fmt:formatDate value="${membership.startDate }" pattern="yyyy-MM-dd" /></td>
											<td class="text-center"><fmt:formatDate value="${membership.endDate }" pattern="yyyy-MM-dd" /></td>
											<td class="text-center"><fmt:formatDate value="${membership.createdDate }" pattern="yyyy-MM-dd" /></td>
											<td class="text-center">${membership.totalPaymentPrice } 원</td>
											<td class="text-center"><fmt:formatDate value="${membership.paymentCompletedDate }" pattern="yyyy-MM-dd" /></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>