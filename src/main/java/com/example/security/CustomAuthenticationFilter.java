package com.example.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import lombok.extern.slf4j.Slf4j;

// 로그인 요청 정보를 받아서 정보 추출 -> 토큰 생성 -> 토큰으로 Authentication 객체 생성 -> Manager로 넘김
@Slf4j
public class CustomAuthenticationFilter extends UsernamePasswordAuthenticationFilter{

	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
			throws AuthenticationException {
		// 로그인 요청이 POSt 메소드가 아닌 경우 예외
		if(!request.getMethod().equals("POST")) {
			throw new AuthenticationServiceException("Authentication method not supported: " + request.getMethod());
		}
		// POST 메소드 요청의 request 에서 아이디, 비밀번호, 사용자타입을 추출
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String userType = request.getParameter("userType");
		
		// 넘겨받은 아이디, 비밀번호, 사용자타입으로 CustomAuthenticationToken 객체 생성 
		CustomAuthenticationToken authenticationToken = new CustomAuthenticationToken(id, password);
		authenticationToken.setUserType(userType);
		// 인증 매니저에게 생성한 토큰을 전달하여 인증이 성공하면 인증된 Authentication 객체를 받아서 반환 -> SecurityContext에 저장
		return this.getAuthenticationManager().authenticate(authenticationToken);
	}
}
