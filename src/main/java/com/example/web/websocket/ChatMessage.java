package com.example.web.websocket;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatMessage {

	// 메시지 형태 - 채팅 명령
	// chat-open : 상담연결 요청
	// chat-close : 상담종료 요청
	// chat-open-success : 상담연결 성공 응답
	// chat-close-success : 상담종료 성공 응답
	// chat-message : 상담 메시지 교환 요청 및 응답
	// chat-error : 에러 응답
	private String cmd;
	private String roomId;
	private String customerId;
	private String employeeId;
	private String senderType;
	private String text;
	
}
