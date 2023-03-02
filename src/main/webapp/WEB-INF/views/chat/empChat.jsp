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
<link rel="stylesheet" href="/resources/css/chat.css">
<title>애플리케이션</title>
</head>
<body class="pt-5">
<%@ include file="../common/header.jsp" %>
<div class="container">
	<div class="row" id="box-chat">
		<div class="row">
			<div class="col-12 text-center">
				<h1><strong>고객 응대 페이지</strong></h1>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="card" id="card-chat">
					<div class="card-header">상담내용</div>
					<div class="card-body" style="height: 500px; overflow-y:scroll;"></div>
					<div class='card-footer'>
						<div class="row">
							<div class="col-10">
								<input type="text" class="form-control" name="message"/>
							</div>
							<div class="col-2"><button class="btn btn-secondary">전송</button></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript">
$(function() {
	// 웹소켓 객체를 저장하는 변수
	let ws = null;
	// 채팅방 번호를 저장하는 변수
	let roomId = null;
	// 현재 상담중인 직원아이디가 저장되는 변수
	let employeeId = '<sec:authentication property="principal.id" />';
	// 로그인한 사용자아이디가 저장되는 변수
	let customerId = null;
	
	// 웹소켓 연결요청을 보내는 메소드
	function connect() {
		// 웹소켓 객체를 생성하고, 지정된 URI로 웹소켓 연결 요청
		ws = new SockJS("/chat");
		// 웹소켓으로 서버로부터 메시지를 수신하면 실행된다.
		ws.onmessage = function(message) {
			// 웹소켓으로 받은 데이터를 JSON 형식으로 파싱 (JSON 문자열을 자바스크립트 객체로 변환)
			const data = JSON.parse(message.data);
			if (data.cmd == "chat-open-success") {
				roomId = data.roomId;
				customerId = data.customerId;
				appendChatMessage(data.text, 'float-start', 'alert-danger', 'text-start');
			} else if (data.cmd == 'chat-message') {
				appendChatMessage(data.text, 'float-start', 'alert-success', 'text-start');
			} else if (data.cmd == 'chat-error'){
				appendChatMessage(data.text, 'float-start', 'alert-danger', 'text-start');
			}
		}
	}
	// 웹소켓 연결 요청 
	connect();
	
	// 웹소켓 연결 해제
	function disconnect() {
		if (ws != null){
			ws.clos();
		}
	}
	
	// 웹소켓으로 상담메시지 전달
	function chat() {
		const inputMessage = $(":input[name='message']").val();
		
		if (inputMessage) {
			const message = {
					cmd: 'chat-message',
					roomId: roomId,
					customerId: customerId,
					employeeId: employeeId,
					senderType: "관리자",
					text: inputMessage
			}
			send(message);
			appendChatMessage(inputMessage, 'float-end', 'alert-warning', 'text-end');
			$(":input[name='message']").val("");
		}
	}
	
	function send(message) {
		ws.send(JSON.stringify(message));
	}
	
	function appendChatMessage(message, floating, style, align){
		const content = `
			<div class="w-75 \${floating}">
				<div class="alert \${style} \${align}">
					\${message}
				</div>
			</div>
		`;
		$("#card-chat .card-body").append(content);
	}
	
	$("#card-chat .card-footer button").click(function(){
		chat();
	});
	
	$(":input[name='message']").keydown(function(event){
		if (event.which == 13) {
			chat();
		}
	})
	
})
</script>
</body>
</html>