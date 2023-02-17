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
<style type="text/css">
	.tab-button{
		margin-bottom: 10px;
		align-content: center;
		list-style: none;
		float: left;
		padding: 10px 10px 10px 10px;
		cursor: pointer;
		text-align: center;
		width: 10%;
		background-color: #eee;
		font-weight: bold;
		border-radius: 20px 20px 20px 20px;
	}
	.active{
		background-color: black;
		color: white;
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
			<div class="row border ms-3">
				<!--------------------------- (좌) 회원 목록 ------------------------------>
				<div class="col-5 border">
					<div class="row mb-3">
						<div class="col">
							<input type="search" class="form-control" name="keyword" placeholder="회원명 검색">
						</div>
						<div class="col">
							<select name="programName" class="form-select d-inline">
								<option value="">프로그램명 선택</option>
							</select>
						</div>
						<div class="col">
							<button type="button" class="btn btn-xs btn-dark">검색</button>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col">
							<button type="button" class="btn btn-xs btn-dark">등록</button>
							<button type="button" class="btn btn-xs btn-secondary">삭제</button>
							<button type="button" class="btn btn-xs btn-success">sms 전송</button>
						</div>
						<div class="col text-end mt-3">
							<a href="" class="text-decoration-none text-dark">회원번호순</a>
							<a href="" class="text-decoration-none text-dark">이름순</a>
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
											<td class="text-center">
												<select name="programName" class="form-select form-select-sm">
													<option value="">프로그램명</option>
												</select>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div class="row">
						<span><p>총 ${totalRows }명</p></span>
					</div>
				</div>
				<!--------------------------- (우) 회원 정보 ------------------------------>
				<div class="col-7 border">
					<div class="row">
						<div class="col-3 pt-4" style="text-align:center" >
							<div >
								<img id="profile-img" src="/resources/images/default.png" width="170" height="170" class="border inline-block">
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
										<td id="cell-user-address" colspan="3"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="tab-list">
							<li class="tab-button active">회원권</li>
							<li class="tab-button">수업</li>
							<li class="tab-button">상담</li>
							<li class="tab-button">출석</li>
						</div>
					</div>
					<div class="row" id="tab-table-list">
						<!-- 회원권 탭 -->
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
						<!-- 수업 탭 -->
						<table class="table table-sm border" id="table-class" style="display:none;">
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
							<tbody id="tbody-class">
								<!-- ajax로 받은 수업 리스트 출력 -->
							</tbody>
						</table>
						<!-- 예약 탭 -->
						<table class="table table-sm border" id="table-consulting" style="display:none;">
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
									<th class="text-center">예약번호</th>
									<th class="text-center">상담사</th>
									<th class="text-center">상담프로그램</th>
									<th class="text-center">예약일자</th>
									<th class="text-center">접수일자</th>
									<th class="text-center">예약상태</th>
								</tr>
							</thead>
							<tbody id="tbody-consulting">
								<!-- ajax로 받은 상담 리스트 출력 -->
							</tbody>
						</table>
						<!-- 출석 탭 -->
						<table class="table table-sm border" id="table-attendance" style="display:none;">
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
				let classList = map.classRegList;
				let consultingList = map.consultingList;
				
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
				let membership = ""; 	
				if(membershipList.length > 0) {
					for(let index in membershipList){
						membership += "<tr>";
						membership += "	<td class='text-center'>" + membershipList[index].no + "</td>";
						membership += "	<td class='text-center'>" + membershipList[index].period + " 개월" + "</td>";
						membership += "	<td class='text-center'>" + membershipList[index].startDate + "</td>";
						membership += "	<td class='text-center'>" + membershipList[index].endDate + "</td>";
						membership += "	<td class='text-center'>" + membershipList[index].createdDate + "</td>";
						membership += "	<td class='text-center'>" + membershipList[index].totalPaymentPrice + " 원 </td>";
						membership += "	<td class='text-center'>" + membershipList[index].paymentCompletedDate + "</td>";
						membership += "</tr>";
					}
				} else {
					membership += "<tr>";
					membership += "	<td colspan='12' class='text-center'>회원권이 없습니다.</td>"
					membership += "</tr>";
				}
				
				$("#tbody-membership").append(membership);
					
				// 수업 조회
				$("#tbody-class").empty();
				let classReg = "";
				if(classList.length > 0){
					for(let index in classList){
						classReg += "<tr>";
						classReg += "	<td class='text-center'>" + classList[index].classRegNo + "</td>";
						classReg += "	<td class='text-center'>" + classList[index].programCategoryName + "</td>";
						classReg += "	<td class='text-center'>" + classList[index].programName + "</td>";
						classReg += "	<td class='text-center'>" + classList[index].empName + "</td>";
						classReg += "	<td class='text-center'>" + classList[index].openDays + "</td>";
						classReg += "	<td class='text-center'>" + classList[index].startHour + " ~ " + classList[index].endHour + "</td>";
						classReg += "	<td class='text-center'>" + classList[index].totalPaymentPrice + " 원 </td>";
						classReg += "	<td class='text-center'>" + classList[index].paymentCompletedDate + "</td>";
						classReg += "</tr>";
					}
				} else {
					classReg += "<tr>";
					classReg += "	<td colspan='12' class='text-center'>수업신청 내역이 존재하지 않습니다.</td>"
					classReg += "</tr>";
				}
				$("#tbody-class").append(classReg);
				
				// 상담 조회 
				$("#tbody-consulting").empty();
				let consulting = "";
				if(consultingList){
					for(let index in consultingList){
						consulting += "<tr>";
						consulting += "	<td class='text-center'>" + consultingList[index].no + "</td>";
						consulting += "	<td class='text-center'>" + consultingList[index].empName + "</td>";
						consulting += "	<td class='text-center'>" + consultingList[index].programName + "</td>";
						consulting += "	<td class='text-center'>" + consultingList[index].reservationDate + "</td>";
						consulting += "	<td class='text-center'>" + consultingList[index].createdDate + "</td>";
						consulting += "	<td class='text-center'>" + consultingList[index].status + "</td>";
						consulting += "</tr>";
					}
				} else {
					consulting += "<tr>";
					consulting += "	<td colspan='12' class='text-center'>상담내역이 존재하지 않습니다.</td>"
					consulting += "</tr>";
				}
				$("#tbody-consulting").append(consulting);
			}
		})
	})
	
	// 탭 클릭시 테이블 표시
	$(".tab-list li").click(function(){
		let index = $(this).index();
		
		$(".tab-list li").removeClass("active");
		$(".tab-list li").eq(index).addClass("active");
		$("#tab-table-list .table-sm").hide();
		$("#tab-table-list .table-sm").eq(index).show();
	})
	
})
</script>
</body>
</html>