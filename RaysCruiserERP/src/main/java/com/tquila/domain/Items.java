package com.tquila.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Items {
	@Id
	private String id;
	private String description;
	private String item_type_id; // this will be a @DBRef -> ItemType
	private String image_filename;
	private String name;
	private Integer price;
	private Integer quantity;
	
	//Define MongoDB name & suffixing 's' without renaming class with 's'
	
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImage_filename() {
		return image_filename;
	}
	public void setImage_filename(String image_filename) {
		this.image_filename = image_filename;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getItem_type_id() {
		return item_type_id;
	}
	public void setItem_type_id(String item_type_id) {
		this.item_type_id = item_type_id;
	}

}
