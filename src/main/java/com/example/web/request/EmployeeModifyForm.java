package com.example.web.request;

import java.util.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EmployeeModifyForm {

	private String id;
	
	@NotBlank(message = "이름은 필수입력값입니다.")
	@Pattern(regexp = "^[가-힣]{2,}$", message = "이름은 한글 2글자 이상 입력하세요.")
	private String name;
	
	private String password;
	private String passwordConfirm;
	
	private String email;
	
	@NotBlank(message = "연락처는 필수입력값입니다.")
	@Pattern(regexp = "^\\d{2,3}-\\d{3,4}-\\d{4}$", message = "유효한 전화번호 형식이 아닙니다.")
	private String tel;
	
	@NotBlank(message = "우편번호는 필수입력값입니다.")
	private String zipcode;
	
	@NotBlank(message = "기본주소는 필수입력값입니다.")
	private String basicAddress;
	
	@NotBlank(message = "상세주소는 필수입력값입니다.")
	private String detailAddress;
	
	private String status;
	private Date updatedDate;
	private int fitnessNo;
	
	private MultipartFile upfile;
	private String photo;
}
