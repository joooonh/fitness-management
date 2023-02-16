package com.example.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Alias("MembershipHistory")
@Getter
@Setter
public class MembershipHistory {

	private String no;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	private int period;
	private String paymentStatus;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date createdDate;
	private Date updatedDate;
	private int totalPrice;
	private String paymentType;
	private int totalDiscountPrice;
	private int totalPaymentPrice;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date paymentCompletedDate;
	private int userNo;
	
}
