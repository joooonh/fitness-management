<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/content.css">
<title>중앙피트니스</title>
 <style type="text/css">
 	.scroll {
	    height: 500px;
	 	overflow-y: auto;
    }
 </style>
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
					<span><h5 class="" ><i class="bi bi-pc-display-horizontal ms-2 me-3"></i>프로그램 분류</h5></span>
					<hr width="103%" color="gray">
				</div>
			</div>
			
			<div class="row">
				<div class="col-12">
					<div class="scroll">
						<table class="table align-middle">
							<thead>
								<tr>
									<th>분류</th>
									<th class="text-end"><button type="button" class="btn btn-outline-dark btn-sm add-category">추가</button></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="category" items="${categories }">
									<tr>
										<td>
											<input type="hidden" name="no" value="${category.no }" />
											<input type="text" class="form-control" name="name" value="${category.name }" /> 
										</td>
										<td class="text-end">
											<button type="button" class="btn btn-outline-primary btn-sm modify-category">수정</button> 
											<button type="button" class="btn btn-outline-danger btn-sm delete-category">삭제</button> 
										</td>
									</tr>
								</c:forEach>
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
	$(function() {
		$(".add-category").click(function() {
			let addTr = `
				<tr>
					<td>
						<input type="text" class="form-control" name="name" value="${category.name }" /> 
					</td>
					<td class="text-end">
						<button type="button" class="btn btn-outline-secondary btn-sm insert-category">등록</button> 
					</td>
				</tr>
			`;
			$("tbody").append(addTr);
		});
		// 수정버튼 클릭시 이벤트
		$(".modify-category").click(function() {
			let no = $(this).closest("tr").find("input[name=no]").val();
			let name = $(this).closest("tr").find("input[name=name]").val();
			location.href = "modify-category?no="+no+"&name="+name;
		});
		// 삭제버튼 클릭시 이벤트
		$(".delete-category").click(function() {
			let no = $(this).closest("tr").find("input[name=no]").val();
			let name = $(this).closest("tr").find("input[name=name]").val();
			location.href = "delete-category?no="+no+"&name="+name;
		});
		// 등록버튼 클릭시 이벤트
		$("table tbody").on('click', '.insert-category', function() {
			let name = $(this).closest("tr").find("input[name=name]").val();
			location.href = "insert-category?&name="+name;
		});
	})
</script>
</body>
</html>