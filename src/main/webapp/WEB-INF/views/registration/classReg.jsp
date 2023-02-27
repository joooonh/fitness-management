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
	.scroll-y{
		height: 450px;
		overflow-y: auto;
	}
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
						<h5><i class="bi bi-person-lines-fill ms-2 me-3"></i><strong>프로그램 신청현황</strong></h5>
						<hr width="103%" color="gray">
					</div>
				</div>
				<!-- 프로그램 목록 -->
				<div class="row">
					<div class="col-5">
						<div>
							<p class="badge bg-primary p-2">프로그램 목록</p>
						</div>
						<div class="scroll-y">
							<table id="programList" class="table table-hover">
								<colgroup>
									<col width="50%">
									<col width="25%">
									<col width="25%">
								</colgroup>
								<thead>
									<tr class="table-secondary">
										<th>프로그램이름</th>
										<th>분류</th>
										<th>강사이름</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="program" items="${programList }">
										<tr style="cursor:pointer;">
											<td data-program-no="${program.no }">${program.name }</td>
											<td>${program.categoryName }</td>
											<td>${program.employeeName }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<!-- 신청자 목록 -->
					<div class="col-7">
						<div>
							<p class="badge bg-primary p-2">신청자 목록</p>
						</div>
						<div class="scroll-y">
							<table id="userList" class="table table-hover">
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="25%">
									<col width="25%">
								</colgroup>
								<thead>
									<tr class="table-secondary">
										<th>신청자 이름</th>
										<th>신청자 연락처</th>
										<th>결재상태</th>
										<th>결재날짜</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	// 프로그램 목록 클릭시 신청자 목록이 나온다.
	$("#programList tbody").on('click', 'tr', function() {
		// 클릭한 프로그램의 프로그램번호를 가져온다.
		let no = $(this).children("td").attr("data-program-no");
		
		$.getJSON("userRequest", {programNo:no}, function(info) {
			$("#userList tbody").empty();
			
			let html = "";
			if (info.length === 0) {
				html += `
					<tr>
						<td colspan="4" class="text-center">신청자가 없습니다.</td>
					</tr>
				`;
				$("#userList tbody").append(html);
			}
			
			for (let i = 0; i < info.length; i++) { 
				let user = info[i];
				html = `
					<tr>
						<td>\${user.userName }</td>
						<td>\${user.userTel }</td>
						<td>\${user.paymentStatus == "Y" ? "결재완료" : "미결재" }</td>
						<td>\${user.completedDate }</td>
					</tr>
				`;
				$("#userList tbody").append(html);
			};
		});
	});
	
})
</script>
</body>
</html>