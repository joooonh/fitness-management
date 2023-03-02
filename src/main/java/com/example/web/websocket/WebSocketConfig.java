package com.example.web.websocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer{

	@Autowired
	ChatSocketHandler chatSocketHandler;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		/*
		 * withSockJS() : SockJS 라이브러리를 이용해서 WebSocket을 지원하지 않는 브라우저에서도 WebSocket 프로토콜을 사용할 수 있도록 하는 기능
		 * setInterceptors(new HttpSessionHandshakeInterceptor() : WebSocket 연결을 설정할 때 HttpSession의 속성을 WebSocket 세션 속성으로 복사
		 * -> WebSocketSession에서 HttpSession에 저장된 데이터에 액세스할 수 있음
		 */
		registry.addHandler(chatSocketHandler, "/chat").withSockJS().setInterceptors(new HttpSessionHandshakeInterceptor());
	}

}
