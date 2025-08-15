package com.pahana.model;

import java.sql.Date;

public class Customer {
	private int id;
	private String account_number;
	private String name;
	private String address;
	private String telephone_number;
	private Date created_at;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAccountNumber() {
		return account_number;
	}

	public void setAccountNumber(String accountNumber) {
		this.account_number = accountNumber;
	}
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTP() {
		return telephone_number;
	}

	public void setTP(String Tp) {
		this.telephone_number = Tp;
	}

	public Date getCreatedAt() {
		return created_at;
	}

	public void setCreatedAt(Date created_at) {
		this.created_at = created_at;
	}
}
