# fitness-management
![image](https://user-images.githubusercontent.com/116352772/223402360-254e4b0c-8e7c-4999-ab25-e5b5c8cca276.png)|![image](https://user-images.githubusercontent.com/116352772/223403056-30f79b71-87ee-4fc8-8d07-4a4ee3ca36a1.png)
:---:|:---:
사용자 화면|관리자 화면
<br/>

## 💻 프로젝트 소개
- 피트니스 회원관리 프로그램입니다. 
- 스프링 시큐리티를 사용하여 사용자와 관리자의 로그인을 구분하여, 사용자 모드와 관리자 모드로 서비스를 이용할 수 있습니다. 
<br/> 사용자는 간편하게 프로그램 일정을 조회하여 신청할 수 있고, 관리자는 편리하게 프로그램의 예약과 일정, 회원의 정보, 출석 등을 관리할 수 있습니다.
- 사용자 : 회원가입, 로그인, 프로그램 신청, 마이페이지, 관리자와 채팅 등의 기능을 이용할 수 있습니다.
- 관리자 : 매장관리, 직원관리, 회원관리, 프로그램관리, 출석관리, 일정관리, 사용자와 채팅 등의 기능을 이용할 수 있습니다.

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

- [회원가입 로직](https://github.com/joooonh/fitness-management/blob/482339f35584e541a379ea8f0cfe18d650e6682d/src/main/java/com/example/web/controller/user/UserHomeController.java#L52-L85)
- 프로필 사진 [업로드](https://github.com/joooonh/fitness-management/blob/482339f35584e541a379ea8f0cfe18d650e6682d/src/main/java/com/example/web/controller/user/UserHomeController.java#L62-L69), [미리보기](https://github.com/joooonh/fitness-management/blob/482339f35584e541a379ea8f0cfe18d650e6682d/src/main/webapp/WEB-INF/views/user/register-form.jsp#L161-L171)
- [다음 우편번호 api](https://github.com/joooonh/fitness-management/blob/482339f35584e541a379ea8f0cfe18d650e6682d/src/main/webapp/WEB-INF/views/user/register-form.jsp#L146-L154) 사용하여 주소 입력
<br/>

### 3. 로그인
![ezgif com-gif-maker (2)](https://github.com/joooonh/fitness-management/assets/116352772/9ee629ad-46ad-42d7-a6d3-8fddbbcb8aac)|![ezgif com-gif-maker (3)](https://github.com/joooonh/fitness-management/assets/116352772/35e74856-c8ab-42fa-99b2-6eb79a52fe6a)
:---:|:---:
일반 로그인|카카오 로그인

- [Security를 커스텀](#1-security-커스텀)하여 사용자, 관리자 로그인부터의 기능 분리
- 카카오 로그인 api 사용
<br/>


### 4. 마이페이지
![image](https://user-images.githubusercontent.com/116352772/223402449-e90fa4c4-573e-4648-bfc5-8916ea41c4b7.png)
![image](https://user-images.githubusercontent.com/116352772/223402510-788ad8ed-b51a-44e4-8be8-bfd0cc8609f9.png)
![image](https://user-images.githubusercontent.com/116352772/223402590-fab7e29d-c90c-490c-9e42-30ce10952bb7.png)
![image](https://user-images.githubusercontent.com/116352772/223402643-02e8e53f-ead4-4f44-9940-a06e0ef7feca.png)
![image](https://user-images.githubusercontent.com/116352772/223402691-8858bf02-b13a-4720-b993-e21bbf49d2c1.png)
### 6. 프로그램 신청
![image](https://user-images.githubusercontent.com/116352772/223402790-bfb66e7f-d436-4a72-b413-ef1dcde8bf02.png)

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


