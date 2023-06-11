package com.example.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.example.security.service.CustomEmployeeDetailsService;
import com.example.security.service.CustomOAuth2UserService;
import com.example.security.service.CustomUserDetailsService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired
	PasswordEncoder passwordEncoder;
	@Autowired
	CustomUserDetailsService userDetailsService;
	@Autowired
	CustomEmployeeDetailsService employeeDetailsService;
	@Autowired
	CustomOAuth2UserService customOAuth2UserService;

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
			.csrf().disable()
			// 인가정책 설정
			.authorizeRequests()
			// 다음 페이지에 모두 접근 가능
			.antMatchers("/").permitAll()			
			.antMatchers("/user/register", "/user/registered").permitAll()
			.antMatchers("/user/login", "/emp/login").permitAll()
			.antMatchers("/user/deleted").permitAll()
			.antMatchers("/oauth2/**").permitAll()
			.antMatchers("/login/oauth2/**").permitAll()
			// 인증된 사람만 다음 기능 가능 
			.antMatchers("/user/**").authenticated()
			.antMatchers("/logout").authenticated()
			// 특정 권한을 가진 사람만 다음 페이지 접근 가능
			.antMatchers("/user/**").hasAnyRole("USER", "ADMIN")
			.antMatchers("/emp/**").hasAnyRole("EMP", "ADMIN")
			.antMatchers("/admin/**").hasAnyRole("ADMIN")
			.anyRequest().permitAll()
		.and()
			// 인증정책 설정
			.formLogin()								// Form 로그인
			.loginPage("/user/login")
			.usernameParameter("id")
			.loginProcessingUrl("/login")				// 로그인 처리를 요청하는 URI
		.and()
			// 로그아웃 정책 설정
			.logout()
			.logoutUrl("/logout")						// 로그아웃 처리를 요청하는 URI
			.logoutSuccessUrl("/")						// 로그아웃 성공 시 재요청할 URI
		.and()
			.addFilter(authenticationFilter())			// 커스텀한 필터 추가 (필터에서 인증 예외처리)
			.exceptionHandling()						// 예외처리 등록하기 위함
			.accessDeniedHandler(accessDeniedHandler())	// 인가 예외처리
		.and()
			.headers().frameOptions().disable()
		.and()
			.oauth2Login()								// OAuth2 로그인
			.loginPage("/user/login")
			.defaultSuccessUrl("/")
			.failureUrl("/user/login")
			.userInfoEndpoint()							// 로그인 성공 후 사용자정보 가져옴
			.userService(customOAuth2UserService);		// 가져온 사용자 정보를 처리할 때 사용
	}
	
	// 보안정책을 적용하지 않을 URI 설정 (정적 리소스)
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/resources/**", "/favicon.ico");
	}
	
	// 커스텀한 Provider를 AuthenticationManagerBuilder에 등록
	// -> 기본 시큐리티 로직이 아닌 내가 만든 인증로직을 바탕으로 동작
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.authenticationProvider(authenticationProvider());
	}
	
	// 커스텀한 Provider를 빈에 등록, 반환 -> 이 로직대로 동작
	@Bean
	public AuthenticationProvider authenticationProvider() {
		// 여기서 map에 담아서 CustomAuthenticationProvider에서 값 꺼내서 사용
		Map<String, UserDetailsService> map = new HashMap<>();
		map.put("사용자", userDetailsService);
		map.put("관리자", employeeDetailsService);
		
		return new CustomAuthenticationProvider(map, passwordEncoder);
	}
	
	@Bean
	public CustomAuthenticationFilter authenticationFilter() throws Exception {
		CustomAuthenticationFilter filter = new CustomAuthenticationFilter();		// 커스텀한 필터
		filter.setAuthenticationManager(authenticationManager());					// 필터에 authenticationManager 등록
		filter.setAuthenticationSuccessHandler(authenticationSuccessHandler());	// 필터에 커스텀한 로그인 성공 핸들러 등록
		filter.setAuthenticationFailureHandler(authenticationFailureHandler());	// 필터에 커스텀한 로그인 실패 핸들러 등록
		return filter;
	}
	
	@Bean
	public AuthenticationSuccessHandler authenticationSuccessHandler() {
		return new AuthenticationSuccessHandler() {
			
			@Override
			public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
					Authentication authentication) throws IOException, ServletException {
				CustomAuthenticationToken customAuthenticationToken = (CustomAuthenticationToken) authentication;
				
				String userType = customAuthenticationToken.getUserType();
				if("사용자".equals(userType)) {
					response.sendRedirect("/");
				} else if("관리자".equals(userType)) {
					response.sendRedirect("/emp/home");
				}
			}
		};
	}
	
	@Bean
	public AuthenticationFailureHandler authenticationFailureHandler() {
		return new AuthenticationFailureHandler() {
			
			@Override
			public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
					AuthenticationException exception) throws IOException, ServletException {
				
				String userType = request.getParameter("userType");
				if("사용자".equals(userType)) {
					response.sendRedirect("/user/login?error=fail");
				} else if("관리자".equals(userType)) {
					response.sendRedirect("/emp/login?error=fail");
				}
			}
		};
	}
	
	@Bean
	public AccessDeniedHandler accessDeniedHandler() {
		return new AccessDeniedHandler() {
			
			@Override
			public void handle(HttpServletRequest request, HttpServletResponse response,
					AccessDeniedException accessDeniedException) throws IOException, ServletException {
				response.sendRedirect("/access-denied");
			}
		};
	}
}
