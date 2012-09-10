package com.tquila.dto;

import java.util.List;

import com.tquila.domain.Orders;


public class OrdersListDto {
	private List<Orders> orders;
	public List<Orders> getOrders() {
		return orders;
	}
	
	public void setOrders(List<Orders> orders) {
		this.orders = orders;
	}
}
