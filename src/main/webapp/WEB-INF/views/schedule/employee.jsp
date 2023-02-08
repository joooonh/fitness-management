<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="../resources/css/common.css">
<style>
	#title {
	border-bottom: solid 3px grey;
	}
	#search {
	padding-left: 1em;
	}
	.table {
	text-align: center;
	}
</style>
<title>중앙피트니스</title>
</head>
<body>
<c:set var="menu" value="employeeschedule">
<!------------------------------------ 헤더 navbar 영역 ---------------------------------------->
<%@ include file="../common/header.jsp" %>
<div class="container-fluid mt-4">
	<div class="row">
		<div class="col-md-2 sidebar">
			<!---------------------------------- 사이드 바 영역  ----------------------------------------->
			<%@ include file="../common/sidebar.jsp" %>
		</div>
		<div class="col-md-10 ps-4 pt-5">
			<!--------------------------------- Content 영역 ------------------------------------------->
   	   	<div id="title">
				<p class="fs-2"><i class="bi bi-calendar3"></i> 강사일정관리</p>
		</div>
			<p>
			<div class="btn-group">
					  <button type="button" class="btn btn-sm dropdown-toggle border border-dark" data-bs-toggle="dropdown" aria-expanded="false">강사명</button>
					  <ul class="dropdown-menu">
					    <li><a class="dropdown-item">문지훈</a></li>
					    <li><a class="dropdown-item">이순신</a></li>
					    <li><a class="dropdown-item">레이나</a></li>
					    <li><a class="dropdown-item">류관순</a></li>
					    <li><hr class="dropdown-divider"></li>
					    <li><a class="dropdown-item" href="#">Separated link</a></li>
					  </ul>
			 <div id='search'>
			 	<button type="button" class="btn btn-danger btn-sm">검색</button>
			 </div>
			</div>
			</p>
			<p>
 		<div class="table" class="col-6">
			<table class="table table-bordered">
				<colgroup>
					<col width="5%">
					<col width="15%">
					<col width="5%">
					<col width="15%">
				</colgroup>
				<tbody>
					<tr>
						<th>강사명</th>
						<td>${employee.name }</td>
						<th>프로그램명</th>
						<td></td>
					</tr>
				</tbody>
			</table>
	</div>
		</p>
			 <div class="calendar">
				 <%@ include file="calendar.jsp" %> 
			 </div>
	 
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>