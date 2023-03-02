package com.example.security.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.example.mapper.UserMapper;
import com.example.mapper.UserRoleMapper;
import com.example.security.oauth.info.OAuth2UserInfo;
import com.example.security.oauth.info.OAuth2UserInfoFactory;
import com.example.security.vo.CustomOAuth2User;
import com.example.vo.User;
import com.example.vo.UserRole;

@Service
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User>{

	@Autowired
	private UserMapper userMapper;
	@Autowired
	private UserRoleMapper userRoleMapper;
	
	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest oAuth2UserRequest) throws OAuth2AuthenticationException {
		OAuth2UserService<OAuth2UserRequest, OAuth2User> oAuth2UserService = new DefaultOAuth2UserService();
		OAuth2User oAuth2User = oAuth2UserService.loadUser(oAuth2UserRequest);
		
		// 현재 진행중인 OAuth2 서비스를 구분. (구글, 카카오, 네이버) {providerType='naver'} 
        String providerType = oAuth2UserRequest.getClientRegistration().getRegistrationId();
        
      	OAuth2UserInfo userInfo = OAuth2UserInfoFactory.getOAuth2UserInfo(providerType, oAuth2User.getAttributes());
        User savedUser = userMapper.getUserById(userInfo.getId());
        
        if(savedUser != null) {
        	if(!providerType.equals(savedUser.getProviderType())) {
        		throw new OAuth2AuthenticationException("소셜로그인 공급자가 일치하지 않습니다.");
        	}
        	updateUser(savedUser, userInfo);
        } else {
        	savedUser = createUser(userInfo, providerType);
        }
		return new CustomOAuth2User(savedUser, userInfo.getAttributes());
        	
	}

	private User createUser(OAuth2UserInfo userInfo, String providerType) {
		User user = new User();
		
		user.setId(userInfo.getId());
		user.setName(userInfo.getName());
		user.setEmail(userInfo.getEmail());
		user.setProviderType(providerType);
		user.setCreatedDate(new Date());
		user.setUpdatedDate(new Date());
		userMapper.insertUser(user);
		
		UserRole userRole = new UserRole(user.getNo(), "ROLE_USER");
		userRoleMapper.insertUserRole(userRole);
		
		return user;
	}

	// 이미 저장된 정보라면, update 처리
    private User updateUser(User user, OAuth2UserInfo userInfo) {
    	
    	if(userInfo.getName() != null && !user.getName().equals(userInfo.getName())) {
    		user.setName(userInfo.getName());
    	}
    	userMapper.updateUser(user);
    	
    	return user;
    }
}
