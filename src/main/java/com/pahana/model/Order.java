package com.pahana.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Order {
	private int id;
	private int customer_id;
	private BigDecimal total_amount;
	private BigDecimal discount;
	private Timestamp created_at;
	private String customerName;

	// ID
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	// customerID
	public int getCustomerId() {
		return customer_id;
	}

	public void setCustomerId(int customer_id) {
		this.customer_id = customer_id;
	}

	// totalAmount
	public BigDecimal getTotalAmount() {
		return total_amount;
	}

	public void setTotalAmount(BigDecimal total_amount) {
		this.total_amount = total_amount;
	}

	// Discount
	public BigDecimal getDiscount() {
		return discount;
	}

	public void setDiscount(BigDecimal discount) {
		this.discount = discount;
	}

	// Created At
	public Timestamp getCreatedAt() {
		return created_at;
	}

	public void setCreatedAt(Timestamp created_at) {
		this.created_at = created_at;
	}
	
	

	public String getCustomerName() {
	    return customerName;
	}

	public void setCustomerName(String customerName) {
	    this.customerName = customerName;
	}


}
