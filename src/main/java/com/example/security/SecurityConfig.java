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
			// 인증된 사람만 다음 기능 가능 
			.antMatchers("/logout").authenticated()
			// 특정 권한을 가진 사람만 다음 페이지 접근 가능
			.antMatchers("/user/**").hasAnyRole("USER", "ADMIN")
			.antMatchers("/emp/**").hasAnyRole("EMP", "ADMIN")
			.antMatchers("/admin/**").hasAnyRole("ADMIN")
			.anyRequest().authenticated()
		.and()
			// 인증정책 설정
			.formLogin()							// 인증방식은 폼인증 방식 사용
			.loginProcessingUrl("/login")			// 로그인 처리를 요청하는 URI
		.and()
			// 로그아웃 정책 설정
			.logout()
			.logoutUrl("/logout")					// 로그아웃 처리를 요청하는 URI
			.logoutSuccessUrl("/")					// 사용자 로그아웃 성공 시 재요청할 URI
		.and()
			.addFilter(authenticationFilter())
			.exceptionHandling()
			.accessDeniedHandler(accessDeniedHandler())
		.and()
			.headers().frameOptions().disable()
		.and()
			.oauth2Login()
			.loginPage("/user/login")
			.successHandler(authenticationSuccessHandler())
			.userInfoEndpoint()
			.userService(customOAuth2UserService);
	}
	
	// 보안정책을 적용하지 않을 URI 설정 (이미지, 스타일시트, 자바스크립트 소스와 같은 정적 콘텐츠는 인증/인가 작업을 수행하지 않도록 설정)
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/resources/**", "/favicon.ico");
	}
	
	// 사용자정의 UserDetailsService 객체(customUserDetailsService)와 비밀번호 암호화객체를 AuthenticationManagerBuilder에 등록
	// -> 기본제공하는거 말고 얘네를 써라
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.authenticationProvider(authenticationProvider());
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
	
	@Bean
	public CustomAuthenticationFilter authenticationFilter() throws Exception {
		 CustomAuthenticationFilter filter = new CustomAuthenticationFilter();
		 filter.setAuthenticationManager(authenticationManager());
		 filter.setAuthenticationSuccessHandler(authenticationSuccessHandler());
		 filter.setAuthenticationFailureHandler(authenticationFailureHandler());
		 return filter;
	}
	
	@Bean
	public AuthenticationProvider authenticationProvider() {
		// 여기서 map에 담아서 CustomAuthenticationProvider에서 값 꺼내서 사용
		Map<String, UserDetailsService> map = new HashMap<>();
		map.put("사용자", userDetailsService);
		map.put("관리자", employeeDetailsService);
		
		return new CustomAuthenticationProvider(map, passwordEncoder);
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
}
