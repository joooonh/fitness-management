<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/common.css">
<title>애플리케이션</title>
<style type="text/css">
	#side-menu{
		margin-top: 100px;
		list-style: none;
		background-color: #eee;
		text-align: center;
		width: 250px;
		height: 710px;
		padding: 30px;
		border-radius: 40px 40px 40px 40px;
	}
	#side-menu a{
		font-size: large;
		font-weight: bold;
		text-decoration: none;
		display: block;
		color: black;
		line-height: 400%;
		border-radius: 40px 40px 40px 40px;
	}
	#side-menu a:hover{
		background-color: black;
		color: white;
	}
	#current-page{
		background-color: black;
	}
	.table{
		margin-top: 50px;
	}
	.tab-button{
		margin-top: 100px;
		margin-bottom: 30px;
		align-content: center;
		list-style: none;
		float: left;
		padding: 20px 20px 20px 20px;
		cursor: pointer;
		text-align: center;
		width: 50%;
		background-color: #eee;
		font-weight: bold;
		font-size: large;
		border-radius: 20px 20px 20px 20px;
	}
	.active{
		background-color: black;
		color: white;
	}
</style>
</head>
<body class="pt-5">
<c:set var="menu" value="info" />
<%@ include file="../common/header.jsp" %>
<div class="container">
	<div class="row mb-3">
		<div class="col-3">
			<div id="side-menu">
				<li><a href="/user/info">내 정보 조회/수정</a></li>
				<li><a href="/user/membership">내 회원권 조회</a></li>
				<li><a href="/user/reservation" style="color:white" id="current-page">내 예약 조회</a></li>
				<li><a href="/user/attendance">내 출석 조회</a></li>
				<li><a href="/user/delete">회원 탈퇴</a></li>
			</div>
		</div>
		<div class="col-9">
			<div class="row mb-3">
				<div class="col">
					<div class="tab-list">
						<li class="tab-button active">수업신청 내역</li>
						<li class="tab-button">상담문의 내역</li>
					</div>
					<!-- 수업 신청 내역 테이블 -->
					<table class="table table-bordered" id="table-class-registered">
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
						<tbody>
							<c:choose>
								<c:when test="${empty classRegList }" >
									<tr>
										<td colspan="12" class="text-center">수업신청 내역이 존재하지 않습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="classReg" items="${classRegList }" >
										<tr>
											<td class="text-center">${classReg.classRegNo }</td>
											<td class="text-center">${classReg.programCategoryName }</td>
											<td class="text-center">${classReg.programName }</td>
											<td class="text-center">${classReg.empName }</td>
											<td class="text-center">${classReg.openDays }</td>
											<td class="text-center">${classReg.startHour } ~ ${classReg.endHour }</td>
											<td class="text-center">${classReg.totalPaymentPrice } 원</td>
											<td class="text-center"><fmt:formatDate value="${classReg.paymentCompletedDate }" pattern="yyyy-MM-dd" /></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<!-- 예약 내역 테이블 -->
					<table class="table table-bordered" id="table-class-cs" style="display:none;">
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="10%">
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
						<tbody>
							<c:choose>
								<c:when test="${empty consultingList }" >
									<tr>
										<td colspan="12" class="text-center">상담내역이 존재하지 않습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="consulting" items="${consultingList }" >
										<tr class="align-middle">
											<td class="text-center">${consulting.no }</td>
											<td class="text-center">${consulting.empName }</td>
											<td class="text-center">${consulting.programName }</td>
											<td class="text-center"><fmt:formatDate value="${consulting.reservationDate }" pattern="yyyy-MM-dd" /></td>
											<td class="text-center"><fmt:formatDate value="${consulting.createdDate }" pattern="yyyy-MM-dd" /></td>
											<td>
												<c:choose>
													<c:when test="${consulting.status eq '예약완료' }">
														<p class="badge rounded-pill p-2 mt-2 ms-2 bg-success">${consulting.status }</p>
													</c:when> 
													<c:when test="${consulting.status eq '예약취소' }">
														<p class="badge rounded-pill p-2 mt-2 ms-2 bg-danger">${consulting.status }</p>
													</c:when> 
												</c:choose>
											</td>
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
<script type="text/javascript">
$(function(){
	
	$(".tab-list li").click(function(){
		let index = $(this).index();
		
		$(".tab-list li").removeClass("active");
		$(".tab-list li").eq(index).addClass("active");
		$(".table").hide();
		$(".table").eq(index).show();
		
	})

	
})
</script>
</body>
</html>