package com.example.security.service;

import java.util.Collections;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.example.mapper.UserMapper;
import com.example.mapper.UserRoleMapper;
import com.example.security.oauth.info.KakaoOAuth2UserInfo;
import com.example.security.oauth.info.OAuth2UserInfo;
import com.example.security.vo.CustomOAuth2User;
import com.example.vo.User;
import com.example.vo.UserRole;

import lombok.extern.slf4j.Slf4j;

// 소셜 로그인한 정보 처리 후 OAuth2 객체 반환
@Slf4j
@Service
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {

	@Autowired
	private UserMapper userMapper;
	@Autowired
	private UserRoleMapper userRoleMapper;
	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest oAuth2UserRequest) throws OAuth2AuthenticationException {
		
		// 기본적으로 제공되는 DefaultOAuth2UserSevice 사용 : OAuth 2.0 공급자로부터 받은 액세스 토큰을 사용하여 사용자 정보를 가져옴
		OAuth2UserService<OAuth2UserRequest, OAuth2User> oAuth2UserService = new DefaultOAuth2UserService();
		OAuth2User oAuth2User = oAuth2UserService.loadUser(oAuth2UserRequest);
		
		// 현재 사용자가 로그인한 OAuth 2.0 서비스의 ID를 가져옴
		String providerType = oAuth2UserRequest.getClientRegistration().getRegistrationId();
		
        OAuth2UserInfo userInfo = null;
        
        if (providerType.equals("kakao")) {
        	userInfo = new KakaoOAuth2UserInfo(oAuth2User.getAttributes());
        }
        
		User savedUser = userMapper.getUserById(userInfo.getId());
        
        // 해당 아이디의 사용자가 이미 있을 경우 최신정보로 업데이트
        if(savedUser != null) {
        	if(!providerType.equals(savedUser.getProviderType())) {
        		throw new OAuth2AuthenticationException("소셜로그인 공급자가 일치하지 않습니다.");
        	}
        	updateUser(savedUser, userInfo);
        	
        // 해당 아이디의 사용자가 없을 경우 사용자 등록(가입)
        } else {
        	savedUser = createUser(userInfo, providerType);
        }
        
        UserRole userRole = userRoleMapper.getUserRoleByNo(savedUser.getNo());
        
        // 로그인한 사용자 객체, 사용자의 권한 정보, 소셜 로그인에 사용된 사용자 정보를 담아서 CustomOAuth2User 객체 생성
		return new CustomOAuth2User(
				savedUser,
				Collections.singletonList(new SimpleGrantedAuthority(userRole.getRoleName())),
				userInfo.getAttributes());
	}
	
	private User createUser(OAuth2UserInfo userInfo, String providerType) {
		// user 정보를 먼저 등록하고 
		User user = new User();
		user.setId(userInfo.getId());
		user.setName(userInfo.getName());
		user.setEmail(userInfo.getEmail());
		user.setPhoto(userInfo.getPhoto());
		user.setProviderType(providerType);
		user.setCreatedDate(new Date());
		user.setUpdatedDate(new Date());
		userMapper.insertUser(user);
		
		// 등록된 user의 no를 가지고 userRole 등록
		UserRole userRole = new UserRole(user.getNo(), "ROLE_USER");
		userRoleMapper.insertUserRole(userRole);
		return user;
	}

    private User updateUser(User user, OAuth2UserInfo userInfo) {

        if (userInfo.getName() != null && user.getName().equals(userInfo.getName())) {
            user.setName(userInfo.getName());
            user.setEmail(userInfo.getEmail());
            user.setPhoto(userInfo.getPhoto());
        }
        userMapper.updateUser(user);
        return user;
    }
}
