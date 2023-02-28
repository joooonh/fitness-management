<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/background.css">
<link rel="stylesheet" href="/resources/css/login-form.css">
<title>애플리케이션</title>
</head>
<body class="pt-5">
<c:set var="menu" value="login" />
<%@ include file="../common/header.jsp" %>
<div class="container">
   <div class="row" id="row">
   		<div class="col-12">
   			<form class="form" id="form-login" method="post" action="/login">
   			<!-- csrf 토큰값을 히든필드로 추가한다. -->
			<sec:csrfInput />
			<!-- userType을 히든필드로 추가한다.  -->
			<input type="hidden" name="userType" value="사용자" />
   				<div class="row mb-3">
   					<div  id="login-head">
   						<img src="/resources/images/logo.svg" alt="Logo" width="40" height="27" class="text-black me-3">
   						<strong>중앙피트니스</strong>
   					</div>
   				</div>
   				<c:if test="${param.error eq 'fail' }">
   					<div class="alert alert-danger">
	   					<strong>로그인 실패</strong> 아이디 혹은 비밀번호가 유효하지 않습니다.
   					</div>
   				</c:if>
   				<div class="row mb-3">
					<div>
						<input type="text" class="form-control" name="id" placeholder="아이디" value="shin" />
					</div>
				</div>
				<div class="row mb-3">
					<div>
						<input type="password" class="form-control" name="password" placeholder="비밀번호" value="Zxcv1234!" />
					</div>
				</div>
			    <div class="row mb-3 border">
					<button type="submit" class="btn btn-dark" >로그인</button>
				</div>
			    <div class="row mb-3 border">
			    	<a id="btn-kakao-login" href="">
	  					<img src="/resources/images/kakao.png" alt="카카오계정 로그인" style="width: 100%; hetight: 100%" />
					</a>
				</div>
			    <div class="row mb-3">
					<button type="button" class="btn btn-secondary" onclick="location.href='/user/register'" >회원가입</button>
				</div>
			</form>
			<!-- 카카오 로그인 폼  -->
			<form id="form-kakao-login" method="post" action="/login">
	   			<input type="hidden" name="name"/>
	   			<input type="hidden" name="email"/>
	   			<input type="hidden" name="photo"/>
	   		</form>
		</div>
   </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	
	// 카카오 로그인 
	$("#btn-kakao-login").click(function(event){
		event.preventDefault();
		
		// 카카오 로그인 서비스 초기화 
		Kakao.init('87a85d046c0b17485040c5ec4b0afaca');
		// 로그인 서비스 실행
		Kakao.Auth.login({
            success: function(response) {
                console.log(response); // 로그인 성공하면 받아오는 데이터
                
                Kakao.API.request({ // 사용자 정보 가져오기 
                    url: '/v2/user/me',
                    success: function(response){
                    	// 사용자 정보를 가져와서 폼에 추가
                    	const account = response.kakao_account;
                    	
                    	$("#form-kakao-login input[name=name]").val(account.profile.nickname);
                    	$("#form-kakao-login input[name=email]").val(account.email);
                    	$("#form-kakao-login input[name=photo]").val(account.profile.photo);
                    	$("#form-kakao-login").trigger("submit");
                    	
	                	//location.href='/user/home'; //리다이렉트 되는 코드
                    },
		            fail: function(error) {
		                console.log(error);
		            },
                });
            },
            fail: function(error){
            	console.log(error);
            },
        });
	})
	function kakaoLogin(){
	}
	// 카카오로그아웃  
	function kakaoLogout() {
	    if (Kakao.Auth.getAccessToken()) {
	      Kakao.API.request({
	        url: '/v1/user/unlink',
	        success: function (response) {
	        	console.log(response)
	        },
	        fail: function (error) {
	          console.log(error)
	        },
	      })
	      Kakao.Auth.setAccessToken(undefined)
	    }
	 }
})

</script>
</body>
</html>