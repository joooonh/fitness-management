<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/resources/css/common.css">
<title>애플리케이션</title>
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
			<div class="row border">
				<!--------------------------- (좌) 회원 목록 ------------------------------>
				<div class="col-5 border">
					<div class="row mb-3">
						<div class="col-4">
							<input type="text" class="form-control" name="keyword" placeholder="회원명 검색">
						</div>
						<div class="col">
							<button type="button" class="btn btn-xs btn-dark">검색</button>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-2">
							<button type="button" class="btn btn-xs btn-dark">등록</button>
						</div>
						<div class="col">
							<button type="button" class="btn btn-xs btn-secondary">삭제</button>
						</div>
					</div>
					<table class="table table-sm border" id="table-member-list">
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
											<td class="text-center"><input type="checkbox" /></td>
											<td class="text-center">${user.no }</td>
											<td class="text-center"><a href="" class="text-decoration-none text-dark" data-user-id="${user.id }" >${user.name }</a></td>
											<td class="text-center">${user.gender }</td>
											<td class="text-center"><fmt:formatDate value="${user.birth }" pattern="yyyy-MM-dd" /></td>
											<td class="text-center">${user.tel }</td>
											<td class="text-center"></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div class="row">
						<h5>총 ${totalRows }명</h5>
					</div>
				</div>
				<!--------------------------- (우) 회원 정보 ------------------------------>
				<div class="col-7 border">
					<div class="row border">
						<div class="col-3">
							<div>
								<img id="profile-img" src="/resources/images/default.png" width="150" height="150" class="border inline-block align-text-center">
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
										<td id="cell-user-address"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row border">
					</div>
					<div class="row border">
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
	
	// 회원 상세정보 - ajax
	$("#table-member-list").on('click', 'a', function(event){
		
		event.preventDefault();
		
		let userId = $(this).attr("data-user-id");
		
		$.ajax({
			type: "GET",
			url: "/emp/userDetail",
			data: {userId:userId},
			dataType: "json",
			success: function(map){
				
				let user = map.user;
				let membershipList = map.membershipList;
				
				// 회원 상세정보 조회 
				$("#profile-img").attr("src", "/resources/images/profile/" + user.photo);
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
				let content = ""; 	// 이건 왜 안되지?
				
				for(let index in membershipList){
					content += "<tr>";
					content += "	<td class='text-center'>" + membershipList[index].no + "</td>";
					content += "	<td class='text-center'>" + membershipList[index].period + " 개월" + "</td>";
					content += "	<td class='text-center'>" + membershipList[index].startDate + "</td>";
					content += "	<td class='text-center'>" + membershipList[index].endDate + "</td>";
					content += "	<td class='text-center'>" + membershipList[index].createdDate + "</td>";
					content += "	<td class='text-center'>" + membershipList[index].totalPaymentPrice + " 원" + "</td>";
					content += "	<td class='text-center'>" + membershipList[index].paymentCompletedDate + "</td>";
					content += "</tr>";
				}
				$("#tbody-membership").append(content);
					
			}
		})
	})
	
})
</script>
</body>
</html>