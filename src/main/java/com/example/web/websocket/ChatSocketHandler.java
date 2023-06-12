package com.example.web.websocket;

import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.example.security.CustomAuthenticationToken;
import com.example.security.vo.CustomUserDetails;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ChatSocketHandler extends TextWebSocketHandler {

	// 자바 객체 <-> JSON 데이터
	private ObjectMapper objectMapper = new ObjectMapper();
	// 채팅룸(상담중인 직원, 고객 포함)을 관리하는 맵
	private Map<String, Map<String, WebSocketSession>> chatRooms = Collections.synchronizedMap(new HashMap<>());
	// 상담대기중인 직원들을 관리하는 맵
	private Map<String, WebSocketSession> waitingEmployeeSessions = Collections.synchronizedMap(new HashMap<>());
	// 상담페이지에 접속한 고객들을 관리하는 맵
	private Map<String, WebSocketSession> customerSessions = Collections.synchronizedMap(new HashMap<>());

	// 웹 소켓 연결이 성공적으로 완료되면 실행되는 메소드- 로그인한 사용자의 정보를 확인해서 적절한 맵에 세션 저장
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		// WebSocketSession에서 사용자 정보 조회
		SecurityContextImpl securityContext = (SecurityContextImpl) session.getAttributes().get("SPRING_SECURITY_CONTEXT");
		CustomAuthenticationToken authenticationToken = (CustomAuthenticationToken) securityContext.getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authenticationToken.getPrincipal();
		String loginId = userDetails.getUsername();
		String loginType = authenticationToken.getUserType();
		
		if ("사용자".equals(loginType)) {
			customerSessions.put(loginId, session);
		} else if ("관리자".equals(loginType)) {
			waitingEmployeeSessions.put(loginId, session);
		}
	}

	// 클라이언트로부터 웹소켓으로 메시지를 수신하면 실행되는 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// WebSocketSession으로부터 받은 JSON 형태의 TextMessage를 ChatMessage 객체로 변환
		// message.getPayload() : WebSocketSession 에서 받은 메시지 내용 반환
		ChatMessage chatMessage = objectMapper.readValue(message.getPayload(), ChatMessage.class);
		String cmd = chatMessage.getCmd();
		if ("chat-open".equals(cmd)) {
			openChatRoom(session, chatMessage);
		} else if ("chat-close".equals(cmd)) {
			closeChatRoom(session, chatMessage);
		} else if ("chat-message".equals(cmd)) {
			chatting(session, chatMessage);
		}
	}

	// 클라이언트와 웹 소켓 연결이 종료되면 실행되는 메소드 - 해당 세션 제거
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		removeWebSocketSession(session);
	}

	// 클라이언트와 웹 소켓을 통해서 메시지 교환 중 오류가 발생하면 실행되는 메소드 - 해당 세션 제거
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		removeWebSocketSession(session);
	}

	// cmd 상태가 "chat-open"일 때 실행되는 메소드 - 채팅방 생성
	private void openChatRoom(WebSocketSession session, ChatMessage chatMessage) throws Exception {
		String customerId = chatMessage.getCustomerId();

		// 대기중인 상담원이 없을 경우 메시지 전달
		if (waitingEmployeeSessions.isEmpty()) {
			ChatMessage responseMessage = new ChatMessage();
			responseMessage.setCmd("chat-error");
			responseMessage.setText("대기중인 상담원이 없습니다.");
			// session.sendMessage : WebSocketSession 객체를 통해 연결된 클라이언트에게 메시지 보내는 기능
			session.sendMessage(new TextMessage(objectMapper.writeValueAsBytes(responseMessage)));
		
		} else {
			
			// 대기중인 상담원이 있는 경우 새로운 채팅방 roomId 생성
			String uuid = UUID.randomUUID().toString();
			// waitingEmployeeSessions 맵에서 첫번째 키를 employeeId 변수에 할당
			String employeeId = waitingEmployeeSessions.keySet().stream().findFirst().get();
			WebSocketSession employeeSession = waitingEmployeeSessions.get(employeeId);

			// 상담원세션, 고객세션으로 채팅방 생성
			Map<String, WebSocketSession> chatRoom = new HashMap<>();
			chatRoom.put(customerId, session);
			chatRoom.put(employeeId, employeeSession);
			chatRooms.put(uuid, chatRoom);
			// 대기중인 상담원 목록에서 상담원 제거
			waitingEmployeeSessions.remove(customerId);

			// 생성된 채팅방에 대해 클라이언트에게 채팅방이 생성되었음을 알리는 메시지 전송
			ChatMessage responseMessage = new ChatMessage();
			responseMessage.setCmd("chat-open-success");
			responseMessage.setRoomId(uuid);
			responseMessage.setCustomerId(customerId);
			responseMessage.setEmployeeId(employeeId);
			responseMessage.setText("대기중인 상담직원과 연결되었습니다.");
			session.sendMessage(new TextMessage(objectMapper.writeValueAsBytes(responseMessage)));

			// 생성된 채팅방에 대해 대기중인 상담원에게도 채팅방이 생성되었음을 알리는 메시지 전송
			responseMessage.setText("대기중인 고객과 연결되었습니다.");
			employeeSession.sendMessage(new TextMessage(objectMapper.writeValueAsBytes(responseMessage)));
		}
	}

	// cmd 상태가 "chat-close"일 때 세션을 종료하고 채팅방 닫음
	private void closeChatRoom(WebSocketSession session, ChatMessage chatMessage) throws Exception {
		String roomId = chatMessage.getRoomId();
		String employeeId = chatMessage.getEmployeeId();
		// 해당 채팅방에 참여한 WebSocketSession 객체들을 얻어옴
		Map<String, WebSocketSession> chatRoom = chatRooms.get(roomId);
		// 해당 채팅방에서 상담했던 상담원의 WebSocketSession 객체를 waitingEmployeeSession에 다시 추가
		WebSocketSession employeeSession = chatRoom.get(employeeId);
		waitingEmployeeSessions.put(employeeId, employeeSession);
		chatRooms.remove(roomId);

		ChatMessage responseMessage = new ChatMessage();
		responseMessage.setCmd("chat-close-success");
		responseMessage.setText("상담이 종료되었습니다.");
		session.sendMessage(new TextMessage(objectMapper.writeValueAsBytes(responseMessage)));
		
		// 생성된 채팅방에 대해 대기중인 상담원에게도 채팅방이 생성되었음을 알리는 메시지 전송
		responseMessage.setText("상담이 종료되었습니다.");
		employeeSession.sendMessage(new TextMessage(objectMapper.writeValueAsBytes(responseMessage)));

		session.close();
	}

	// cmd 상태가 "chat-message"일 때 
	private void chatting(WebSocketSession session, ChatMessage chatMessage) throws Exception {
		String roomId = chatMessage.getRoomId();
		String customerId = chatMessage.getCustomerId();
		String employeeId = chatMessage.getEmployeeId();
		String senderType = chatMessage.getSenderType();

		Map<String, WebSocketSession> chatRoom = chatRooms.get(roomId);
		if ("사용자".equals(senderType)) {
			chatRoom.get(employeeId).sendMessage(new TextMessage(objectMapper.writeValueAsBytes(chatMessage)));
		} else if ("관리자".equals(senderType)) {
			chatRoom.get(customerId).sendMessage(new TextMessage(objectMapper.writeValueAsBytes(chatMessage)));
		}
	}

	// 세션 제거 
	private void removeWebSocketSession(WebSocketSession session) throws Exception {
		String loginId = (String) session.getAttributes().get("LOGIN_ID");
		String loginType = (String) session.getAttributes().get("LOGIN_TYPE");

		if ("사용자".equals(loginType)) {
			customerSessions.remove(loginId);
		} else if ("관리자".equals(loginType)) {
			waitingEmployeeSessions.remove(loginId);
		}
		destroyChatRoom(loginId);
	}

	// 로그인 아이디와 관련된 모든 채팅방 제거
	private void destroyChatRoom(String loginId) {
		// 모든 채팅방을 가져옴 (chatRooms 맵의 키(채팅방 번호)를 저장하는 Set 객체)
		Set<String> roomIdSet = chatRooms.keySet();
		// Iterator : 컬렉션에 저장된 요소들에 대해 반복작업 수행
		// .iterator() : Iterator 인터페이스를 구현핸 객체 반환. 이 객체로 Set 컬렉션의 요소들에 순서대로 접근
		Iterator<String> iterator = roomIdSet.iterator();
		// 모든 채팅방 순회
		while (iterator.hasNext()) {
			// 현재 처리중인 방 번호를 얻음
			String roomId = iterator.next();
			// 해당 방번호를 키로 갖는 map 객체에서 채팅을 종료한 사용자의 아이디를 갖고있는 WebSocketSession 객체를 찾음
			Map<String, WebSocketSession> chatRoom = chatRooms.get(roomId);
			// 채팅을 종료한 사용자의 아이디를 갖고 있는 WebSocketSession 객체가 존재하면 채팅방에서 그 객체 삭제
			if (chatRoom.containsKey(loginId)) {
				chatRoom.remove(loginId);
				chatRooms.remove(roomId);
			}
		}
	}

}
