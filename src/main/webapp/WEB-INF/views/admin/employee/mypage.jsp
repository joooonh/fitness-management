<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
					<h1>내정보</h1>
				</div>
			</div>
			
			<div class="row">
				<div class="col-4">
					<div class="profile">
						<img src="../../../resources/images/${employee.photo }" class="rounded-circle" alt="직원 프로필 사진" style="width:100%">
					</div>
				</div>
				
				<div class="col-8">
					<table class="table table-bordered">
						<colgroup>
							<col width="25%">
							<col width="*">
						</colgroup>
						 <tr>
						 	<th class="table-secondary">이름</th>
						 	<td class="ps-3">${employee.name }</td>
						 </tr>
						 <tr>
						 	<th class="table-secondary">아이디</th>
						 	<td class="ps-3">${employee.id }</td>
						 </tr>
						 <tr>
						 	<th class="table-secondary">전화번호</th>
						 	<td class="ps-3">${employee.tel }</td>
						 </tr>
						 <tr>
						 	<th class="table-secondary">이메일</th>
						 	<td class="ps-3">${employee.email }</td>
						 </tr>
						 <tr>
						 	<th class="table-secondary">우편번호</th>
						 	<td class="ps-3">${employee.zipcode }</td>
						 </tr>
						 <tr>
						 	<th class="table-secondary">주소</th>
						 	<td class="ps-3">${employee.basicAddress }</td>
						 </tr>
						 <tr>
						 	<th class="table-secondary">상세주소</th>
						 	<td class="ps-3">${employee.detailAddress }</td>
						 </tr>
						 <tr>
						 	<th class="table-secondary">등록일</th>
						 	<td class="ps-3"><fmt:formatDate value="${employee.createdDate }" pattern="yyyy-MM-dd"/> </td>
						 </tr>
						 <tr>
						 	<th class="table-secondary">재직상태</th>
						 	<td class="ps-3">${employee.status }</td>
						 </tr>
						 <tr>
						 	<th class="table-secondary">권한</th>
						 	<td class="ps-3">
						 		<c:forEach var="role" items="${employee.employeeRole }">
						 			<c:choose>
						 				<c:when test="${role.roleName eq 'ROLE_ADMIN' }"><span class="badge text-bg-primary py-1">관리자</span> </c:when>
						 				<c:when test="${role.roleName eq 'ROLE_EMP' }"><span class="badge text-bg-success py-1">강사</span> </c:when>
						 				<c:when test="${role.roleName eq 'ROLE_USER' }"><span class="badge text-bg-warning py-1">유저</span> </c:when>
						 			</c:choose>
						 		</c:forEach>
						 	</td>
						 </tr>
					</table>
					
					<div class="text-end">
						<a href="modify?empId=${employee.id }" class="btn btn-primary">수정</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>