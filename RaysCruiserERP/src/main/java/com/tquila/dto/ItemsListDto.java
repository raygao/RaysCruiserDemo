package com.tquila.dto;

import java.util.List;

import com.tquila.domain.Items;


public class ItemsListDto {
	private List<Items> items;
	public List<Items> getItems() {
		return items;
	}
	
	public void setItems(List<Items> items) {
		this.items = items;
	}
}
