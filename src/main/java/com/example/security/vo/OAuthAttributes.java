package com.example.security.vo;

import java.util.Map;

import com.example.vo.User;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OAuthAttributes {

	private Map<String, Object> attributes;	// OAuth2 반환하는 유저 정보 Map
	private String nameAttributeKey;
	private String name;
	private String email;
	private String photo;
	
	public OAuthAttributes() {
		
	}
	public OAuthAttributes(Map<String, Object> attributes, String nameAttributeKey, String name, String email, String photo) {
		this.attributes = attributes;
		this.nameAttributeKey = nameAttributeKey;
		this.name = name;
		this.email = email;
		this.photo = photo;
	}
	
	// 해당 로그인인 서비스가 kakao인지 google인지 구분하여, 알맞게 매핑
    // 여기서 registrationId는 OAuth2 로그인을 처리한 서비스 명("google","kakao","naver"..)이 되고,
    // userNameAttributeName은 해당 서비스의 map의 키값이 되는 값 {google="sub", kakao="id", naver="response"}
    public static OAuthAttributes of(String registrationId, String userNameAttributeName, Map<String, Object> attributes) {
        if (registrationId.equals("kakao")) {
            return ofKakao(userNameAttributeName, attributes);
        } else if (registrationId.equals("naver")) {
            return ofNaver(userNameAttributeName,attributes);
        }
        return ofGoogle(userNameAttributeName, attributes);
    }

    private static OAuthAttributes ofKakao(String userNameAttributeName, Map<String, Object> attributes) {
    	// kakao는 kakao_account에 유저정보 email이 있다. 
        @SuppressWarnings("unchecked")
		Map<String, Object> kakao_account = (Map<String, Object>) attributes.get("kakao_account"); 
        // kakao_account 안에서 또 profile(nickname, image_url.. 등) 정보가 담긴 값을 꺼낸다.
        @SuppressWarnings("unchecked")
		Map<String, Object> profile = (Map<String, Object>) kakao_account.get("profile");   

        return new OAuthAttributes(attributes,
                userNameAttributeName,
                (String) profile.get("nickname"),
                (String) kakao_account.get("email"),
                (String) profile.get("profile_image_url"));
    }

    private static OAuthAttributes ofNaver(String userNameAttributeName, Map<String, Object> attributes) {
    	// naver는 response에 유저정보가 있다. 
        @SuppressWarnings("unchecked")
		Map<String, Object> response = (Map<String, Object>) attributes.get("response");    
        
        return new OAuthAttributes(attributes,
                userNameAttributeName,
                (String) response.get("name"),
                (String) response.get("email"),
                (String) response.get("profile_image"));
    }

    private static OAuthAttributes ofGoogle(String userNameAttributeName, Map<String, Object> attributes) {
        
        return new OAuthAttributes(attributes,
                userNameAttributeName,
                (String) attributes.get("name"),
                (String) attributes.get("email"),
                (String) attributes.get("picture"));
    }

    public User toEntity() {
        return new User(name, email, photo);
    }
	
}
