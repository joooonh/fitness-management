package com.example.security.service;

import java.util.Collections;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.example.mapper.UserMapper;
import com.example.security.vo.OAuthAttributes;
import com.example.security.vo.SessionUser;
import com.example.vo.User;

@Service
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User>{

	@Autowired
	private UserMapper userMapper;
	@Autowired
	private HttpSession httpSession;
	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest oAuth2UserRequest) throws OAuth2AuthenticationException {
		OAuth2UserService oAuth2UserService = new DefaultOAuth2UserService();
		OAuth2User oAuth2User = oAuth2UserService.loadUser(oAuth2UserRequest);
		
		// 현재 진행중인 OAuth2 서비스를 구분. (구글, 카카오, 네이버) {registrationId='naver'} 이런식으로
        String registrationId = oAuth2UserRequest.getClientRegistration().getRegistrationId();
        
        // OAuth2 로그인 시 키 값이 된다. 구글은 키 값이 "sub"이고, 네이버는 "response"이고, 카카오는 "id"이다. 각각 다르므로 이렇게 따로 변수로 받아서 넣어줘야함.
        String userNameAttributeName = oAuth2UserRequest.getClientRegistration().getProviderDetails().getUserInfoEndpoint().getUserNameAttributeName();
        
        // OAuth2 로그인을 통해 가져온 OAuth2User의 attribute를 담아주는 of 메소드.
        OAuthAttributes attributes = OAuthAttributes.of(registrationId, userNameAttributeName, oAuth2User.getAttributes());

	        User user = saveOrUpdate(attributes);
	        httpSession.setAttribute("user", new SessionUser(user));
	
	        System.out.println(attributes.getAttributes());
	        return new DefaultOAuth2User(Collections.singleton(new SimpleGrantedAuthority("ROLE_USER"))
	                , attributes.getAttributes()
	                , attributes.getNameAttributeKey());
	    }
	
		// 이미 저장된 정보라면, update 처리
	    private User saveOrUpdate(OAuthAttributes attributes) {
	        User user = userMapper.getUserByEmail(attributes.getEmail());
	        if(user != null) {
	        	user.setName(attributes.getName());
	        	user.setPhoto(attributes.getPhoto());
	        	
	        	userMapper.updateUser(user);
	        	return user;
	        } else {
	        	User newUser = new User();
	        	newUser.setName(attributes.getName());
	        	newUser.setEmail(attributes.getEmail());
	        	newUser.setPhoto(attributes.getPhoto());
	        	
	        	userMapper.insertUser(newUser);
	        	return newUser;
	        }
	
	    }
}
