package com.example.security;

import java.util.Map;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.slf4j.Slf4j;

// 실제 인증 처리 (filter -> manager를 통해 인증 전의 Authentication 객체를 받아서 인증이 완료된 객체를 반환) 
@Slf4j
public class CustomAuthenticationProvider implements AuthenticationProvider {

	// SecurityConfig에서 map에 담은 UserDetilasService들 받기위함 -> {"user", CustomUserDetailsService, "employee", CustomEmployeeDetailsService}
	private Map<String, UserDetailsService> detailsServiceMap;
	private PasswordEncoder passwordEncoder;
	
	public CustomAuthenticationProvider(Map<String, UserDetailsService> detailsServiceMap, PasswordEncoder passwordEncoder) {
		this.detailsServiceMap = detailsServiceMap;
		this.passwordEncoder = passwordEncoder;
	}

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		// 전달받은 인증 전의 Authentication 객체의 정보를 꺼내기 위해 Token으로 형변환 
		CustomAuthenticationToken customAuthentication = (CustomAuthenticationToken) authentication;
		// 로그인 창에서 입력한 아이디, 비밀번호, 유저타입 추출
		String username = customAuthentication.getName();
		String password = customAuthentication.getCredentials().toString();
		String userType = customAuthentication.getUserType();
		
		// userType에 해당하는 CustomXXXDetailsService 객체를 Map 객체에서 꺼낸다. 
		UserDetailsService detailsService = detailsServiceMap.get(userType);
		
		// userType에 해당하는 CustomXXXDetailsService 객체를 이용해서 인증에 필요한 사용자정보(UserDetails객체)를 획득한다.
		UserDetails userDetails = detailsService.loadUserByUsername(username);
		
		// 인증 전의 비밀번호와 UserDetails의 암호화된 비밀번호를 비교해서 사용자 인증을 수행한다.
		if(!passwordEncoder.matches(password, userDetails.getPassword())) {
			throw new BadCredentialsException("비밀번호가 일치하지 않습니다.");
		}
		
		// 인증이 완료되면 새로운 Authentication 객체 생성해서 사용자정보, 비밀번호, 권한정보를 담는다
		customAuthentication = new CustomAuthenticationToken(userDetails, userDetails.getPassword(), userDetails.getAuthorities());
		// 사용자 타입을 담는다
		customAuthentication.setUserType(userType);
		
		// 반환된 Authentication 객체는 SecurityContext 에 저장되고, SecurityContext 는 HttpSession에 저장된다.
		return customAuthentication;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return CustomAuthenticationToken.class.isAssignableFrom(authentication);
	}

}
