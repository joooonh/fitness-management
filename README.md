# fitness-management
![image](https://user-images.githubusercontent.com/116352772/223402360-254e4b0c-8e7c-4999-ab25-e5b5c8cca276.png)|![image](https://user-images.githubusercontent.com/116352772/223403056-30f79b71-87ee-4fc8-8d07-4a4ee3ca36a1.png)
:---:|:---:
사용자 화면|관리자 화면
<br/>

## 💻 프로젝트 소개
- 피트니스 회원관리 프로그램입니다. 
- 사용자 모드와 관리자 모드로 서비스를 이용할 수 있습니다. 
- 사용자 : 프로그램 일정을 조회하여 신청할 수 있습니다. 
<br/>(회원가입, 로그인, 프로그램 신청, 마이페이지, 관리자와 채팅)
- 관리자 : 프로그램의 예약과 일정, 회원의 정보, 출석 등을 관리할 수 있습니다. 
<br/>(매장관리, 직원관리, 회원관리, 프로그램관리, 출석관리, 일정관리, 사용자와 채팅)

## 📆 프로젝트 기간
- 2023.01.30 ~ 2023.03.03

## 🙎‍♀️ 팀원 구성
- 김준희(팀장)
- 조성민
- 이아인
- 황창우

## 🛠 개발 도구
- language : Java 11, javascript, html/css
- framework : spring boot, spring security
- database : Oracle, Mybatis
- IDE : Eclipse
- Server : AWS
- Build : Maven
- etc. : JSP, Git


## 📌 담당 기능

### * 사용자 모드
### 1. 메인페이지
<img src="https://user-images.githubusercontent.com/116352772/223400902-e1a93125-7937-4ffa-afb3-899c6f213a8d.png" width="500" height="230"/>|<img src="https://user-images.githubusercontent.com/116352772/223402360-254e4b0c-8e7c-4999-ab25-e5b5c8cca276.png" width="500" height="230"/>
:---:|:---:
로그인 전 메인페이지|로그인 후 메인페이지

- spring security를 적용하여 마이페이지, 프로그램 신청, 채팅 기능 등은 [로그인한 사용자만 접근 가능](https://github.com/joooonh/fitness-management/blob/2f3da540eeb99b42c7d3cfc568529a9fee51240b/src/main/webapp/WEB-INF/views/common/header.jsp#L41-L61)하도록 구현
<br/>

### 2. 회원가입
![ezgif com-gif-maker](https://github.com/joooonh/fitness-management/assets/116352772/b6de61cd-284d-491a-a724-871f20736c74)|![ezgif com-gif-maker (1)](https://github.com/joooonh/fitness-management/assets/116352772/17187885-2fef-4c1e-a006-73699dc20185)
:---:|:---:
유효성 검사|회원가입 완료

- [회원가입 로직](https://github.com/joooonh/fitness-management/blob/45a28518e2a7337b9374ff4c22f4121b19fac772/src/main/java/com/example/web/controller/user/UserController.java#L68-L97)
- 프로필 사진 업로드, [미리보기](https://github.com/joooonh/fitness-management/blob/482339f35584e541a379ea8f0cfe18d650e6682d/src/main/webapp/WEB-INF/views/user/register-form.jsp#L161-L171)
- [다음 우편번호 api](https://github.com/joooonh/fitness-management/blob/482339f35584e541a379ea8f0cfe18d650e6682d/src/main/webapp/WEB-INF/views/user/register-form.jsp#L146-L154) 사용하여 주소 입력
<br/>

### 3. 로그인
![ezgif com-gif-maker (2)](https://github.com/joooonh/fitness-management/assets/116352772/9ee629ad-46ad-42d7-a6d3-8fddbbcb8aac)|![ezgif com-gif-maker (3)](https://github.com/joooonh/fitness-management/assets/116352772/35e74856-c8ab-42fa-99b2-6eb79a52fe6a)
:---:|:---:
일반 로그인|카카오 로그인

- 🚨[Security를 커스텀](#1-security-커스텀)하여 사용자, 관리자 로그인부터의 기능 분리
- [카카오 로그인 api](https://github.com/joooonh/fitness-management/blob/02701d6eb43c5a7991f1a48c38e68a1c60f9d771/src/main/java/com/example/security/service/CustomOAuth2UserService.java#L29-L103) 사용
<br/>


### 4. 마이페이지
![마이페이지](https://github.com/joooonh/fitness-management/assets/116352772/f60a6752-e29c-4b88-a132-41a461e7f98e)|![카카오 마이페이지](https://github.com/joooonh/fitness-management/assets/116352772/f77a6d5f-09c9-4079-a0a0-b6cce120f447)
:---:|:---:
일반 로그인 마이페이지|카카오 로그인 마이페이지

- [마이페이지](https://github.com/joooonh/fitness-management/blob/45a28518e2a7337b9374ff4c22f4121b19fac772/src/main/java/com/example/web/controller/user/UserController.java#L111-L210)
  - 내 정보 조회/수정 : 비밀번호, 전화번호, 주소만 수정 가능, 🚨[카카오 로그인 마이페이지](#2-카카오-로그인-마이페이지)
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
- [full calendar api](https://github.com/joooonh/fitness-management/blob/1c9ca7617b46251acdc12ffc028748fc35a88e89/src/main/webapp/WEB-INF/views/user/class-register.jsp#L154-L209)를 사용해서 요일별로 반복되는 프로그램의 전체 일정을 달력에 표시 ([일정 조회 로직](https://github.com/joooonh/fitness-management/blob/1c9ca7617b46251acdc12ffc028748fc35a88e89/src/main/java/com/example/service/user/ClassRegisterService.java#L91-L159))
- [ajax를 사용](https://github.com/joooonh/fitness-management/blob/1c9ca7617b46251acdc12ffc028748fc35a88e89/src/main/webapp/WEB-INF/views/user/class-register.jsp#L233-L240)해서 프로그램을 선택할 때마다 선택한 프로그램에 해당하는 시간, 가격 정보 출력
- [moment.js 라이브러리](https://github.com/joooonh/fitness-management/blob/1c9ca7617b46251acdc12ffc028748fc35a88e89/src/main/webapp/WEB-INF/views/user/class-register.jsp#L251-L263)를 사용해서 회원권 시작날짜와 기간을 선택하면 종료날짜를 계산해서 출력, 선택한 기간에 해당하는 가격 출력
- [프로그램 신청](https://github.com/joooonh/fitness-management/blob/1c9ca7617b46251acdc12ffc028748fc35a88e89/src/main/java/com/example/web/controller/user/ClassRegisterController.java#L63-L84) 
<br/>


### 7. 관리자 로그인 
![image](https://user-images.githubusercontent.com/116352772/223402869-ce140af9-3385-4aec-9051-21a08b876aca.png)
### 8. 관리자 로그인 후 화면
![image](https://user-images.githubusercontent.com/116352772/223402931-598583d9-7207-4b01-bac5-29dd96b04b3a.png)
### 9. 회원관리 - 회원목록
![image](https://user-images.githubusercontent.com/116352772/223403056-30f79b71-87ee-4fc8-8d07-4a4ee3ca36a1.png)
### 10. 회원관리 - 회원검색
![image](https://user-images.githubusercontent.com/116352772/223403144-1c1be5fd-ab65-418f-a034-c57d76ded25a.png)
### 11. 회원관리 - 회원정렬
![image](https://user-images.githubusercontent.com/116352772/223403261-b317e780-e6b8-46ff-b172-add74f827d2d.png)
### 12. 사용자와 관리자 간 채팅 
![image](https://user-images.githubusercontent.com/116352772/223404608-5985eb4b-5334-470e-8eab-348fa4e7613b.png)

<br/>
<br/>

## 🚨 트러블 슈팅

### 1. Security 커스텀

#### 1) 문제
  - 로그인한 이용자를 구분하기 위한 userType이 Authentication 토큰에 저장되지 않아 로그인한 이용자가 구분되지 않는 문제 발생

#### 2) 원인
  - 사용자, 관리자의 각 로그인 폼에서 로그인 정보와 함께 히든필드로 userType을 넘겨줬지만, 기본 시큐리티 구조 중에는 사용자가 임의로 생성한 userType을 저장하는 필드가 없음
  - ([사용자 userType = "사용자"](https://github.com/joooonh/fitness-management/blob/583572fe351421899a8f917b8cf7728e631e7ed3/src/main/webapp/WEB-INF/views/user/login-form.jsp#L23), [관리자 userType = "관리자"](https://github.com/joooonh/fitness-management/blob/583572fe351421899a8f917b8cf7728e631e7ed3/src/main/webapp/WEB-INF/views/employee/login-form.jsp#L22))

#### 3) 해결
  - 로그인 정보를 받아서 Authentication 토큰을 생성하는 [AuthenticationFilter를 커스텀](https://github.com/joooonh/fitness-management/blob/583572fe351421899a8f917b8cf7728e631e7ed3/src/main/java/com/example/security/CustomAuthenticationFilter.java#L15-L35)하여 로그인 정보와 함께 userType 정보도 넘겨받아 토큰을 생성한다. 
  - [토큰도 커스텀](https://github.com/joooonh/fitness-management/blob/583572fe351421899a8f917b8cf7728e631e7ed3/src/main/java/com/example/security/CustomAuthenticationToken.java#L8-L28)하여 userType 필드를 생성하고 정보를 저장한다.
  - 실질적인 인증 처리를 하는 [AuthenticationProvider도 커스텀](https://github.com/joooonh/fitness-management/blob/583572fe351421899a8f917b8cf7728e631e7ed3/src/main/java/com/example/security/CustomAuthenticationProvider.java#L17-L55)하여 토큰에서 꺼낸 userType에 따라 사용자 테이블, 관리자 테이블을 조회해서 일치하는 객체를 꺼내 인증된 Authentication 객체에 담는다.
  - 인증 완료된 Authentication 객체에 로그인 한 이용자의 정보와 userType이 담겨있다. 

#### 4) 느낀점
  - 시큐리티의 동작 흐름을 숙지하지 못한 채로 구현하려다보니 어려움이 컸는데, 흐름을 제대로 이해하기 위해서 직접 구조를 뜯어보고 분석하는 과정이 얼마나 중요한지 느끼게 되었다. 구조를 뜯어볼 때 로그를 남기는 것이 큰 도움이 되었다. 
  - 기본적으로 제공되는 기능이라도 상속, 구현 등을 통해서 원하는 대로 커스텀할 수 있다는 점에서 스프링의 확장성의 장점을 느꼈다. 시큐리티를 커스텀하는 과정에서 코드에 대한 이해도도 훨씬 높아지게 되었다. 
<br/>
<br/>

### 2. 카카오 로그인 마이페이지

#### 1) 문제
  - 카카오 로그인 시 마이페이지의 프로필에 사용자가 설정한 카카오 프로필이 표시되지 않는 문제 발생

#### 2) 원인
  - 일반 회원가입과 카카오 회원가입 시 사진이 저장되는 경로가 다름 

#### 3) 해결 
  - 로그인 방식에 따라 [사진을 불러오는 경로를 구분](https://github.com/joooonh/fitness-management/blob/45a28518e2a7337b9374ff4c22f4121b19fac772/src/main/webapp/WEB-INF/views/user/info.jsp#L34-L42)한다.
    - 사용자 객체인 User, ModifyForm에 providerType 필드를 추가하여, providerType이 null(일반)인지 kakao(카카오)인지에 따라 사진을 불러오는 경로를 구분한다. 



