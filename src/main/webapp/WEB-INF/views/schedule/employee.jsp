<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="../../resources/css/common.css">
<style>
	#title {
	border-bottom: solid 3px grey;
	}
	input {
	background-color: #dc143c;
	color: white;
	border: 0;
	}
	#title a {
  	text-decoration: none; /* 링크의 밑줄 제거 */
  	color: inherit; /* 링크의 색상 제거 */
	}
</style>
<title>중앙피트니스</title>
</head>
<body>
<c:set var="menu" value="employeeschedule"/>
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
					<p class="fs-2"><i class="bi bi-calendar3"></i><a href="employee"> 강사일정관리</a></p>
			</div>
				<p>
			<div>
		        <form method="get" action="employeesearch">
			        <select name="empId">
			        		<option selected disabled>강사명</option>
			        		<c:forEach var="employee" items="${employees }">
			               		<option value="${employee.id }">${employee.name }</option>
			        		</c:forEach>
			        </select>
		       	 <input type="submit" value="검색" />
		    	</form>
			</div>
			</p>
			<!-- calendar API 추가 -->
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