package com.example.security.service;

import java.util.Collections;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
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

// OAuth2 공급자로부터 사용자 정보를 가져오는 클래스 
@Service
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {

<<<<<<< HEAD
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private UserRoleMapper userRoleMapper;
	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest oAuth2UserRequest) throws OAuth2AuthenticationException {
		// 기본적으로 제공되는 DefaultOAuth2UserSevice를 생성해서 oAuth2UserService 변수에 저장
		// DefaultOAuth2UserSevice : OAuth 2.0 공급자로부터 받은 액세스 토큰을 사용하여 사용자 정보를 가져옴
		// OAuth2UserRequest : OAuth 2.0 프로토콜에서 사용하는 클라이언트 정보와 액세스 토큰 정보 등의 정보를 캡슐화한 객체 
		OAuth2UserService<OAuth2UserRequest, OAuth2User> oAuth2UserService = new DefaultOAuth2UserService();
		// DefaultOAuth2UserSevice의 OAuth2UserRequest 객체를 입력받아 loadUser 메소드를 호출하여 로그인한 사용자 정보를 가져와 OAuth2User 객체 반환
		OAuth2User oAuth2User = oAuth2UserService.loadUser(oAuth2UserRequest);
		
		// 현재 사용자가 로그인한 OAuth 2.0 서비스의 ID를 가져옴
        // getClientRegistration() : OAuth 2.0 클라이언트 애플리케이션의 등록정보를 캡슐화한 ClientRegistration 객체 반환
		// getRegistrationId() : ClientRegistration 객체에 등록된 id 반환 (OAuth2 서비스를 구분하는 id)
		String providerType = oAuth2UserRequest.getClientRegistration().getRegistrationId();
        // OAuth2UserInfoFactory클래스에서 메소드를 호출하여 소셜 로그인에 사용된 사용자 정보를 가져옴
      	OAuth2UserInfo userInfo = OAuth2UserInfoFactory.getOAuth2UserInfo(providerType, oAuth2User.getAttributes());
        User savedUser = userMapper.getUserById(userInfo.getId());
        // 해당 아이디의 사용자가 이미 있을 경우
        if(savedUser != null) {
        	if(!providerType.equals(savedUser.getProviderType())) {
        		throw new OAuth2AuthenticationException("소셜로그인 공급자가 일치하지 않습니다.");
        	}
        	// 최신정보로 업데이트 메소드 실행
        	updateUser(savedUser, userInfo);
        // 해당 아이디의 사용자가 없을 경우 
        } else {
        	// 사용자 등록 메소드 실행 
        	savedUser = createUser(userInfo, providerType);
        }
        // 사용자가 db에 있든없든 userRole은 ROLE_USER여야 함 
        UserRole userRole = userRoleMapper.getUserRoleByNo(savedUser.getNo());
        // OAuth2User 객체, 사용자의 권한 정보, 소셜 로그인에 사용된 사용자 정보를 담아서 CustomOAuth2User 객체 생성
        // SimpleGrantedAuthority : 인증된 사용자의 권한을 나타내기 위해 사용
        // singletonList(): 단일 권한을 갖는 리스트 생성
		return new CustomOAuth2User(
				savedUser,
				Collections.singletonList(new SimpleGrantedAuthority(userRole.getRoleName())),
				userInfo.getAttributes());
	}
	
	// OAuth2UserInfo : 로그인한 사용자 정보가 들어있는 객체 
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
=======
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

        if (savedUser != null) {
            if (!providerType.equals(savedUser.getProviderType())) {
                throw new OAuth2AuthenticationException("소셜로그인 공급자가 일치하지 않습니다.");
            }
            updateUser(savedUser, userInfo);
        } else {
            savedUser = createUser(userInfo, providerType);
        }
        UserRole userRole = userRoleMapper.getUserRoleByNo(savedUser.getNo());

        return new CustomOAuth2User(
                savedUser,
                Collections.singletonList(new SimpleGrantedAuthority(userRole.getRoleName())),
                userInfo.getAttributes()
        );
    }
>>>>>>> b8735a79c3060a0f5d3bf4d8c3a33dddb9b4e242

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

        if (userInfo.getName() != null && !user.getName().equals(userInfo.getName())) {
            user.setName(userInfo.getName());
        }
        userMapper.updateUser(user);

        return user;
    }
}
