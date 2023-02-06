<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<style type="text/css">
	#personnel {
		background-color: #353535
	}
	
	.perssonnel-number{
		color: white;
		top: 2px;
		
	}
	table{
		width: 100%;
		border-collapse: collapse;
	}
	
	th,td {
	 border: 1px solid lightgray;
     text-align: center;
	}
 	
	th {
		background-color: #999999;
		color: black;
	}


</style>
<title>애플리케이션</title>
</head>
<body>
<div class="container">
   <div class= "row mb-4 pt-5">
   		<div class="col-12">
   			<a class="btn btn-secondary" href="list"><i class="bi bi-list-columns-reverse"></i> 출석리스트</a></button>
   			<a class="btn btn-secondary" href="day"><i class="bi bi-calendar3"></i>일별출석리스트</a>
   			<a class="btn btn-secondary" href="calendar"><i class="bi bi-calendar-week"></i>출석달력</a>
   		</div>
   </div>
   
   <div class= "row mb-2">
   		<div class="col">
   			<button type="button" class="btn btn-secondary btn-sm">선택해제</button>
   			<input class="form-control form-control-sm d-inline-block border-secondary" type="date" value="2023-02-03" style="width: 120px;">
   			<div class="form-check form-check-inline ms-2">
		   		<input class="form-check-input border-dark" type="checkbox" value="행체크" id="flexCheckDefault">
		   		<label class="form-check-label" >회원권</label>
   			</div>
   		</div>
   		<div class="col-6">
   			<select class="form-select form-select-sm d-inline-block border-secondary" name="날짜"  style="width:130px;">
   				<option value="">프로그램명</option>
   				<option value="">크로스핏</option>
   				<option value="">요가</option>
   				<option value="">스피닝</option>
   				<option value="">줌바</option>
   			</select>
   			
   			<select  class="form-select form-select-sm d-inline-block border-secondary" name="날짜"  style="width:130px;" >
   				<option value="">선택하세요</option>
   				<option value="">회원이름</option>
   				<option value="">프로그램명</option>
   				<option value="">회원번호</option>
   				<option value="">휴대폰</option>
   			</select>
   			<input class="form-control form-control-sm d-inline-block border-secondary" name="keyword" style="width:150px;">
   			<button type="button" class="btn btn-secondary btn-sm" >검색</button>
   		</div>
   		<div class="col text-end">
   			<button type="button" class="btn btn-success btn-sm">출석체크</button>
			<button type="button" class="btn btn-warning btn-sm">수정</button>
			<button type="button" class="btn btn-danger btn-sm">삭제</button>		
   			
   		</div>
   			
   			
   </div>
   
   <div class= "row">
   		<div class="col-12"  >
   			<table >
   				<colgroup>
   					<col width="15%">
   					<col width="10%">
   					<col width="10%">
   					<col width="10%">
   					<col width="10%">
   					<col width="15%">
   					<col width="15%">
   				</colgroup>
   				<thead>
   					<tr>
   						<th class="text-start"><input class="form-check-input ms-2 me-3" type="checkbox" value="행체크" ><span>회원번호</span></th>
   						<th>회원이름</th>
   						<th>성별</th>
   						<th>회원권(헬스)</th>
   						<th>프로그램명</th>
   						<th>휴대폰</th>
   						<th>이메일</th>
   						<th>등록일자</th>
   					</tr>
   				</thead>
   				<tbody>
   					<tr>
   						<td class="text-start"><input class="form-check-input ms-2 me-3" type="checkbox" value="행체크" id="flexCheckDefault"><span>23010100001</span></td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   					<tr>
   						<td class="text-start"><input class="form-check-input ms-2 me-3" type="checkbox" value="행체크" id="flexCheckDefault"><span>23010100001</span></td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   					<tr>
   						<td class="text-start"><input class="form-check-input ms-2 me-3" type="checkbox" value="행체크" id="flexCheckDefault"><span>23010100001</span></td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   					<tr>
   						<td class="text-start"><input class="form-check-input ms-2 me-3" type="checkbox" value="행체크" id="flexCheckDefault"><span>23010100001</span></td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   					<tr>
   						<td class="text-start"><input class="form-check-input ms-2 me-3" type="checkbox" value="행체크" id="flexCheckDefault"><span>23010100001</span></td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   					<tr>
   						<td class="text-start"><input class="form-check-input ms-2 me-3" type="checkbox" value="행체크" id="flexCheckDefault"><span>23010100001</span></td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   						<tr>
   						<td> <input class="form-check-input" type="checkbox" value="행체크" id="flexCheckDefault">23010100001</td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   						<tr>
   						<td> <input class="form-check-input" type="checkbox" value="행체크" id="flexCheckDefault">23010100001</td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   						<tr>
   						<td> <input class="form-check-input" type="checkbox" value="행체크" id="flexCheckDefault">23010100001</td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   					</tr>
   						<tr>
   						<td> <input class="form-check-input" type="checkbox" value="행체크" id="flexCheckDefault">23010100001</td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   					</tr>
   						<tr>
   						<td> <input class="form-check-input" type="checkbox" value="행체크" id="flexCheckDefault">23010100001</td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   					</tr>
   						<tr>
   						<td> <input class="form-check-input" type="checkbox" value="행체크" id="flexCheckDefault">23010100001</td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   					</tr>
   						<tr>
   						<td> <input class="form-check-input" type="checkbox" value="행체크" id="flexCheckDefault">23010100001</td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   					</tr>
   						<tr>
   						<td> <input class="form-check-input" type="checkbox" value="행체크" id="flexCheckDefault">23010100001</td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   					</tr>
   						<tr>
   						<td> <input class="form-check-input" type="checkbox" value="행체크" id="flexCheckDefault">23010100001</td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   					</tr>
   						<tr>
   						<td> <input class="form-check-input" type="checkbox" value="행체크" id="flexCheckDefault">23010100001</td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   					</tr>
   						<tr>
   						<td> <input class="form-check-input" type="checkbox" value="행체크" id="flexCheckDefault">23010100001</td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   					</tr>
   						<tr>
   						<td> <input class="form-check-input" type="checkbox" value="행체크" id="flexCheckDefault">23010100001</td>
   						<td>강감찬</td>
   						<td>남</td>
   						<td>헬스</td>
   						<td>크로스핏</td>
   						<td>010-1111-1111</td>
   						<td>kang@gmail.com</td>
   						<td>2023-01-01</td>
   					</tr>
   					
   				</tbody>
   			</table>
   			<nav>
   				<ul class="pagination pagination-sm justify-content-center">
   					<li class="page-item"><a class="page-link">이전</a></li>
   					<li class="page-item"><a class="page-link">1</a></li>
   					<li class="page-item"><a class="page-link">다음</a></li>
   				</ul>
   			</nav>
   		</div>
   </div>
   
   <div class= "row" id="personnel">
   		<div class="col-12 " id="personnel">
   			<p class="perssonnel-number">인원 00명</p>
   		</div>
   </div>
   
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>

</html>