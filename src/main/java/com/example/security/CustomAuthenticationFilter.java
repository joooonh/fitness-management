package com.example.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

public class CustomAuthenticationFilter extends UsernamePasswordAuthenticationFilter{

	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
			throws AuthenticationException {
		if(!request.getMethod().equals("POST")) {
			throw new AuthenticationServiceException("Authentication method not supported: " + request.getMethod());
		}
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String userType = request.getParameter("userType");
		
		System.out.println("id: " + id);
		System.out.println("password: " + password);
		System.out.println("userType: " + userType);
		
		CustomAuthenticationToken authenticationToken = new CustomAuthenticationToken(id, password);
		authenticationToken.setUserType(userType);
		
		return this.getAuthenticationManager().authenticate(authenticationToken);
	}
}
