<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/background.css">
<link rel="stylesheet" href="/resources/css/home.css">
<title>중앙피트니스</title>
</head>
<body class="pt-5">
<%@ include file="common/header.jsp" %>
<div class="container">
	<div class="row box">
		<div class="row mb-5">
			<h3 class="text-white typing1"></h3>
		</div>
		<div class="row mb-5">
			<h1 class="text-white typing2">&nbsp;</h1>
		</div>
		<div class="row">
			<sec:authorize access="isAuthenticated()">
				<div class="row border" id="box-register">
					<h2 class="mb-4" style="color:white;"><strong>프로그램 신청하기</strong></h2>
					<a class="btn btn-lg btn-outline-light" href="/user/classReg" style="width:200px; margin:0 auto;">프로그램 신청</a>
				</div>
				<div id="box-chat">
					<a href="/user/chat"><img src="/resources/images/chat.png" alt="chat" width="130" height="130" id="img-chat"></a>
				</div>
			</sec:authorize>
		</div>
	</div>
</div>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(() => {
		let $typing = $(".typing1").addClass("cursor");
		const letters = ["언제 어디서나 운동을 일상처럼", "Everywhere JA Fitness"];
		const speed = 100;
		let i = 0;

		const wait = (ms) => new Promise(res => setTimeout(res, ms));
		const changeLineBreak = (letter) => letter.map(text => text === "\n" ? "<br>" : text);

		const typing = async () => {
			const letter = changeLineBreak(letters[i].split(""));
			while (letter.length) {
				await wait(speed);
				$typing.text($typing.text() + letter.shift());
				if ($typing.text().length === letters[i].length && i !== letters.length - 1) {
					await wait(800);
					i++;
					$typing.removeClass("cursor");
					$typing = $(".typing2").addClass("cursor");
					typing();
				}
			}
		}

		typing();
	});
</script>
</body>
</html>