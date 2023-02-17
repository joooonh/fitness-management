package com.example.web.request;

import java.util.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserRegisterForm {

	private MultipartFile upfile; 
	private String photo;
	
	@NotBlank(message = "아이디는 필수입력값입니다.")
	@Pattern(regexp = "^[a-z0-9]{3,12}$", message = "* 아이디는 3~12자의 영문 소문자와 숫자로 입력하세요.")
	private String id; 
	
	@NotBlank(message = "비밀번호는 필수입력값입니다.")
	@Pattern(regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,20}", message = "* 비밀번호는 8~20자의 영문 대소문자와 숫자,특수문자를 각각 1개 이상 입력하세요.")
	private String encryptPassword;
	
	@NotBlank(message = "비밀번호는 필수입력값입니다.")
	@Pattern(regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,20}", message = "* 비밀번호는 8~20자의 영문 대소문자와 숫자,특수문자를 각각 1개 이상 입력하세요.")
	private String passwordConfirm;
	
	@NotBlank(message = "이름은 필수입력값입니다.")
	@Pattern(regexp = "^[가-힣]{2,}$", message = "* 이름은 한글 2글자 이상 입력하세요.")
	private String name; 
	
	@NotEmpty(message = "성별은 필수입력값입니다.")
	private String gender; 
	
	@NotNull(message = "생년월일은 필수입력값입니다.")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Past
	private Date birth;
	
	@NotBlank(message = "이메일은 필수입력값입니다.")
	@Email(message = "유효한 이메일 형식이 아닙니다.")
	private String email;
	
	@NotBlank(message = "연락처는 필수입력값입니다.")
	@Pattern(regexp = "^\\d{2,3}-\\d{3,4}-\\d{4}$", message = "유효한 전화번호 형식이 아닙니다.")
	private String tel;
	
	@NotBlank(message = "우편번호는 필수입력값입니다.")
	private String zipcode;
	
	@NotBlank(message = "기본주소는 필수입력값입니다.")
	private String basicAddr;
	
	@NotBlank(message = "상세주소는 필수입력값입니다.")
	private String detailAddr;
	
}
