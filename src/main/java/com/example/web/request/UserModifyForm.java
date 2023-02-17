package com.example.web.request;

import java.util.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserModifyForm {

	private MultipartFile upfile;
	private String photo;
	
	private int no;
	private String id;
	private String name;
	private String gender;
	private String email;
	
	@NotBlank(message = "비밀번호는 필수입력값입니다.")
	@Pattern(regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,20}", message = "* 비밀번호는 8~20자의 영문 대소문자와 숫자,특수문자를 각각 1개 이상 입력하세요.")
	private String password;
	
	@NotBlank(message = "비밀번호 확인은 필수입력값입니다.")
	@Pattern(regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,20}", message = "* 비밀번호는 8~20자의 영문 대소문자와 숫자,특수문자를 각각 1개 이상 입력하세요.")
	private String passwordConfirm;
	
	@NotNull(message = "생년월일은 필수입력값입니다.")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Past
	private Date birth;
	
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
