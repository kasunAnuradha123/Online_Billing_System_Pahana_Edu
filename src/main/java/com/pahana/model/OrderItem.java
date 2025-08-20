package com.pahana.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class OrderItem {
	private int id;
	private int order_id;
	private int item_id;
	private BigDecimal item_price;
	private int qty;
	private BigDecimal total;
	private Timestamp created_at;
	 private String itemName;
	// ID
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	// orderId
	public int getOrderId() {
		return order_id;
	}

	public void setOrderId(int order_id) {
		this.order_id = order_id;
	}

	// itemId
	public int getItemId() {
		return item_id;
	}

	public void setItemId(int item_id) {
		this.item_id = item_id;
	}

	// itemPrice
	public BigDecimal getItemPrice() {
		return item_price;
	}

	public void setItemPrice(BigDecimal item_price) {
		this.item_price = item_price;
	}

	// qty
	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}

	// itemPrice
	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	// Created At
	public Timestamp getCreatedAt() {
		return created_at;
	}

	public void setCreatedAt(Timestamp created_at) {
		this.created_at = created_at;
	}
	public String getItemName() { return itemName; }     // <-- ADD
    public void setItemName(String itemName) { this.itemName = itemName; }
	

	
}
