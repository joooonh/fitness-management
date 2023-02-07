<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<nav class="navbar navbar-expand-md navbar-dark">		
	<button class="navbar-toggler ml-auto mb-2 bg-light" type="button" data-toggle="collapse" data-target="#sidebar">
	    <span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="sidebar">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-12 top-navbar ms-auto fixed-top py-2">
					<div class="row ">
						<div class="col-md-2 mt-2">
							<a href="/user/home" class="navbar-brand" >
								<img src="../../../resources/images/logo.svg" alt="Logo" width="40" height="27" class="d-inline-block align-text-top me-2 img-logo">중앙피트니스
							</a>
						</div>
						<div class="col-md-10">
							<ul class="navbar-nav justify-content-end">
								<span class="navbar-text"><strong class="text-white">홍길동</strong>님 환영합니다.</span>  
								<li class="nav-item dropdown">
						            <a href="#" class="nav-link dropdown-toggle" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						               로그인
						            </a>
						            <ul class="dropdown-menu">
						               <li><a class="dropdown-item" href="/user/login">이용자 로그인</a></li>
						               <li><hr class="dropdown-divider"></li>
						               <li><a class="dropdown-item" href="/admin/login">관리자 로그인</a></li>
						            </ul>
						         </li>
								<li class="nav-item"><a href="/user/register" class="nav-link">회원가입</a></li>
								<li class="nav-item dropdown">
						            <a href="#" class="nav-link dropdown-toggle" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						               마이페이지
						            </a>
						            <ul class="dropdown-menu">
						               <li><a class="dropdown-item" href="/admin/mypage?empId=hong">내정보 보기</a></li>
						               <li><hr class="dropdown-divider"></li>
						               <li><a class="dropdown-item" href="#">회원권 조회</a></li>
						               <li><a class="dropdown-item" href="#">예약 조회</a></li>
						               <li><a class="dropdown-item" href="#">출석 조회</a></li>
						               <li><a class="dropdown-item" href="#">회원 탈퇴</a></li>
						            </ul>
						         </li>
								<li class="nav-item"><a href="" class="nav-link">로그아웃</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</nav>

<form id="form-logout" method="post" action="logout">
	<sec:csrfInput />
</form>
<script>
	function logout(event){
		event.preventDefault();
		document.getElementById("form-logout").submit();
	}
</script>