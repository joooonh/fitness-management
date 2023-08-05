# 🏋️‍♂️ 피트니스 회원관리 프로그램
![image](https://user-images.githubusercontent.com/116352772/223402360-254e4b0c-8e7c-4999-ab25-e5b5c8cca276.png)|![image](https://user-images.githubusercontent.com/116352772/223403056-30f79b71-87ee-4fc8-8d07-4a4ee3ca36a1.png)
:---:|:---:
사용자 화면|관리자 화면
<br/>

## 💻 프로젝트 소개
- 피트니스 프로그램을 신청한 회원을 관리하는 프로그램입니다. 
- **사용자** : 프로그램 일정을 조회하여 신청할 수 있습니다. 
<br/>(회원가입, 로그인, 프로그램 신청, 마이페이지, 관리자와 채팅)
- **관리자** : 프로그램의 예약과 일정, 회원의 정보, 출석 등을 관리할 수 있습니다. 
<br/>(매장관리, 직원관리, 회원관리, 프로그램관리, 출석관리, 일정관리, 사용자와 채팅)
- **서버 배포** : https://fitness.junhee.dev/
<br/>


## 📆 프로젝트 기간
- 2023.01.30 ~ 2023.03.03

## 🙎‍♀️ 팀원 구성
- 김준희(팀장)
- 조성민
- 이아인
- 황창우

## 🛠 개발 도구
- language : Java, javascript, html/css
- framework : spring boot, spring security
- database : Oracle, Mybatis
- IDE : Eclipse
- Server : AWS
- Build : Maven
- etc. : JSP, Git

## 📝 ERD
![image](https://github.com/joooonh/fitness-management/assets/116352772/bce4fb78-81e5-4de9-a854-a8c75a5e9ca7)

## 🖋 유스케이스 다이어그램
![유스케이스 다이어그램](https://github.com/joooonh/fitness-management/assets/116352772/6db6a7b7-c65f-49c6-acf4-93b91e8e19c9)

## 📌 담당 기능

### 🙍‍♀️ 사용자 기능
### 1. 메인페이지
<img src="https://user-images.githubusercontent.com/116352772/223400902-e1a93125-7937-4ffa-afb3-899c6f213a8d.png" width="500" height="230"/>|<img src="https://user-images.githubusercontent.com/116352772/223402360-254e4b0c-8e7c-4999-ab25-e5b5c8cca276.png" width="500" height="230"/>
:---:|:---:
로그인 전 메인페이지|로그인 후 메인페이지

- spring security를 적용하여 마이페이지, 프로그램 신청, 채팅 기능 등은 로그인한 사용자만 접근 가능하도록 구현
<br/>

### 2. 회원가입
![ezgif com-gif-maker](https://github.com/joooonh/fitness-management/assets/116352772/b6de61cd-284d-491a-a724-871f20736c74)|![ezgif com-gif-maker (1)](https://github.com/joooonh/fitness-management/assets/116352772/17187885-2fef-4c1e-a006-73699dc20185)
:---:|:---:
유효성 검사|회원가입 완료

- 프로필 사진 업로드, 미리보기
- [다음 우편번호 api](https://github.com/joooonh/fitness-management/blob/482339f35584e541a379ea8f0cfe18d650e6682d/src/main/webapp/WEB-INF/views/user/register-form.jsp#L146-L154) 사용하여 주소 입력
<br/>

### 3. 로그인
![ezgif com-gif-maker (2)](https://github.com/joooonh/fitness-management/assets/116352772/9ee629ad-46ad-42d7-a6d3-8fddbbcb8aac)|![ezgif com-gif-maker (3)](https://github.com/joooonh/fitness-management/assets/116352772/35e74856-c8ab-42fa-99b2-6eb79a52fe6a)
:---:|:---:
일반 로그인|카카오 로그인

- 🚨[Security를 커스텀](#2-security-커스텀)하여 사용자, 관리자 로그인 후 접근 권한 분리
- [카카오 로그인 api](https://github.com/joooonh/fitness-management/blob/02701d6eb43c5a7991f1a48c38e68a1c60f9d771/src/main/java/com/example/security/service/CustomOAuth2UserService.java#L29-L103) 사용
<br/>


### 4. 마이페이지
![마이페이지](https://github.com/joooonh/fitness-management/assets/116352772/f60a6752-e29c-4b88-a132-41a461e7f98e)|![카카오 마이페이지](https://github.com/joooonh/fitness-management/assets/116352772/f77a6d5f-09c9-4079-a0a0-b6cce120f447)
:---:|:---:
일반 로그인 마이페이지|카카오 로그인 마이페이지


- 내 정보 조회/수정 : 비밀번호, 전화번호, 주소만 수정 가능, 카카오 로그인 마이페이지
- 내 예약 조회(수업신청내역) : 프로그램, 수업신청내역, 직원 테이블 등을 조인하여 신청한 프로그램 내역 조회
- 내 예약 조회(상담문의내역) : 프로그램, 상담신청내역, 직원 테이블 등을 조인하여 신청한 상담 내역 조회
- 내 회원권 조회 : 신청한 회원권 정보 조회
- 회원 탈퇴 : 비밀번호가 일치하면 탈퇴, 탈퇴 후에는 자동 로그아웃
<br/>


### 5. 프로그램 신청
![프로그램신청1](https://github.com/joooonh/fitness-management/assets/116352772/11f378ba-3adb-47c5-9e6b-bc3d9acff1fd)|![프로그램신청2](https://github.com/joooonh/fitness-management/assets/116352772/2af99641-a4b8-41f5-b20c-b16163328502)
:---:|:---:
프로그램만 신청|프로그램, 회원권 신청

- [카카오 지도 api](https://github.com/joooonh/fitness-management/blob/1c9ca7617b46251acdc12ffc028748fc35a88e89/src/main/webapp/WEB-INF/views/user/class-register.jsp#L265-L285)를 사용해서 매장정보 출력
- 🚨[full calendar api와 async/await 등의 비동기 작업 방식, lodash 라이브러리를 사용](#1-asyncawait를-사용한-비동기-작업-처리)해서 프로그램의 전체 일정을 달력에 표시
- [ajax를 사용](https://github.com/joooonh/fitness-management/blob/1c9ca7617b46251acdc12ffc028748fc35a88e89/src/main/webapp/WEB-INF/views/user/class-register.jsp#L233-L240)해서 프로그램을 선택할 때마다 선택한 프로그램에 해당하는 시간, 가격 정보 출력
- [moment.js 라이브러리](https://github.com/joooonh/fitness-management/blob/1c9ca7617b46251acdc12ffc028748fc35a88e89/src/main/webapp/WEB-INF/views/user/class-register.jsp#L251-L263)를 사용해서 회원권 시작날짜와 기간을 선택하면 종료날짜를 계산해서 출력, 선택한 기간에 해당하는 가격 출력
- [프로그램 신청](https://github.com/joooonh/fitness-management/blob/1c9ca7617b46251acdc12ffc028748fc35a88e89/src/main/java/com/example/service/user/ClassRegisterService.java#L51-L89), 회원권 신청(선택사항)
<br/>


### 👩‍💻 관리자 기능
### 1. 관리자 로그인 
![관리자 로그인](https://github.com/joooonh/fitness-management/assets/116352772/a8317c2b-54ce-432b-a68c-5540a85b7a73)|![최고관리자 로그인](https://github.com/joooonh/fitness-management/assets/116352772/e64e3fae-c724-4042-88ac-d9de192bf42f)
:---:|:---:
관리자(EMP) 로그인|최고관리자(ADMIN) 로그인

- 관리자(강사) 권한(ROLE_EMP) : 프로그램, 강사 조회만 가능
- 최고관리자 권한(ROLE_ADMIN) : 프로그램, 강사 등록, 수정, 삭제 가능
- 관리자는 회원가입 없이 미리 등록된 정보로 로그인
- 관리자로 로그인 시 [관리자용 메인화면으로 이동](https://github.com/joooonh/fitness-management/blob/b2a490035da6f800f5d83fe12e584b6e05872703/src/main/java/com/example/security/SecurityConfig.java#L130-L146)
<br/>


### 2. 회원관리 
![회원목록](https://github.com/joooonh/fitness-management/assets/116352772/719b650c-4b1e-4315-93e4-33983be145df)|![회원상세정보](https://github.com/joooonh/fitness-management/assets/116352772/d3fa40fd-7493-4167-85f0-fd36af7c271a)
:---:|:---:
회원목록(정렬,검색,삭제)|회원 상세정보

- 회원목록 (좌)
  - 회원목록 : 회원가입한 전체 회원목록 표시, [resultMap을 사용](https://github.com/joooonh/fitness-management/blob/b499dcaead290eac4487e64f6002cb8d706ab039/src/main/resources/mybatis/mappers/userList.xml#L33-L86)하여 각 회원이 신청한 프로그램 목록도 함께 출력 ([로직](https://github.com/joooonh/fitness-management/blob/b499dcaead290eac4487e64f6002cb8d706ab039/src/main/java/com/example/service/admin/UserManagementService.java#L31-L65))
  - 회원정렬 : 회원번호순, 최근등록순, 이름순 정렬
  - 회원검색 : 프로그램명, 이름, 전화번호 등의 검색어로 회원 검색
  - 회원삭제 : 선택한 회원 삭제
- 회원 상세정보 (우) 
  - [ajax를 사용](https://github.com/joooonh/fitness-management/blob/b499dcaead290eac4487e64f6002cb8d706ab039/src/main/webapp/WEB-INF/views/management/user-management.jsp#L350-L453)해서 회원목록에서 이름 클릭 시 해당 사용자에 대한 상세정보, 신청한 수업, 회원권, 상담내역 조회  
<br/>


### 3. 사용자와 관리자 간 채팅 
![사용자채팅](https://github.com/joooonh/fitness-management/assets/116352772/539ee6fe-651e-414b-a2c9-3eb342a251b1)|![관리자채팅](https://github.com/joooonh/fitness-management/assets/116352772/2fc952d0-b092-45aa-b92c-a1b8f1f62b53)
:---:|:---:
사용자 채팅|관리자 채팅

- 🚨[WebSocket을 사용](#3-web-socket)해서 사용자와 관리자의 양방향 실시간 채팅 기능 구현
  - [자바스크립트 웹소켓 라이브러리](https://github.com/joooonh/fitness-management/blob/fc098085d0ba1c01762ab536775e113e9a8025ba/src/main/webapp/WEB-INF/views/chat/userChat.jsp#L50-L161) 적용
  - [웹소켓 핸들러](https://github.com/joooonh/fitness-management/blob/fc098085d0ba1c01762ab536775e113e9a8025ba/src/main/java/com/example/web/websocket/ChatSocketHandler.java#L25-L195) 로직 
<br/>
<br/>

## 🚨 문제 해결

### 1. Async/await를 사용한 비동기 작업 처리

#### 1) 문제
  - FullCalendar API를 사용해 Ajax로 받아온 프로그램 일정 데이터를 출력해야함
  - Ajax 요청을 통해 받아온 데이터가 전달되지 않는 문제 발생

#### 2) 원인
  - 비동기 방식으로 요청하기 때문에 데이터를 받기 전에 다음 작업이 수행됨

#### 3) 해결
  - [**Async/await**를 사용하여 비동기작업을 동기식으로 처리](https://github.com/joooonh/fitness-management/blob/09a0f936839db750d0dfd6b0bba6b5640ab9b4c9/src/main/webapp/WEB-INF/views/user/class-register.jsp#L154-L202)
  - 받아온 데이터에 대해 반복되는 작업을 간편하게 처리하기 위해 **lodash** 라이브러리의 메소드 사용

#### 4) 결과/느낀점
  - **코드의 가독성 향상**
  - 새로운 기술을 학습하고, 적용하는 것의 필요성 
<br/>
<br/>


### 2. Security 커스텀

#### 1) 문제
  - 로그인한 이용자를 구분하기 위한 userType이 Authentication 토큰에 저장되지 않아 로그인한 이용자가 구분되지 않는 문제 발생

#### 2) 원인
  - 사용자, 관리자의 각 로그인 폼에서 로그인 정보와 함께 히든필드로 userType을 넘겨줬지만, 기본 시큐리티 구조 중에는 사용자가 임의로 생성한 userType을 저장하는 필드가 없음
  - ([사용자 userType = "사용자"](https://github.com/joooonh/fitness-management/blob/583572fe351421899a8f917b8cf7728e631e7ed3/src/main/webapp/WEB-INF/views/user/login-form.jsp#L23), [관리자 userType = "관리자"](https://github.com/joooonh/fitness-management/blob/583572fe351421899a8f917b8cf7728e631e7ed3/src/main/webapp/WEB-INF/views/employee/login-form.jsp#L22))

#### 3) 해결
  - 로그인 정보를 받아서 Authentication 토큰을 생성하는 [**AuthenticationFilter를 커스텀**](https://github.com/joooonh/fitness-management/blob/583572fe351421899a8f917b8cf7728e631e7ed3/src/main/java/com/example/security/CustomAuthenticationFilter.java#L15-L35)하여, 로그인 정보와 함께 userType 정보도 넘겨받아 토큰 생성
  - [토큰도 커스텀](https://github.com/joooonh/fitness-management/blob/583572fe351421899a8f917b8cf7728e631e7ed3/src/main/java/com/example/security/CustomAuthenticationToken.java#L8-L28)하여 userType 필드를 생성하고 정보를 저장
  - 실질적인 인증 처리를 하는 [**AuthenticationProvider도 커스텀**](https://github.com/joooonh/fitness-management/blob/583572fe351421899a8f917b8cf7728e631e7ed3/src/main/java/com/example/security/CustomAuthenticationProvider.java#L17-L55)하여, 토큰에서 꺼낸 userType에 따라 사용자 테이블, 관리자 테이블을 조회해서 일치하는 객체를 꺼내 인증된 Authentication 객체에 담음
  - 커스텀한 필터와 provider를 [SecurityConfig에 등록](https://github.com/joooonh/fitness-management/blob/b2a490035da6f800f5d83fe12e584b6e05872703/src/main/java/com/example/security/SecurityConfig.java#L38-L177)

#### 4) 결과/느낀점
  - **사용자/관리자 간 명확한 접근 제어 관리, 코드의 확장성 향상**
  - 흐름을 이해하기 위한 아키텍처 구조 분석의 중요성
<br/>
<br/>


### 3. Web Socket

#### 1) 문제
  - 스프링 시큐리티를 적용하여 웹소켓을 통한 채팅 기능 구현 중, 웹소켓 세션에 담긴 사용자 정보가 조회되지 않아 웹소켓 연결이 안되는 문제 발생

#### 2) 원인
  - 웹 소켓 세션과 스프링 시큐리티의 흐름을 숙지하지 못해 세션을 잘못된 경로로 조회함

#### 3) 해결
  - security context -> authenticationToken -> UserDetails 순으로 로그 확인하며 [세션 객체가 어떤 객체에 어떤 형태로 저장되어 있는지 직접 확인](https://github.com/joooonh/fitness-management/blob/fc098085d0ba1c01762ab536775e113e9a8025ba/src/main/java/com/example/web/websocket/ChatSocketHandler.java#L38-L52)

#### 4) 결과/느낀점/아쉬운점
  - 로그 
  - 웹소켓 방식은 메시지 요청 내용, 방식, 처리과정 등을 별도로 구현해야 함 -> STOMP 고려

