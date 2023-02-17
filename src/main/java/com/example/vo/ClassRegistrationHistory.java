package com.example.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("ClassRegistrationHistory")
@Getter
@Setter
public class ClassRegistrationHistory {

	private String no; 
	private int userNo;
	private int programNo;
	private String paymentStatus;
	private int totalPrice;
	private int paymentType;
	private int totalDiscountPrice;
	private int totalPaymentPrice;
	private Date paymentCompletedDate;
	private Date createdDate;
	private Date updatedDate;
}
